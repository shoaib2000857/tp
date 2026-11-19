# Build WAR: mvn clean package; copy this file into project root before Docker build.
FROM tomcat:9.0-jdk11
COPY target/ORS.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]
