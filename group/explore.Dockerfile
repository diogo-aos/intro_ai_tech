# Build an image that can do training and inference in SageMaker

FROM ubuntu:20.04

MAINTAINER dhjj.io


RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3-pip \
         python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# for data exploration
RUN pip --no-cache-dir install numpy==1.22.3
RUN pip --no-cache-dir install scipy==1.8.0
RUN pip --no-cache-dir install scikit-learn==1.0.2
RUN pip --no-cache-dir install pandas==1.4.1
RUN pip --no-cache-dir install matplotlib==3.5.1
RUN pip --no-cache-dir install seaborn==0.11.2
RUN pip --no-cache-dir install keras==2.8.0
RUN pip --no-cache-dir install tensorflow==2.8.0
RUN pip --no-cache-dir install psycopg==3.0.9
RUN pip --no-cache-dir install jupyterlab==3.3.0
RUN pip --no-cache-dir install statsmodels==0.13.2


# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE

# mount the data in the /data root folder, working dir set by default there
WORKDIR /data
