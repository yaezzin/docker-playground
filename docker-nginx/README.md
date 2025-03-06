## Docker

```Dockerfile```
- 도커 이미지를 빌드하기 위한 텍스트 파일
- 필요한 패키지, 환경 변수, 파일 복사 등의 작업을 단계별로 기술

```Docker image```
- 도커 컨테이너를 실행하기 위해 파일이나 설정 정보를 담고 있는 템플릿 

```Docker Container```
- 이미지를 통해 만들어진 하나의 인스턴스
- 도커파일을 빌드하면 도커 이미지가 생성되고, 이 이미지를 실행하면 도커 컨테이너가 생성됨


## How to Run
```
# docker 컨테이너 이미지 생성
$ docker build -t nginx:simple-nginx .

# docker 컨테이너 생성 및 실행
$ docker run -d -p 8080:80 --name simple-nginx nginx:simple-nginx
```

## Result 
<img width="413" alt="스크린샷 2025-03-06 오후 5 29 35" src="https://github.com/user-attachments/assets/56ac4cd2-8eee-4feb-8290-d2eaf4099df6" />
