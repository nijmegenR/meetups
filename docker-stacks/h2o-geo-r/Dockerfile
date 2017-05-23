# Copyright (c) Data Computing.
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM nijmegenr/h2o-geo

MAINTAINER Data Computing <info@datacomputing.nl>

USER $NB_USER

RUN wget https://cran.r-project.org/src/contrib/proto_1.0.0.tar.gz && \
    wget https://cran.r-project.org/src/contrib/png_0.1-7.tar.gz && \
    wget https://cran.r-project.org/src/contrib/RgoogleMaps_1.4.1.tar.gz && \
    wget https://cran.r-project.org/src/contrib/rjson_0.2.15.tar.gz && \
    wget https://cran.r-project.org/src/contrib/maps_3.1.1.tar.gz && \
    wget https://cran.r-project.org/src/contrib/mapproj_1.2-4.tar.gz && \
    wget https://cran.r-project.org/src/contrib/jpeg_0.1-8.tar.gz && \
    wget https://cran.r-project.org/src/contrib/sp_1.2-4.tar.gz && \
    wget https://cran.r-project.org/src/contrib/geosphere_1.5-5.tar.gz && \
    wget https://cran.r-project.org/src/contrib/ggmap_2.6.1.tar.gz && \
    R CMD INSTALL proto_1.0.0.tar.gz \
                  png_0.1-7.tar.gz \
                  RgoogleMaps_1.4.1.tar.gz \
                  rjson_0.2.15.tar.gz \
                  maps_3.1.1.tar.gz \
                  mapproj_1.2-4.tar.gz \
                  jpeg_0.1-8.tar.gz \
                  sp_1.2-4.tar.gz \
                  geosphere_1.5-5.tar.gz \
                  ggmap_2.6.1.tar.gz && \
    rm proto_1.0.0.tar.gz \
       png_0.1-7.tar.gz \
       RgoogleMaps_1.4.1.tar.gz \
       rjson_0.2.15.tar.gz \
       maps_3.1.1.tar.gz \
       mapproj_1.2-4.tar.gz \
       jpeg_0.1-8.tar.gz \
       sp_1.2-4.tar.gz \
       geosphere_1.5-5.tar.gz \
       ggmap_2.6.1.tar.gz
