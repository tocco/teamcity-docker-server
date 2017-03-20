FROM teamcity-base:latest
MAINTAINER Kateryna Shlyakhovetska <shkate@jetbrains.com>

ENV TEAMCITY_DATA_PATH=/data/teamcity_server/datadir \
    TEAMCITY_DIST=/opt/teamcity \
    TEAMCITY_LOGS=/opt/teamcity/logs

EXPOSE 8111
LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

COPY run-services.sh /run-services.sh
COPY dist/teamcity $TEAMCITY_DIST
RUN chmod +x /run-services.sh && \
    mv /opt/teamcity/tomcat/webapps/ROOT /opt/teamcity/tomcat/webapps/teamcity

VOLUME $TEAMCITY_DATA_PATH \
       $TEAMCITY_LOGS

CMD ["/run-services.sh"]
