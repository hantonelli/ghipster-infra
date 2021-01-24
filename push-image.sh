#!/bin/bash
# https://microk8s.io/docs/registry-built-in
docker tag $(docker images -q graphql) localhost:32000/graphql:registry
# docker login localhost:32000
docker push localhost:32000/graphql:registry