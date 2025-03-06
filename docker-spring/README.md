## Docker-Spring

도커 파일로 스프링 애플리케이션 실행하기

## Command

| 명령어     | 설명                                            |
|------------|-------------------------------------------------|
| **FROM**   | 기본 이미지에서 새로운 빌드 스테이지 생성            |
| **WORKDIR** | 작업 디렉토리 변경                             |
| **COPY**   | 파일 및 디렉토리 복사, **이미지 빌드 시점에 실행**       |
| **RUN**    | 빌드 명령어 실행                               |
| **ADD**    | 로컬 또는 원격 파일 및 디렉토리 추가                |
| **ARG**    | 빌드 시간 변수 사용                             |
| **CMD**    | 기본 명령어 지정, **컨테이너 실행 시점에 실행**     |
| **ENTRYPOINT** | 기본 실행 가능한 파일 지정                    |
| **ENV**    | 환경 변수 설정                                 |
| **EXPOSE** | 애플리케이션이 수신 대기 중인 포트 설명              |
| **VOLUME** | 볼륨 마운트 생성                                |

## Dockerfile

```dockerfile
# Build stage

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
```

```FROM bellsoft/liberica-openjdk-alpine:17 AS builder```
* bellsoft의 liberica-openjdk를 이용하여 베이스 이미지를 생성하며 'builder'라는 별칭 부여

```WORKDIR /app```
* 컨테이너 내부의 작업 디렉토리는 /app으로 설정
  
```COPY . .```
* 현재 디렉토리의 설정파일, 소스코드 등을 컨테이너 내부의 /app으로 복사

```RUN ./gradlew clean build -x test```
* jar 파일 생성
* 빌드 과정을 Dockerfile 내에 작성을 하지 않으려면, 프로젝트 빌드를 통해 *.jar 파일을 만들어야 함

```COPY --from=builder /app/build/libs/*.jar app.jar```
* 빌드 스테이지에서 생성된 jar파일을 app.jar로 복사

```ENTRYPOINT ["java","-jar","app.jar"]```
* 컨테이너 실행 후 실행될 명령어 지정

