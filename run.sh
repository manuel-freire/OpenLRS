#!/bin/bash

# OpenLRS relies on Redis and ElasticSearch
#   This script, intended to be run from within docker compose, tells 
#   OpenLRS where to find each of those servers

# expects something like REDIS_PORT_6379_TCP_ADDR=172.17.0.6
R_PROPFILE=./src/main/resources/application-redis.properties
R_HOST=${REDIS_PORT_6379_TCP_ADDR}

# expects something like ELASTIC_PORT_9300_TCP=tcp://172.17.0.5:9300
#   and strips out the tcp:// from the start
#   note that ELASTIC_PORT=tcp://172.17.0.5:9200 refers to the REST interface
#   the native transport protocol goes over 9300
E_PROPFILE=./src/main/resources/application-elasticsearch.properties
E_HOST=${ELASTIC_PORT_9300_TCP/*\//}

echo "Redis should be at: $R_HOST"
echo "spring.redis.host=${R_HOST}" >> ${R_PROPFILE}

echo "ElasticSearch should be at: $E_HOST"
echo "spring.data.elasticsearch.cluster-nodes=${E_HOST}" > ${E_PROPFILE}

mvn spring-boot:run -Drun.jvmArguments="-Dspring.config.location=./src/main/resources/application-dev.properties"
