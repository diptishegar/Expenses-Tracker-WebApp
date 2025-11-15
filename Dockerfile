#Stage 1 : build the java app

FROM maven:3.8.1-openjdk-17-slim AS builder

WORKDIR /app

COPY . /app

RUN mvn clean install -DskipTests=true

#Stage 2 : Run the Java JAR file

FROM eclipse-temurin:8u472-b08-jre-ubi9-minimal

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expensesapp.jar

EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app/target/expensesapp.jar"]

