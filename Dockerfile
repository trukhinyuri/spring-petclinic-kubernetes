# Use an official OpenJDK runtime as a parent image
FROM amazoncorretto:23-jdk

RUN yum update -y && \
    yum install -y findutils

# Set the working directory inside the container
WORKDIR /app

# Copy the source files to the container
COPY . .

RUN yum clean all
RUN yum update -y
RUN yum install -y findutils

# Build the application using Gradle
RUN ./gradlew build

# Expose the port the application runs on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "build/libs/spring-petclinic-3.3.0.jar"]
