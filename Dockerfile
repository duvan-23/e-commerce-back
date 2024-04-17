FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . .
RUN mvn clean package

# Usamos una imagen de Openjdk
# Exponemos el puerto que nuestro componente va a usar para escuchar peticiones
# Copiamos desde "build" el JAR generado (la ruta de generacion es la misma que veriamos en local) y lo movemos y renombramos en destino como 
# Marcamos el punto de arranque de la imagen con el comando "java -jar app.jar" que ejecutará nuestro componente.
FROM openjdk:21
EXPOSE 8761
COPY --from=build /target/back-0.0.1-SNAPSHOT.war app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]