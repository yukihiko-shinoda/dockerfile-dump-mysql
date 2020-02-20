FROM futureys/ansible-runner-python3:20191127153000
RUN yum -y localinstall https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm && \
    yum -y install mysql-community-server && yum clean all
RUN pip3 install --no-cache-dir PyMySQL
RUN mkdir /root/storage
COPY runner /runner
ENV RUNNER_PLAYBOOK=playbook.yml
