export DOCKER_DEFAULT_PLATFORM=linux/amd64

docker buildx build . --build-arg PLATFORM=cashier -t jeepay-ui-cashier:$TAG
docker buildx build . --build-arg PLATFORM=manager -t jeepay-ui-manager:$TAG
docker buildx build . --build-arg PLATFORM=merchant -t jeepay-ui-merchant:$TAG

docker login $HARBOR_URL --username ${HARBOR_USER} --password ${HARBOR_PASS}
docker push $HARBOR_URL/tusdesign/jeepay-ui-payment:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-manager:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-merchant:$TAG