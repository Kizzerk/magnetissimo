#!/bin/bash

cd /magnetissimo

/etc/init.d/postgresql start

mix local.rebar --force
mix local.hex --force

mix deps.get



mix ecto.create
mix ecto.migrate



cd ./apps/magnetissimo_web/assets/
npm install
