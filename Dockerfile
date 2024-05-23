<<<<<<< HEAD
<<<<<<< HEAD
FROM golang:1.21-alpine3.19 AS fabconnect-builder
=======
=======
>>>>>>> 3a3c7af (Merge pull request #125 from hyperledger/base_image)
ARG BASE_IMAGE
ARG BUILD_IMAGE

FROM ${BUILD_IMAGE} AS fabconnect-builder
<<<<<<< HEAD
>>>>>>> 66e0aba (Add build image arg)
=======
>>>>>>> 3a3c7af (Merge pull request #125 from hyperledger/base_image)
RUN apk add make
ADD . /fabconnect
WORKDIR /fabconnect
RUN mkdir /.cache \
    && chgrp -R 0 /.cache \
    && chmod -R g+rwX /.cache
RUN make

<<<<<<< HEAD
FROM alpine:3.19
=======
FROM alpine:3.19 AS SBOM
WORKDIR /
COPY . /SBOM
RUN apk add --no-cache curl
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.48.3
RUN trivy fs --format spdx-json --output /sbom.spdx.json /SBOM
RUN trivy sbom /sbom.spdx.json --severity UNKNOWN,HIGH,CRITICAL --exit-code 1 --ignorefile /SBOM/.trivyignore

FROM $BASE_IMAGE
>>>>>>> 3a3c7af (Merge pull request #125 from hyperledger/base_image)
RUN apk add curl
WORKDIR /fabconnect
COPY --from=fabconnect-builder /fabconnect/fabconnect ./
ADD ./openapi ./openapi/
RUN ln -s /fabconnect/fabconnect /usr/bin/fabconnect
ENTRYPOINT [ "fabconnect" ]
