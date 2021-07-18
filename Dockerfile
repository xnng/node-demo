FROM keymetrics/pm2:14-slim

WORKDIR /app

ENV GIT_USERNAME=xnng
ENV GIT_EMAIL=xnng77@gmail.com
ENV BRANCH_NAME=master
ENV REPO_NAME=node-demo
ENV REPO_URL=git@github.com:xnng/${REPO_NAME}.git

COPY ./.ssh /root/.ssh/

# warnning: 拉取代码操作会导致缓存全部失效
RUN bash -c 'echo -e "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib \
  deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib \
  deb http://mirrors.aliyun.com/debian-security buster/updates main \
  deb-src http://mirrors.aliyun.com/debian-security buster/updates main \
  deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib \
  deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib \
  deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib \
  deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" > /etc/apt/sources.list' \
  && apt-get update -y \
  && apt-get install apt-utils git openssh-client -y \
  && git config --global user.name ${GIT_USERNAME} \
  && git config --global user.email ${GIT_EMAIL}

RUN git clone -b ${BRANCH_NAME} ${REPO_URL} .

RUN yarn --production --registry=https://registry.npm.taobao.org

EXPOSE 8091

CMD [ "pm2-runtime", "start", "pm2.json" ]