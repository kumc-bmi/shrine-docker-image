FROM tomcat:9.0.69-jdk17-corretto-al2

RUN apt update && apt install -y python3-pip tzdata,postfix,ntp
RUN systemctl start ntpd && systemctl enable ntpd
RUN pip3 install jinja2

RUN wget -q https://repo.open.catalyst.harvard.edu/nexus/content/groups/public/net/shrine/shrine-api-war/4.0.0/shrine-api-war-4.0.0.war \
         -O /usr/local/tomcat/webapps/shrine-api.war

# default keystore location
RUN mkdir -p /opt/shrine

# load lucene indices into default location
RUN mkdir -p /usr/local/shrine/conf &&\
    cd /usr/local/shrine/conf &&\
    wget https://shrine-act-artifacts.s3.amazonaws.com/lucene-indices/lucene_index-2.0.1-cov3-07-14-2020.zip -O lucene_index.zip &&\
    wget https://shrine-act-artifacts.s3.amazonaws.com/lucene-indices/suggest_index-2.0.1-cov3-07-14-2020.zip -O suggest_index.zip &&\
    unzip lucene_index.zip &&\
    unzip suggest_index.zip &&\
    rm lucene_index.zip suggest_index.zip

COPY templates/ /opt/templates/

COPY configure_templates.py /usr/bin/
RUN chmod +x /usr/bin/configure_templates.py
COPY init.sh .
ENTRYPOINT [ "/bin/bash", "init.sh" ]
