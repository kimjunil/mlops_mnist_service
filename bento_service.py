from typing import List

import numpy as np
import tensorflow as tf
from PIL import Image
from bentoml import api, artifacts, env, BentoService
from bentoml.frameworks.keras import KerasModelArtifact
from bentoml.adapters import ImageInput

MNIST_CLASSES = [str(x) for x in range(10)]
               
@env(pip_packages=["tensorflow==2.7.0", "pillow", "numpy"])
@artifacts([KerasModelArtifact("model")])
class MnistService(BentoService):
    @api(input=ImageInput(pilmode="L"), batch=True)
    def predict(self, imgs: List[np.ndarray]) -> List[str]:
        inputs = []
        for img in imgs:
            img = Image.fromarray(img).resize((28, 28))
            img = np.array(img.getdata()).reshape((28, 28, 1))
            inputs.append(img)
        inputs = np.stack(inputs)
        output = self.artifacts.model.predict(inputs)
        
        return np.round(output, 10)
