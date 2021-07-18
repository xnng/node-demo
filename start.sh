APP_ANEM=node-demo-server

cp ~/.ssh -r .
docker rmi ${APP_ANEM} -f
docker container rm ${APP_ANEM} -f
docker build --no-cache -t ${APP_ANEM} . && docker run -d -p 8091:8091 ${APP_ANEM} --name ${APP_ANEM}
rm .ssh -rf