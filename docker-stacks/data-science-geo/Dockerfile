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
       'jpeg=8*' \
       'fiona=1.7.*' \
       'geos=3.5.0' \
       'psycopg2' \
       'pyproj' \
       'pysal' \
       'shapely' \
       'geopandas=0.2.*' && \
    conda clean -tipsy && \
    rm -rf $HOME/.local

