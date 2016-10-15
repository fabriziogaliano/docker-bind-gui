#!/bin/env bash

# Replace the default password with the custom one

VALUE=`printenv | grep GUIPWD_WEBMIN | sed 's/\GUIPWD_WEBMIN=//g'`

sed -i "s/WebminPassword/$VALUE/g" /scripts/entrypoint.sh

bash /scripts/entrypoint.sh
