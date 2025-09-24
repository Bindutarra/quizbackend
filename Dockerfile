# Build stage
FROM maven:3.8.8-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
