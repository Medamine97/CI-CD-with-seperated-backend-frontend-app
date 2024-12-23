#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package


#
# Package stage
#
FROM openjdk:11-jre-slim

# Copy the jar file from the build stage
COPY --from=build /home/app/target/spring-boot-ecommerce-0.0.1-SNAPSHOT.jar /usr/local/lib/spring-boot-ecommerce.jar

# Expose port 8443
EXPOSE 8443

# Run the jar file
ENTRYPOINT ["java","-jar","/usr/local/lib/spring-boot-ecommerce.jar"]
