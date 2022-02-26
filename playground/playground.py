import numpy as np


def init(algorithm: str) -> dict:
    """
    Return configuration for your algorithm:
    a dictionary of "parameter name" -> "parameter type" mapping
    (no nested elements allowed, use strings only).
    
    Throw in case the initialization is not able to finish, for some reason,
    and provide meaningful text description
    """
    return {}


def process(algorithm: str, image: np.ndarray) -> np.ndarray:
    """
    The image is given to you as numpy array and so it should be returned
    unfortunately, you cannot have any overlap (unless you fetch the data yourself)
    for now, and this method should always return a valid array with the equal shape
    
    Example: erasing green channel in the image
    """
    image[:,:,1] = np.zeros([image.shape[0], image.shape[1]])
    return image
