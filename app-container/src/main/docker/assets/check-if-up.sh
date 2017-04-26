#!/bin/sh

result=$(/usr/bin/curl \
	--fail --silent --connect-timeout 1 \
	-H "Content-Type: application/json" \
	-H "Accept: application/json" \
	--get http://localhost:8080/status)2>/dev/null
status=$?
if [ "x" = "x$result" ]; then
 exit 7
fi

exit $status
