# Use an official OpenJDK runtime as a parent image
FROM amazoncorretto:23-jdk

# Set the working directory inside the container
WORKDIR /app

# Install necessary tools (findutils)
RUN yum clean all
RUN yum update -y
RUN yum install -y findutils

# Copy the Gradle wrapper and build script first to cache dependencies
COPY gradlew ./
COPY gradle gradle

# Copy the source files to the container
COPY . .

# Grant execute permission for the Gradle wrapper
RUN chmod +x gradlew

# Build the application using Gradle wrapper
RUN ./gradlew build --no-daemon

# Expose the port the application runs on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "build/libs/pingservice.jar"]
