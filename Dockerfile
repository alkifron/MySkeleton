#  docker image build --target release --tag docker4skeleton .

FROM maven:3.8.2-jdk-11 AS builder
COPY pom.xml /
# COPY llvm.sh /
# COPY oclint.sh /

FROM builder AS ci
  RUN mvn test
  RUN mvn verify sonar:sonar
# RUN apt-get update -y \
#    && apt-get install -y python3-pip python3-sphinx  -y --no-install-recommends \
#    && pip3 install --no-cache-dir coverage anybadge pylint pylint-exit flake8 twine \
#    && apt-get clean -y \
#    && rm -rf /var/lib/apt/lists/*

# FROM builder AS release
# COPY setup.py /
# COPY README.md /
# COPY fact /fact
# RUN python setup.py install

