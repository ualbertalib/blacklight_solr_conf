FROM solr:6.6
LABEL maintainer="University of Alberta Libraries"
COPY ./solr/blacklight-core/conf /myconfig
COPY ./solr/lib /opt/solr/lib
CMD ["solr-precreate", "discovery", "/myconfig"]
