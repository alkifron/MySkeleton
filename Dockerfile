#  docker image build --target release --tag docker4skeleton .

FROM maven:3.8.2-jdk-11 AS builder
COPY pom.xml /
COPY .m2/settings.xml /.m2/settings.xml
# COPY llvm.sh /
# COPY oclint.sh /

FROM builder AS ci
  RUN ls -l /.m2
  RUN echo ${SONAR_HOST_URL} ${SONAR_PROJECT_KEY}
  RUN mvn -s .m2/settings.xml --batch-mode test
  RUN mvn -s .m2/settings.xml --batch-mode  -Dsonar.projectKey=${SONAR_PROJECT_KEY} verify sonar:sonar
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


