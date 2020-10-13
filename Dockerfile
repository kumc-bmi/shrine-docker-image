FROM tomcat:8.5-jdk11

RUN wget https://repo.open.catalyst.harvard.edu/nexus/content/groups/public/net/shrine/shrine-api-war/3.0.0/shrine-api-war-3.0.0.war \
         -O /usr/local/tomcat/webapps/shrine-api.war

RUN mkdir -p /opt/shrine/
COPY context.xml /opt/shrine/tomcat/conf/
COPY shrine.conf /usr/local/tomcat/lib/

COPY init.sh .
ENTRYPOINT [ "/bin/bash", "init.sh" ]
