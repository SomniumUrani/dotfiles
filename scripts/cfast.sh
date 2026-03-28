#!/bin/bash

gcc $1 -o /tmp/cfast && \
	chmod +x /tmp/cfast &&
	/tmp/cfast

rm /tmp/cfast
