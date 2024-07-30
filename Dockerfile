#FROM openjdk:17-jdk-slim

# Set the working directory in the container
#WORKDIR /app

# Copy the JAR file into the container
#COPY target/spring-petclinic-3.3.0-SNAPSHOT.jar app.jar

# Specify the command to run the JAR file
#CMD ["java", "-jar", "spring-petclinic-3.3.0-SNAPSHOT.jar"]

# Optional: Expose the port on which your application will run
#EXPOSE 8080
FROM alpine/git as clone
MAINTAINER stangella<stangella9@gmail.com>
WORKDIR /app
RUN git clone https://github.com/gsureshkiran/sonix-pet.git
# stage-two
FROM maven:3.8.4-openjdk-17 as build
WORKDIR /app
COPY --from=clone  /app/sonix-pet  /app
RUN mvn package
RUN cd target
CMD ["java", "-jar", "spring-petclinic-3.3.0-SNAPSHOT.jar"]
