FROM debian:10-slim AS build

RUN apt-get update && apt-get install -y tar

WORKDIR /aliyun

ADD https://github.com/aliyun/aliyun-cli/releases/download/v3.0.22/aliyun-cli-linux-3.0.22-amd64.tgz .

RUN tar -xzvf aliyun-cli-linux-3.0.22-amd64.tgz
RUN mv aliyun /usr/local/bin/aliyun

# ---

FROM debian:10-slim
RUN apt-get update && apt-get install -y ca-certificates
RUN update-ca-certificates
COPY --from=build /usr/local/bin/aliyun /usr/local/bin/aliyun
WORKDIR /usr/local/bin
ENTRYPOINT [ "aliyun" ]
