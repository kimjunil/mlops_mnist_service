#!/bin/sh

echo $MODEL_PATH
python bento/bento_packer.py --model_path $MODEL_PATH
SAVED_PATH=$(bentoml get MnistService:latest --print-location --quiet)
echo $SAVED_PATH
bentoml serve $SAVED_PATH