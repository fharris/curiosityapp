FROM maven:3.8.4-jdk-11-slim as maven

ENV SPRING_DATASOURCE_USERNAME 
ENV SPRING_DATASOURCE_PASSWORD
ENV SPRING_DATASOURCE_HOST
ENV SPRING_DATASOURCE_PORT 3306
ENV SPRING_DATASOURCE_DBNAME curiositydb

COPY ./pom.xml ./pom.xml

COPY ./src ./src

RUN mvn dependency:go-offline -B

RUN mvn package

FROM openjdk:11-jre-slim

COPY --from=maven target/curiosity-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
