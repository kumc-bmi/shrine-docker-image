#!/usr/bin/python3

import os

from jinja2 import Environment, FileSystemLoader

file_loader = FileSystemLoader('/opt/templates')
env = Environment(loader=file_loader)

template = env.get_template('shrine.conf.j2')
output = template.render(keystore_password=os.environ['SHRINE_KEYSTORE_PASSWORD']) # noqa
f = open("/usr/local/tomcat/lib/shrine.conf", "w")
f.write(output)
f.close()
