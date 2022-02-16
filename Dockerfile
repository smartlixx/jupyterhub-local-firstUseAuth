FROM jupyterhub/jupyterhub:latest

# DEBIAN_FRONTEND is set to avoid being asked for input and hang during build:
# https://anonoz.github.io/tech/2020/04/24/docker-build-stuck-tzdata.html
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install --yes \
        vim \
#        curl \
#        git \
#        sudo \
 && rm -rf /var/lib/apt/lists/*

RUN /usr/bin/python3 -m pip install --upgrade pip

RUN pip install jupyter \
        notebook \
        jupyterhub-firstuseauthenticator \
        numpy \
        pandas \
        xarray \
        netcdf4 \
        matplotlib
