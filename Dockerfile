#multi-stage build

#Stage 1 build the java app

FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . /app

RUN mvn clean install -DskipTests=true

#Stage 2 : Run the Java JAR file

FROM eclipse-temurin:17

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expensesapp.jar

EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app/target/expensesapp.jar"]

