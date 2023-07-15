export TZ=Asia/Shanghai
export BUILD_TIME=$(date +'%Y-%m-%dT%H:%M:%S%z')

export DOCKER_DEFAULT_PLATFORM=linux/amd64

# disable cashier for saving some time. We don't need it. 
# docker buildx build -f Dockerfile_github \
# 	-t $HARBOR_URL/tusdesign/jeepay-ui-payment:$TAG \
#     --build-arg USER=${GITHUB_USER} \
#     --build-arg TOKEN=${GITHUB_TOKEN} \
#     --build-arg PLATFORM=cashier \
#     --build-arg BUILD_TIME=${BUILD_TIME} \
#     --build-arg VERSION=${VERSION} \
#     --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker buildx build -f Dockerfile_github \
 -t $HARBOR_URL/tusdesign/jeepay-ui-manager:$TAG \
 --build-arg PLATFORM=manager \
 --build-arg BUILD_TIME=${BUILD_TIME} \
 --build-arg VERSION=${VERSION} \
 --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker buildx build -f Dockerfile_github \
 -t $HARBOR_URL/tusdesign/jeepay-ui-merchant:$TAG \
 --build-arg PLATFORM=merchant \
 --build-arg BUILD_TIME=${BUILD_TIME} \
 --build-arg VERSION=${VERSION} \
 --build-arg COMMIT_SHA=${COMMIT_SHA} .

docker login $HARBOR_URL --username ${HARBOR_USER} --password ${HARBOR_PASS}
docker push $HARBOR_URL/tusdesign/jeepay-ui-payment:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-manager:$TAG
docker push $HARBOR_URL/tusdesign/jeepay-ui-merchant:$TAG

