import playground
from imageserver import IMAGE_PROTOCOL, IMAGE_SERVER, IMAGE_HEADERS

import io
import requests
import json
import logging
import multiprocessing
from functools import partial
from defusedxml.ElementTree import fromstring as parsexml
import xml.etree.ElementTree as ElementTree
import numpy as np
from flask import Response, Blueprint, jsonify, make_response, render_template, request, send_file
from PIL import Image

bp = Blueprint("home", __name__)
log = logging.getLogger("playground")

@bp.route("/")
def home():
    """Send index page"""
    return render_template("index.html")

    
@bp.route("/init/<string:algorithm>")
def initialize(algorithm):
    """Send initialization to the image server OR show welcome page"""
   
    param = request.args.get("Deepzoom")
    log.debug(f"Received /init request over image '{param}', algorithm '{algorithm}'")

    imagemeta = None
    try:
        imagemeta = requests.get(f"{IMAGE_PROTOCOL}{IMAGE_SERVER}?Deepzoom={param}", headers=IMAGE_HEADERS)
    except Exception as e:
        return make_response(f"Error: could not forward request to {IMAGE_PROTOCOL}{IMAGE_SERVER}?Deepzoom={param}: {e}", 500)
    
    if imagemeta.status_code != 200:
        return make_response(imagemeta.text, imagemeta.status_code)
     
    xml = ""
    try:
        ElementTree.register_namespace("", "http://schemas.microsoft.com/deepzoom/2008")
        root = parsexml(imagemeta.text)
        playground.init(algorithm)
        root.append(ElementTree.Element("Report", )) 
        xml = ElementTree.tostring(root, encoding='unicode')  
    except ElementTree.ParseError:
        xml = imagemeta.text  
    except Exception as e: #todo make custom exception to really relay meaningful messages only, this can catch anything :/
        xml = f"<Error><Message>{e}</Message></Error>"
  
    r = Response(response=xml, status=200, mimetype="application/xml")
    r.headers["Content-Type"] = "text/xml; charset=utf-8"
    return r    
    

@bp.route("/algorithm/<string:algorithm>", methods=["GET"])
def explainability(algorithm):
    param = request.args.get("Deepzoom")
    
    log.debug(f"Processing {algorithm}::{param}'")
    imagedata = None
    try:
        imagedata = requests.get(f"{IMAGE_PROTOCOL}{IMAGE_SERVER}?Deepzoom={param}", headers=IMAGE_HEADERS)
    except Exception:
        return make_response(f"Error: could not forward request to {IMAGE_PROTOCOL}{IMAGE_SERVER}?Deepzoom={param}", 500)
    
    if imagedata.status_code != 200:
        return make_response(imagedata.text, imagedata.status_code)
    
    #Send the image without any processing: (if you want debug)
    #response = make_response(imagedata.content)
    #response.headers.set('Content-Type', 'image/PNG') #the format should match, e.g. if you work with jpg change this
    #return response
    
    output = None
    # Run the method in separate process (GPU is freed at the end)
    with multiprocessing.Pool(1) as pool:
        try:
            arr = np.array(Image.open(io.BytesIO(imagedata.content)))
            output = playground.process(algorithm, arr)
            if output.shape[0] != arr.shape[0] or output.shape[1] != arr.shape[1]:
                raise Exception('Invalid dimensions of the result.')
        except ValueError as e:
            log.exception(e)
            make_response(str(e), 422)
#        except InternalError):
#            return make_response(
#                "Too many requests in short time. Take a break (cca 1-2 sec) between "
#                "requests.",
#                503,
#            )
        except Exception as e:
            log.exception(e)
            return make_response(f"Error at the server: {e}", 500)

    file_object = np_array_to_image(output)
    # Prepare the response
    resp = make_response(send_file(file_object, mimetype="image/PNG"))
    return resp


def np_array_to_image(arr: np.ndarray):
#    response = make_response(arr)
#    response.headers.set('Content-Type', 'image/PNG')
#    return response
    """Convert NumPy array to PNG for sending in a response to frontend.

    Parameters
    ----------
    arr
        array to be converted

    Returns
    -------
    array as a PNG in a file object
    """
    img = Image.fromarray(arr.astype("uint8"))
    file_object = io.BytesIO()
    img.save(file_object, "PNG")
    file_object.seek(0)
    return file_object
    