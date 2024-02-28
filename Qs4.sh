#! /bin/bash
if [ "$#"-ne 1 ] ; then
echo you haven't entered the port number.
exit 1
Fi

port="$1”
if nc -z "Localhost" ”$port"; then
echo Port $port is open
else
echo Port Sport is closed.
Fi
