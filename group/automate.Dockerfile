# Build an image that can do training and inference in SageMaker

FROM ubuntu:20.04

MAINTAINER iait_dhjj.iseg

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3-pip \
         python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python


# for running models and fetching data from SRD
RUN pip --no-cache-dir install scikit-learn==1.0.2
RUN pip --no-cache-dir install psycopg==3.0.9

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
# COPY models /opt/program
WORKDIR /opt/program
