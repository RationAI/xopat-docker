# Histoviso-Explain

Backend for Histoviso explainability plugin.

## Structure

Histoviso-Explain is a Flask app with following structure:

- `models` - contains configs for available models
- `rationai/histoviso_explain` - main package folder
  - `static` and `templates` - debug frontend
  - Flask app factory is in `__init__.py`
  - `routes.py` - defines the API routes and calls other functionality in separate processes
  - `explainability.py` - contains the core functionality of the tool -- the explainability methods
- `app.py` - entrypoint for development server
- `config.py` - configuration file for the Flask app
- `setup.py` - makes the package installable via `pip`

## Instalation

Create a virtual environment of your choice and then install the requirements:

```shell
(venv) $ pip install -r requirements.txt
```

Currently, Histopat's branch `ref-histoviso-explain` is required (commit histopat@f13cdb1d), see `requirements.txt`. Then you have to generate your _secret key_. Output of the command:

```shell
(venv) $ python -c 'import secrets; print(secrets.token_hex())'
```

save into a `.flaskenv` file in the form: `SECRET_KEY='<generated_secret_key>'`.

## Run development server

Simply run following command in the root folder.

```shell
(venv) $ python app.py
```

And the backend will be on and listening on <http://127.0.0.1:5000/>. There is also a debug frontend for development purposes.

## Run production server

To start a production server listening on localhost, run:

```shell
(venv) $ gunicorn -b 127.0.0.1:5000 "rationai.histoviso_explain:init_app()" --timeout 90
```

## API

There are currently supported these routes:

- `/layers-info/<string:model_name>` (GET) - Expects a string with name of a model; returns a JSON with names of conv layers of the model (VGG16 backbone) as keys and number of feature maps per layer as values.
- `/available-expl-methods` (GET) - Provides info about supported explainability methods and their parameters as a JSON.
- `/top-feature-maps` (POST) - For a given selected region gives top N most activated feature maps per layer in a JSON.
  
```json
example_params = {
    "slide_name": "TP-2019_7488-05-1",
    "coords": {
        "x1": 75000,
        "y1": 25000,
        "x2": 80000,
        "y2": 27000,
    },
    "params": {
        "model_name": "VGG16-TF2-DATASET-e95b-4e8f-aeea-b87904166a69",
        "batch_size": 1,
        "top_n": 5
    }
}
```

- `/explainability` (POST) - Universal endpoint for all explainability methods. Expects a dict with params and returns a png image (grayscale).

```json
example_params = {
    "slide_name": "TP-2019_7488-05-1",
    "coords": {
        "x1": 75000,
        "y1": 25000,
        "x2": 80000,
        "y2": 27000,
    },
    "expl_method": "feature_map",
    "expl_params": {
        "layer_name": "block5_conv3",
        "feature_map_id": 419,
        "model_name": "VGG16-TF2-DATASET-e95b-4e8f-aeea-b87904166a69"
    }
}
```

Only supported model right now is the `VGG16-TF2-DATASET-e95b-4e8f-aeea-b87904166a69`. Various explainability methods (`expl_method`) may have different params (`expl_params`). Basic examples of usage can be seen in `rationai/histoviso_explain/static/button.js`.

### List of supported explainability methods

For detailed information about the parameters, please check the code (`rationai/histoviso_explain/explainability.py`) or `/available-expl-methods`.

#### Feature map

- name: `feature_map`
- params:
  - `layer_name`: string (get info about possible layer names from `/layers-info/<string:model_name>`)
  - `model_name`: string (only `VGG16-TF2-DATASET-e95b-4e8f-aeea-b87904166a69` is supported currently)
  - `feature_map_id`: int (depends on `layer_name`)
  - `postprocess`: boolean (whether to apply cloasing and gaussian filter to the final image)

#### Saliency (Vanilla or SmoothGrad)

- name: `saliency`
- params:
  - `layer_name`: string (same as feature_map)
  - `model_name`: string (same as feature_map)
  - `feature_map_id`: int (same as feature_map)
  - `loss_modifier`: string (names of methods in `rationai/histoviso_explain/loss_modifiers.py`)
  - `smooth_samples`: int
  - `smooth_noise`: float
  - `postprocess`: boolean (same as feature_map)
  
_Loss_ function specifies how the output of a feature map is modified (aggregated) for gradient calculation. Default value is identity which keeps the feature map as it is and computes the gradients of a sum of the full feature map.

_Smooth samples_ and _smooth noise_ tells the backend to use SmoothGrad instead of Vanilla Saliency. Default value is 0 which indicates Vanilla Saliency. For SmoothGrad start with _smooth samples_ = 5 and _smooth noise_ = 0.1.

[tf-keras-vis](https://github.com/keisen/tf-keras-vis) toolkit was used for Saliency maps. Check it for more info.

#### Grad-CAM

- name: `gradcam`
- params:
  - `layer_name`: string (same as feature_map)
  - `model_name`: string (same as feature_map)
  - `feature_map_id`: int (same as feature_map)
  - `loss_modifier`: string (names of methods in `rationai/histoviso_explain/loss_modifiers.py`)
  - `postprocess`: boolean (same as feature_map)
  - `target_layer`: int

_Target layer_ is relative distance from `layer_name` to the layer from which should be composed the class activation map. Counts only conv layers (skips pooling etc.) -- e.g., in VGG16, `layer_name = 'block5_conv3` and `target_layer = -1` -> `block5_conv2`; `layer_name = 'block5_conv3` and `target_layer = -4` -> `block4_conv2`.

[tf-keras-vis](https://github.com/keisen/tf-keras-vis) toolkit was used for Grad-CAM. Check it for more info.

### Notes

New coordinates of the response image (`explainability`) are passed in the response header in `new_coords`.

`CUDA_VISIBLE_DEVICES` is set to "1". Whole code is written for Glados machine, including paths etc. If the GPU:1 is free, all computations are executed there and is released after a request is served and response is sent. If the GPU is occupied (by another request or any other computations on the server), request is served using CPU. GPU:0 should not be ever used by `histoviso-explain`.
