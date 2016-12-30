FROM centos:centos6

RUN yum -y update && yum clean all
RUN yum -y install epel-release && \
    yum -y install npm node && yum clean all

ENV NODE_APP=/opt/app \
    NODE_LIVE_EDIT=true

WORKDIR $NODE_APP

RUN npm install forever 

ADD ./app $NODE_APP

RUN npm install && \
    useradd -u 1001 nodeapp && \
    chown -R nodeapp . && \
    chmod +x ./scripts/*

USER nodeapp
EXPOSE 8080

CMD ["scripts/start.sh"]