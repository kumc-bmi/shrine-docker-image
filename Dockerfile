FROM tomcat:8.5-jdk11

RUN apt update && apt install -y python3-pip
RUN pip3 install jinja2

RUN wget -q https://repo.open.catalyst.harvard.edu/nexus/content/groups/public/net/shrine/shrine-api-war/3.0.0/shrine-api-war-3.0.0.war \
         -O /usr/local/tomcat/webapps/shrine-api.war

# default keystore location
RUN mkdir -p /opt/shrine

COPY templates/ /opt/templates/

COPY configure_templates.py /usr/bin/
RUN chmod +x /usr/bin/configure_templates.py
COPY init.sh .
ENTRYPOINT [ "/bin/bash", "init.sh" ]
