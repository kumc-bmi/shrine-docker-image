#!/usr/bin/python3

import os

from jinja2 import Environment, FileSystemLoader

file_loader = FileSystemLoader('/opt/templates')
env = Environment(loader=file_loader)

template = env.get_template('shrine.conf.j2')
output = template.render(shrineDatabaseType=os.environ['SHRINE_DB_TYPE'],
                         hive_password=os.environ['SHRINE_HIVE_PASSWORD'],
                         keystore_password=os.environ['SHRINE_KEYSTORE_PASSWORD']) # noqa
f = open("/usr/local/tomcat/lib/shrine.conf", "w")
f.write(output)
f.close()

template = env.get_template('context.xml.j2')
# there must be a better way to do this
output = template.render(shrineDatabaseType=os.environ['SHRINE_DB_TYPE'],
                         problemDB_user=os.environ['SHRINE_PROBLEMDB_USER'], # noqa
                         problemDB_pass=os.environ['SHRINE_PROBLEMDB_PASS'], # noqa
                         problemDB_driver=os.environ['SHRINE_PROBLEMDB_DRIVER'], # noqa
                         problemDB_url=os.environ['SHRINE_PROBLEMDB_URL'], # noqa
                         shrineDB_user=os.environ['SHRINE_SHRINEDB_USER'], # noqa
                         shrineDB_pass=os.environ['SHRINE_SHRINEDB_PASS'], # noqa
                         shrineDB_driver=os.environ['SHRINE_SHRINEDB_DRIVER'], # noqa
                         shrineDB_url=os.environ['SHRINE_SHRINEDB_URL'], # noqa
                         adapterAuditDB_user=os.environ['SHRINE_ADAPTERAUDITDB_USER'], # noqa
                         adapterAuditDB_pass=os.environ['SHRINE_ADAPTERAUDITDB_PASS'], # noqa
                         adapterAuditDB_driver=os.environ['SHRINE_ADAPTERAUDITDB_DRIVER'], # noqa
                         adapterAuditDB_url=os.environ['SHRINE_ADAPTERAUDITDB_URL'], # noqa
                         qepAuditDB_user=os.environ['SHRINE_QEPAUDITDB_USER'], # noqa
                         qepAuditDB_pass=os.environ['SHRINE_QEPAUDITDB_PASS'], # noqa
                         qepAuditDB_driver=os.environ['SHRINE_QEPAUDITDB_DRIVER'], # noqa
                         qepAuditDB_url=os.environ['SHRINE_QEPAUDITDB_URL'], # noqa
                         stewardDB_user=os.environ['SHRINE_STEWARDDB_USER'], # noqa
                         stewardDB_pass=os.environ['SHRINE_STEWARDDB_PASS'], # noqa
                         stewardDB_driver=os.environ['SHRINE_STEWARDDB_DRIVER'], # noqa
                         stewardDB_url=os.environ['SHRINE_STEWARDDB_URL']
                        )
f = open("/usr/local/tomcat/conf/context.xml", "w")
f.write(output)
f.close()
