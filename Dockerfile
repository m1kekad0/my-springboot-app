# Build stage
FROM eclipse-temurin:21-jdk-jammy AS build
COPY . /app
WORKDIR /app
RUN ./gradlew build -x test

# Run stage
FROM eclipse-temurin:21-jre-jammy
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
