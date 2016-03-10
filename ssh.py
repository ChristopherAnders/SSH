#!/usr/bin/python

import paramiko
import sys
import getpass

# add a print out options of hosts you can connect to and their FQDN

nbytes = 50000
#hostname = '10.1.12.4'
#password = 'admin123'
port = 22
username = 'root'
#command = 'smartctl -a /dev/sda'

print "Enter a hostname or IP"
hostname = raw_input("> ")
print "Enter password"
password = getpass.getpass("> ")
print "Enter a command to run"
command = raw_input("> ")

print "(*) Running %s on %s \n" %(command, hostname)

client = paramiko.Transport((hostname, port))
client.connect(username=username, password=password)

stdout_data = []
stderr_data = []
session = client.open_channel(kind='session')
session.exec_command(command)
while True:
    if session.recv_ready():
        stdout_data.append(session.recv(nbytes))
    if session.recv_stderr_ready():
        stderr_data.append(session.recv_stderr(nbytes))
    if session.exit_status_ready():
        break

if session.recv_exit_status() == 0:
	pass
else:
	print '(*) exit status: ', session.recv_exit_status()


print ''.join(stdout_data)
print ''.join(stderr_data)

session.close()
client.close()
