# Usar imagen base de Java 25
FROM eclipse-temurin:25-jdk

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el wrapper de Maven y los archivos de configuración
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Dar permisos de ejecución al wrapper
RUN chmod +x mvnw

# Descargar dependencias (esto se cachea si pom.xml no cambia)
RUN ./mvnw dependency:go-offline -B

# Copiar el código fuente
COPY src src

# Exponer el puerto por defecto de Spring Boot
EXPOSE 8080

# Comando para ejecutar la aplicación en modo desarrollo
CMD ["./mvnw", "spring-boot:run"]