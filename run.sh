#!/bin/bash

# see docker-compose run <container> env to see all

R_PROPFILE=./src/main/resources/application-redis.properties
R_HOST=${REDIS_PORT/*\//}
R_HOST=${R_HOST/:*/}

E_PROPFILE=./src/main/resources/application-elasticsearch.properties
E_HOST=${ELASTIC_PORT/*\//}

echo "Redis should be at: $R_HOST"
echo "spring.redis.host=${R_HOST}" >> ${R_PROPFILE}

echo "ElasticSearch should be at: $E_HOST"
echo "spring.data.elasticsearch.cluster-nodes=${E_HOST}" > ${E_PROPFILE}

mvn spring-boot:run -Drun.jvmArguments="-Dspring.config.location=./src/main/resources/application-dev.properties"
