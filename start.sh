#!/bin/sh

python bento/bento_packer.py --model_path $MODEL_PATH
SAVED_PATH=$(bentoml get MnistService:latest --print-location --quiet)
bentoml serve $SAVED_PATH