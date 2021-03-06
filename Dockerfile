FROM debian:jessie
MAINTAINER Viktor Farcic "viktor@farcic.com"

# Packages
RUN add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends openjdk-8-jdk mongodb && \
    update-alternatives --config java && \
    update-alternatives --config javac && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# MongoDB files
RUN mkdir -p /data/db
VOLUME ["/data/db"]

# Service
ADD target/scala-2.10/books-service-assembly-1.0.jar /bs.jar
ADD client/components /client/components

# Default command
ENV DB_DBNAME books
ENV DB_COLLECTION books
ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]

EXPOSE 8080
