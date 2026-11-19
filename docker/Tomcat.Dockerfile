# Maven project: run mvn clean package first. This builds a WAR, NOT its source.
# Tomcat 9 for javax.servlet apps; adapt to Tomcat 10+ for jakarta.servlet.
FROM tomcat:9.0-jdk11
COPY target/*.war /usr/local/tomcat/webapps/app.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
# Copy to Maven project root as Dockerfile:
# mvn clean package && docker build -t myapp . && docker run -d -p 8080:8080 myapp
# Browser: http://localhost:8080/app/
