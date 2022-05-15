ARG ELASTIC_VERSION

FROM docker.elastic.co/logstash/logstash:${ELASTIC_VERSION}
RUN logstash-plugin install logstash-filter-json
