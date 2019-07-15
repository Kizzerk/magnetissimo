#!/bin/bash
/etc/init.d/postgresql start

cd /magnetissimo

mix phx.server
