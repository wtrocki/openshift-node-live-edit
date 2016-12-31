FROM centos:centos6

RUN yum -y update && yum clean all
RUN yum -y install epel-release && \
    yum -y install npm node && yum clean all

ENV NODE_APP=/opt/app \
    NODE_LIVE_EDIT=true

WORKDIR $NODE_APP

## TODO Move this to script.
RUN npm install forever 
RUN yum -y install rsync

ADD ./app $NODE_APP

RUN npm install && \
    useradd -u 1001 nodeapp && \
    chown -R nodeapp . && \
    chmod -R 777 . && \
    chmod +x ./scripts/*

USER nodeapp
# Node app
EXPOSE 8080
# Node debug
EXPOSE 5858

CMD ["scripts/start.sh"]