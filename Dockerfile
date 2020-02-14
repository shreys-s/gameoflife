FROM tomcat:alpine
MAINTAINER Shruti Gupta
RUN wget -O /usr/local/tomcat/webapps/launchstation04.war http://192.168.184.4:8081/artifactory/shruti/com/wakaleo/gameoflife/gameoflife-web/1.0-SNAPSHOT/gameoflife-web-1.0-SNAPSHOT.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
