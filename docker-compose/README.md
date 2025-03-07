## Docker compose

* 하나의 YAML 파일 내에 정의하여 **여러 컨테이너를 관리**하기 위해 사용
* Dockerfile에 필요한 서비스를 정의하고 YAML파일 내에 서비스 간의 관계를 정의

## Command

| Docker Compose 명령어   | 설명                                                          |
|--------------------------|---------------------------------------------------------------|
| `docker-compose up`       | Docker Compose 파일에 정의된 모든 서비스를 시작 </br> 필요한 이미지를 자동으로 다운로드하고 컨테이너를 생성, 시작합니다. |
| `docker-compose down`     | 실행 중인 모든 서비스를 중지하고 컨테이너, 네트워크, 볼륨을 제거 |
| `docker-compose ps`       | 현재 실행 중인 서비스의 상태를 보여줌|
| `docker-compose start`    | 이전에 생성된 서비스를 시작                           |
| `docker-compose restart`  | 서비스를 재시작                                |
| `docker-compose stop`     | 실행 중인 서비스를 중지                               |
| `docker-compose build`    | 서비스를 빌드                                         |
| `docker-compose logs`     | 서비스의 로그를 출력                                  |
| `docker-compose pull`     | 서비스에 필요한 모든 이미지를 다운로드            |

## docker-compose.yaml

```yaml
version: "3"

services:
  server:
    container_name: docker-practice-server
    depends_on:
      - db
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      SPRING_DATASOURCE_URL: ${SPRING_DATASOURCE_URL}
      SPRING_DATASOURCE_USERNAME: ${SPRING_DATASOURCE_USERNAME}
      SPRING_DATASOURCE_PASSWORD: ${SPRING_DATASOURCE_PASSWORD}
      SPRING_PROFILES_ACTIVE: ${SPRING_PROFILES_ACTIVE}
    ports:
      - "8000:8080"

  db:
    container_name: docker-practice-db
    image: mysql
    restart: always
    volumes:
      - db-data:/mysql/data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
    ports:
      - "3000:3306"
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  db-data:
```

## 주요 속성

* `version` : compose 파일의 버전을 정의
* `services` : 도커 컨테이너의 목록을 정의 
* `networks` : 컨테이너가 사용할 네트워크를 지정
* `volumes` : 호스트와 컨테이너 간 볼륨 매핑, 컨테이너를 다시 시작할 때 데이터를 유지하기 위해 사용
* `configs` : 컨테이너간 필요한 설정을 공유하는데 사용

## version 

* compose 파일의 버전을 정의
* 버전을 지정하지 않으면 기본적으로 가장 낮은 버전을 사용

## services 하위 속성

* ```container_name``` 컨테이너 이름을 지정
* ```image``` 사용할 도커 이미지를 지정 
* ```build``` Docker 이미지를 빌드하는데 사용되는 경로, 파일을 지정
* ```ports``` 호스트와 컨테이너간 포트 매핑 [HOST:CONTAINER]
* ```environment``` 환경 변수 설정
* `env_file` 컨테이너에서 사용할 환경 변수를 포함하는 파일의 경로를 지정
* ```volumes``` 컨테이너와 호스트간 데이터 공유
* ```networks``` 컨테이너 네트워크 설정
* ```depends_on``` 실행 순서 지정, 해당 서비스가 시작하기 전에 시작되어야 하는 다른 서비스를 지정
* `entrypoint` 컨테이너가 시작될 때 실행할 명령을 지정
