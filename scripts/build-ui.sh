export DOCKER_DEFAULT_PLATFORM=linux/amd64

if [ "$HARBOR_URL" = "" ]; then
    HARBOR_URL="oci.tuxm.art:8443"
fi

if [ "$TAG" = "" ]; then
    TAG="latest"
fi

docker buildx build . --build-arg PLATFORM=cashier -t $HARBOR_URL/tusdesign/jeepay-ui-cashier:$TAG
docker buildx build . --build-arg PLATFORM=manager -t $HARBOR_URL/tusdesign/jeepay-ui-manager:$TAG
docker buildx build . --build-arg PLATFORM=merchant -t $HARBOR_URL/tusdesign/jeepay-ui-merchant:$TAG

docker login $HARBOR_URL --username ${HARBOR_USER} --password ${HARBOR_PASS}
docker push $HARBOR_URL/tusdesign/jeepay-ui-payment:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-manager:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-merchant:$TAG