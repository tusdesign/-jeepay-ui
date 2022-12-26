export TZ=Asia/Shanghai
export BUILD_TIME=$(date +'%Y-%m-%dT%H:%M:%S%z')

export DOCKER_DEFAULT_PLATFORM=linux/amd64

docker buildx build -f Dockerfile_github \
	-t jeepay-ui-payment:latest \
    --build-arg USER=${GITHUB_USER} \
    --build-arg TOKEN=${GITHUB_TOKEN} \
    --build-arg PLATFORM=payment \
    --build-arg BUILD_TIME=${BUILD_TIME} \
    --build-arg VERSION=${VERSION} \
    --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker buildx build -f Dockerfile_github \
 -t jeepay-ui-manager:latest \
 --build-arg PLATFORM=manager \
 --build-arg BUILD_TIME=${BUILD_TIME} \
 --build-arg VERSION=${VERSION} \
 --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker buildx build -f Dockerfile_github \
 -t jeepay-ui-merchant:latest \
 --build-arg PLATFORM=merchant \
 --build-arg BUILD_TIME=${BUILD_TIME} \
 --build-arg VERSION=${VERSION} \
 --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker login oci.tuxm.art:8443 --username ${HARBOR_USER} --password ${HARBOR_PASS}
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-payment:latest
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-manager:latest
docker push oci.tuxm.art:8443/tusdesign/jeepay-ui-merchant:latest

