FROM registry.access.redhat.com/rhel7-atomic
MAINTAINER Veer Muchandi<veer@redhat.com>

RUN microdnf install -y --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms --enablerepo=rhel-7-server-optional-rpms \
automake gettext git lsof make tar unzip wget which && \
microdnf install -y --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms --enablerepo=rhel-7-server-optional-rpms java && \
microdnf clean all -y && \
mkdir -p /opt/app-root && \
useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
 -c "Default Application User" default && \
chown -R 1001:0 /opt/app-root

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.141-2.b16.el7_4.x86_64/jre
ENV CATALINA_HOME /opt/tomcat 
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Tomcat
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.20

RUN wget http://ftp.riken.jp/net/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 rm apache-tomcat*.tar.gz && \
 mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh

# Create Tomcat admin user
ADD create_admin_user.sh $CATALINA_HOME/scripts/create_admin_user.sh
ADD tomcat.sh $CATALINA_HOME/scripts/tomcat.sh
RUN chmod +x $CATALINA_HOME/scripts/*.sh

# Create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

RUN curl https://raw.githubusercontent.com/VeerMuchandi/ps/master/deployments/ROOT.war -o $CATALINA_HOME/webapps/ps.war

USER tomcat
CMD ["tomcat.sh"]
