FROM tensorflow/tensorflow

ARG MODEL_PATH_ARG
ENV MODEL_PATH=${MODEL_PATH_ARG}

ARG SLACK_WEBHOOK_URL_ARG
ENV SLACK_WEBHOOK_URL=${SLACK_WEBHOOK_URL_ARG}

WORKDIR /root

RUN pip install tensorflow imageio bentoml pillow

RUN mkdir /root/bento
COPY bento_packer.py /root/bento/bento_packer.py
COPY bento_service.py /root/bento/bento_service.py
COPY start.sh /scripts/start.sh

RUN ["chmod", "+x", "/scripts/start.sh"]
ENTRYPOINT ["/scripts/start.sh"]