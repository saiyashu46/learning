FROM tomcat:8.0.20-jre8

COPY target/learning*.war /usr/local/tomcat/webapps/learning.war