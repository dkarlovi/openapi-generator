ARG BASE_DOCKER_IMAGE
ARG GENERATOR_DOCKER_IMAGE
FROM ${GENERATOR_DOCKER_IMAGE} AS openapi-generator

FROM ${BASE_DOCKER_IMAGE} AS generator
RUN apk add --no-cache \
        bash \
        jq \
        openjdk8-jre-base
COPY --from=openapi-generator /opt/openapi-generator /opt/openapi-generator
COPY docker/openapi-generator /usr/local/bin/
RUN mkdir -p /opt/openapi-generator/generator/bin /opt/openapi-generator/generator/overwrite /opt/openapi-generator/generator/templates
ENTRYPOINT ["/usr/local/bin/openapi-generator"]
