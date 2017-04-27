FROM teamcity-base:latest
MAINTAINER Kateryna Shlyakhovetska <shkate@jetbrains.com>

ENV TEAMCITY_DATA_PATH=/data/teamcity_server/datadir \
    TEAMCITY_DIST=/opt/teamcity \
    TEAMCITY_LOGS=/opt/teamcity/logs

EXPOSE 8111
LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"
RUN /usr/bin/curl -O -L https://download.jetbrains.com/teamcity/TeamCity-10.0.5.tar.gz && \
     mkdir dist && \
     tar zxf TeamCity-10.0.5.tar.gz -C dist/ && \
     mv dist/TeamCity /opt/teamcity
COPY run-services.sh /run-services.sh
RUN chmod +x /run-services.sh && \
    mv /opt/teamcity/webapps/ROOT /opt/teamcity/webapps/teamcity

VOLUME $TEAMCITY_DATA_PATH \
       $TEAMCITY_LOGS

CMD ["/run-services.sh"]
