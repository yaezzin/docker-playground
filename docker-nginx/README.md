## Docker

```Dockerfile```
- 도커 이미지를 빌드하기 위한 텍스트 파일
- 필요한 패키지, 환경 변수, 파일 복사 등의 작업을 단계별로 기술

```Docker image```
- 도커 컨테이너를 실행하기 위해 파일이나 설정 정보를 담고 있는 템플릿 

```Docker Container```
- 이미지를 통해 만들어진 하나의 인스턴스
- 도커파일 빌드 ➡ 도커 이미지 생성 ➡ 이미지 실행 ➡ 도커 컨테이너 생성

## Command

| 명령어 설명                      | 명령어                                      |
|---------------------------------|--------------------------------------------|
| 컨테이너 생성 (Create Container) | `docker create --name <container-name> <image-name>` |
| 컨테이너 시작 (Start Container)  | `docker start <container-id/name>`         |
| 컨테이너 실행 (Run Container)    | `docker run -it -d --name <container-name> <image-name> bash` |
| 컨테이너 일시 정지 (Pause Container) | `docker pause <container-id/name>`      |
| 컨테이너 재개 (Unpause Container) | `docker unpause <container-id/name>`    |
| 컨테이너 중지 (Stop Container)   | `docker stop <container-id/name>`         |
| 컨테이너 재시작 (Restart Container) | `docker restart <container-id/name>`   |
| 컨테이너 종료 (Kill Container)   | `docker kill <container-id/name>`         |
| 컨테이너 제거 (Remove Container) | `docker rm <container-id/name>`           |


## Result 
<img width="413" alt="스크린샷 2025-03-06 오후 5 29 35" src="https://github.com/user-attachments/assets/56ac4cd2-8eee-4feb-8290-d2eaf4099df6" />
