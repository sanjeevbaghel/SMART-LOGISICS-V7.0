# ---------- Build stage ----------
FROM maven:3.9.9-eclipse-temurin-8 AS build

WORKDIR /app
COPY . /app

RUN mvn clean package -DskipTests

# ---------- Run stage ----------
FROM tomcat:9.0-jdk8-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built war as ROOT app
COPY --from=build /app/target/smartlogistics.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]