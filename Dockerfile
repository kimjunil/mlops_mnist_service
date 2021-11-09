FROM tensorflow/tensorflow

ARG model_path

WORKDIR /root

RUN mkdir /root/bento
COPY bento_packer.py /root/bento/bento_packer.py
COPY bento_service.py /root/bento/bento_service.py

RUN python bento/bento_packer.py --model_path ${model_path}
RUN saved_path=$(bentoml get MnistService:latest --print-location --quiet)
# Sets up the entry point to invoke the trainer.\
ENTRYPOINT ["bentoml", "serve", $saved_path]