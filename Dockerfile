FROM jupyterhub/jupyterhub:latest
MAINTAINER Li Xianxiang <smartlixx@gmail.com>

# DEBIAN_FRONTEND is set to avoid being asked for input and hang during build:
# https://anonoz.github.io/tech/2020/04/24/docker-build-stuck-tzdata.html
RUN apt-get -y update  && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install --no-install-recommends \
        python3 \
        python3-dev \
        vim \
        proj-bin \
        libproj-dev \
        libgeos-dev \
        gcc \
        g++ \
 && rm -rf /var/lib/apt/lists/*
 
# Set timezone to Beijing standard time
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN /usr/bin/python3 -m pip install --upgrade pip \
 && pip install --no-cache-dir shapely --no-binary shapely \
 && pip install --no-cache-dir \
        jupyter \
        notebook \
        jupyterhub-firstuseauthenticator \
        jupyterhub-idle-culler \
        numpy \
        pandas \
        xarray \
        netcdf4 \
        matplotlib \
        cartopy==0.19.0.post1 \
        nbgrader
        
# Set nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
 && jupyter nbextension enable --sys-prefix --py nbgrader \
 && jupyter serverextension  enable --sys-prefix --py nbgrader
