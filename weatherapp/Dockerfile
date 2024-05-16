# Use a base image with Maven, JDK, and JRE
FROM maven:3.8.4-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project descriptor files
COPY pom.xml .
COPY src ./src

# Build the application using Maven
RUN mvn package -DskipTests

# Use the same base image for running the application
FROM maven:3.8.4-openjdk-11 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged Spring Boot application JAR file from the builder stage
COPY --from=builder /app/target/*.jar /app/my-weather-app.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "my-weather-app.jar"]