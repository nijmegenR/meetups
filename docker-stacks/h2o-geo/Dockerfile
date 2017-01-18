# Copyright (c) Data Computing.
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM nijmegenr/data-science-geo

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
       'h2o' \
       'h2o-py' && \
    conda clean -tipsy && \
    rm -rf $HOME/.local

RUN wget https://cran.r-project.org/src/contrib/statmod_1.4.27.tar.gz && \
    wget https://cran.r-project.org/src/contrib/h2o_3.10.2.2.tar.gz && \
    R CMD INSTALL statmod_1.4.27.tar.gz h2o_3.10.2.2.tar.gz && \
    rm statmod_1.4.27.tar.gz h2o_3.10.2.2.tar.gz

