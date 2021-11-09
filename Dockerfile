FROM tensorflow/tensorflow

ARG MODEL_PATH_ARG
ENV MODEL_PATH = ${MODEL_PATH_ARG}

WORKDIR /root

RUN pip install bentoml pillow

RUN mkdir /root/bento
COPY bento_packer.py /root/bento/bento_packer.py
COPY bento_service.py /root/bento/bento_service.py
COPY start.sh /scripts/start.sh

RUN ["chmod", "+x", "/scripts/start.sh"]
ENTRYPOINT ["/scripts/start.sh"]