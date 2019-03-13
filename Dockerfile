FROM centos:centos7
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN yum -q -y install epel-release && \
    yum -q -y install ansible && \
    yum clean all

WORKDIR /opt/install

ADD inventory.yml \
    omero-buildenv.yml \
    requirements.yml \
    /opt/install/

RUN ansible-galaxy install -r requirements.yml -p roles && \
    ansible-playbook -i inventory.yml omero-buildenv.yml && \
    yum clean all

RUN cd /opt && \
    curl -fsSLO https://services.gradle.org/distributions/gradle-5.2.1-bin.zip && \
    unzip -q gradle-5.2.1-bin.zip && \
    rm gradle-5.2.1-bin.zip && \
    ln -s /opt/gradle-5.2.1/bin/gradle /usr/local/bin/gradle
# Needed for Gradle
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

# Other (hopefully temporary) workarounds

RUN yum -q -y install maven
# Never do this on a non-container system!
RUN pip install -U \
    'pip<10' \
    setuptools

WORKDIR /home/omero
#USER omero
EXPOSE 80 443 8080 4061 4063 4064
