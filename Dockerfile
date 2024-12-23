# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy only necessary files for dependency resolution first
COPY pom.xml ./
COPY .mvn .mvn
COPY mvnw ./

# Download dependencies (this layer is cached if pom.xml does not change)
RUN chmod +x ./mvnw && ./mvnw dependency:go-offline

# Copy the remaining project files
COPY src ./src

# Build the application
RUN ./mvnw package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM eclipse-temurin:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar petclinic.jar

# Expose port 8080
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "petclinic.jar"]