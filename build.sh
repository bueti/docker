#!/usr/bin/env bash

docker build .
image_id=$(docker images|head -2 | grep none | awk '{print $3}')
docker tag ${image_id} bueti/rails:latest
docker login
docker push bueti/rails:latest