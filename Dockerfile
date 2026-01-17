# Build stage
FROM amazoncorretto:21-al2023-jdk AS build
COPY . /app
WORKDIR /app
RUN ./gradlew build -x test

# Run stage
FROM amazoncorretto:21-al2023-headless
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
