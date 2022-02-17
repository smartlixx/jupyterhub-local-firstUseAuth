FROM jupyterhub/jupyterhub:latest
MAINTAINER Li Xianxiang <smartlixx@gmail.com>

# DEBIAN_FRONTEND is set to avoid being asked for input and hang during build:
# https://anonoz.github.io/tech/2020/04/24/docker-build-stuck-tzdata.html
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install --yes \
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
 && pip install shapely --no-binary shapely \
 && pip install jupyter \
        notebook \
        jupyterhub-firstuseauthenticator \
        numpy \
        pandas \
        xarray \
        netcdf4 \
        matplotlib \
        cartopy====0.19.0.post1 \
        nbgrader \
        
# Set nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
 && jupyter nbextension enable --sys-prefix --py nbgrader \
 && jupyter serverextension  enable --sys-prefix --py nbgrader
