# Build stage
# 빌드 과정을 도커파일로 작성을 하지 않으려면 도커 파일 빌드 전에 프로젝트 빌드를 통해 *.jar 파일을 만들어야 함

FROM bellsoft/liberica-openjdk-alpine:17 AS builder

WORKDIR /app

COPY . .

RUN ./gradlew clean build -x test

# Run stage

FROM bellsoft/liberica-openjdk-alpine:17

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]