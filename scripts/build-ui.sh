export DOCKER_DEFAULT_PLATFORM=linux/amd64

docker buildx build . --build-arg PLATFORM=cashier -t jeepay-ui-cashier:latest
docker buildx build . --build-arg PLATFORM=manager -t jeepay-ui-manager:latest
docker buildx build . --build-arg PLATFORM=merchant -t jeepay-ui-merchant:latest

docker login oci.tuxm.art:8443 --username ${HARBOR_USER} --password ${HARBOR_PASS}
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-payment:latest
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-manager:latest
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-merchant:latest