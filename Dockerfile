FROM python:3.8.0-slim as builder

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         nginx \
         ca-certificates \
         git \
         git-lfs \
    && rm -rf /var/lib/apt/lists/*


COPY ./requirements.txt .
RUN pip3 install -r requirements.txt 


COPY app ./opt/app

WORKDIR /opt/app

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/app:${PATH}"

## #1 - getting my repo
# RUN git lfs clone https://github.com/abudesai/rt_reg_base_random_forest.git ./model

## #2 -  getting the real HF model repo
# RUN git clone https://huggingface.co/distilbert-base-uncased ./model

## #3 - getting specific files because we only want to use pytorch, so no need to download tf or flax model files
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/README.md -P ./algorithm/model/pretrained_model
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/config.json -P ./algorithm/model/pretrained_model
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/tokenizer.json -P ./algorithm/model/pretrained_model
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/tokenizer_config.json -P ./algorithm/model/pretrained_model
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/vocab.txt -P ./algorithm/model/pretrained_model
# RUN wget https://huggingface.co/distilbert-base-uncased/resolve/main/pytorch_model.bin -P ./algorithm/model/pretrained_model


# #4 - same as #3 above except wget using url_list file which lists all the files for the distilbert model from HF
RUN wget -i ./algorithm/model/pretrained_model/url_list.txt -P ./algorithm/model/pretrained_model

RUN chmod +x test 