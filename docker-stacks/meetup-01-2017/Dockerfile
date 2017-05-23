# Copyright (c) Data Computing.
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM nijmegenr/h2o-geo-r

MAINTAINER Data Computing <info@datacomputing.nl>

USER $NB_USER

RUN cd && cd work && \
    wget -nc https://github.com/nijmegenR/meetups/raw/master/2017-01-25-meetINN-meetup/data.zip && \
    wget -nc https://github.com/nijmegenR/meetups/raw/master/2017-01-25-meetINN-meetup/readShapes.R && \
    wget -nc https://github.com/nijmegenR/meetups/raw/master/2017-01-25-meetINN-meetup/CBS-crime.ipynb && \
    wget -nc https://github.com/nijmegenR/meetups/raw/master/2017-01-25-meetINN-meetup/MeetinAssignments.ipynb
