#!/bin/bash

service postgresql start
exec apache2ctl -DFOREGROUND
