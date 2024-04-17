# Use a Maven & Java base image
FROM maven:3.8.4-openjdk-11 AS builder
# Set the working directory in the container
WORKDIR /app
# Copy the Maven configuration file
COPY pom.xml .
# Copy the source code
COPY src ./src

# Build the project
RUN mvn clean -f package
# Use a lightweight base image
FROM openjdk:21-jdk-slim
# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/back-0.0.1-SNAPSHOT.war ./app.war

# Expose port 8080
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.war"]

