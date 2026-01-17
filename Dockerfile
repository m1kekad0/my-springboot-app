# Build stage
FROM ghcr.io/graalvm/native-image-community:21 AS build
COPY . /app
WORKDIR /app
RUN ./gradlew nativeCompile -x test

# Run stage
FROM gcr.io/distroless/static-debian12
COPY --from=build /app/build/native/nativeCompile/my-springboot-app /app/my-springboot-app
EXPOSE 8080
ENTRYPOINT ["/app/my-springboot-app"]
