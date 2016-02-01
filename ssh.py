#!/usr/bin/python

import subprocess
from sys import argv
import pdb

script, host = argv	

COMMAND="uname -a"
ssh = subprocess.Popen(["ssh", host])

COMMAND

#print "hi user", user host
print "hi host", host
