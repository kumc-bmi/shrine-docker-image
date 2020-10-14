FROM tomcat:8.5-jdk11

RUN apt update && apt install -y python3-pip
RUN pip3 install jinja2

RUN wget -q https://repo.open.catalyst.harvard.edu/nexus/content/groups/public/net/shrine/shrine-api-war/3.0.0/shrine-api-war-3.0.0.war \
         -O /usr/local/tomcat/webapps/shrine-api.war

# default keystore location
RUN mkdir -p /opt/shrine

COPY context.xml.j2 /opt/templates/
COPY shrine.conf.j2 /opt/templates/

COPY template.py /usr/bin/
RUN chmod +x /usr/bin/template.py
COPY init.sh .
ENTRYPOINT [ "/bin/bash", "init.sh" ]
