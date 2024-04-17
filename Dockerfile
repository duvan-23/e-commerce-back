FROM maven:3.6.0-jdk-11-slim as build
COPY src /home/app/src
COPY pom.xml /home/app
RUn mvn -f /home/app/pom.xml clean package


From open jdk:21-jre-slim
COPY --from=build /home/app/target/back-0.0.1-SNAPSHOT.war /usr/local/lib/demo.war
ENTRYPOINT ["java", "-war","/usr/local/lib/demo.war"]
