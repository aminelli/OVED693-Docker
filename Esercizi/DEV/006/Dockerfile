# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build

# Imposta la directory di lavoro
WORKDIR /app

# Copia i file di configurazione Maven
COPY ./demo/pom.xml .
COPY ./demo/src ./src

# Esegui il build dell'applicazione
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

# Imposta la directory di lavoro
WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copia il JAR dall'immagine di build
COPY --from=build /app/target/*.jar app.jar

# Esponi la porta dell'applicazione (default Spring Boot: 8080)
EXPOSE 8080

# Variabili d'ambiente opzionali
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Comando per avviare l'applicazione
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
