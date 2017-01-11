# Copyright (c) Data Computing.
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM nijmegenr/data-science

MAINTAINER Data Computing <info@datacomputing.nl>

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER
# First install packages from 'defaults'
RUN conda config --add channels conda-forge && \
    conda install --quiet --yes \
       'fiona=1.7.*' \
       'geos=3.5.0' \
       'psycopg2' \
       'pyproj' \
       'pysal' \
       'shapely' \
       'geopandas=0.2.*'

# R packages including IRKernel which gets installed globally.
# Pin r-base to a specific build number for https://github.com/jupyter/docker-stacks/issues/210#issuecomment-246081809
RUN conda config --add channels r && \
    conda install --quiet --yes \
       'r-maptools=0.8*' \
       'r-mapproj=1.2*' \
       'r-maps=3.1.*' \
       'r-spatial=7.3*' && \
    conda clean -tipsy && \
    rm -rf $HOME/.local


