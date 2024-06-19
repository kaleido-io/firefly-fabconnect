FROM golang:1.22-bullseye AS fabconnect-builder
RUN apt install make
ADD . /fabconnect
WORKDIR /fabconnect
RUN mkdir /.cache \
    && chgrp -R 0 /.cache \
    && chmod -R g+rwX /.cache
RUN make

FROM alpine:3.19 AS SBOM
WORKDIR /
COPY . /SBOM
RUN apk add --no-cache curl
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.48.3
RUN trivy fs --format spdx-json --output /sbom.spdx.json /SBOM
RUN trivy sbom /sbom.spdx.json --severity UNKNOWN,HIGH,CRITICAL --exit-code 1 --ignorefile /SBOM/.trivyignore

FROM 604386504253.dkr.ecr.us-east-2.amazonaws.com/kaleido/base
WORKDIR /fabconnect
RUN chgrp -R 0 /fabconnect/ \
    && chmod -R g+rwX /fabconnect/
COPY --from=fabconnect-builder --chown=1001:0  /fabconnect/fabconnect ./
ADD ./openapi ./openapi/
RUN ln -s /fabconnect/fabconnect /usr/bin/fabconnect
COPY --from=SBOM /sbom.spdx.json /sbom.spdx.json
COPY --from=SBOM /SBOM/.trivyignore /.trivyignore
USER 1001
ENTRYPOINT [ "fabconnect" ]
