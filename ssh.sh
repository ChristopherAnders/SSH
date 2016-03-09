#!/bin/bash
#set -o
#takes any amount of arguments and ssh into host then runs uname to identify
#testing

#[ $# -eq 0 ] && { echo "Usage: $0 user@hostname user@hostname2 user@hostname3 ..."; exit 1; }

usage()
{
cat << EOF
usage: $0 user@hostname user@hostname2 user@hostname3 ...

This script runs against hosts to gather uptime

OPTIONS:
   -h      Show this message
   -t      Test type, can be 'test1' or 'test2'
   -r      Server address
   -p      Server root password
   -v      Verbose
EOF
}

TEST=
VERBOSE=
while getopts *ht:v* OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         v)
             VERBOSE=1
             ;;
         t)
             TEST=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done
[ $# -eq 0 ] && { usage ; exit 1; }  # the $# prints the number of arguments given.

#a=$(top -n2 | grep "Cpu(s)"|tail -n 1 | awk '{print $2 + $4}')

hname="$(uname -a | cut -d ' ' -f1-2)"
utime="$(uptime)"


for x in $@
do
    ssh -T "$x" "uname -a | cut -d ' ' -f1-2; uptime" < /dev/null  # -T switch stops message: "Pseudo-terminal will not be allocated because stdin is not a terminal."
    #ssh "$x" "$hname ; $utime ; exit" < /dev/null
    echo "+++++++"
done
