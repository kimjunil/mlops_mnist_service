#!/bin/sh

echo $MODEL_PATH
python bento/bento_packer.py --model_path $MODEL_PATH
SAVED_PATH=$(bentoml get MnistService:latest --print-location --quiet)
echo $SAVED_PATH
curl -X POST -H 'Content-type: application/json' --data '{"text":"배포가 완료되었습니다.\n<http://34.72.79.35/|Swagger>"}' $SLACK_WEBHOOK_URL
bentoml serve $SAVED_PATH