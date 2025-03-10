## Docker CI

도커 이미지를 도커 허브에 업로드하기 with `Github Action`
* https://docs.docker.com/guides/java/configure-ci-cd/

## Step
* `Git Repo 설정`
  * **Settings > Secrets and variables > Actions** 
* ```Repositry Values``` 
  * Key : DOCKER_USERNAME
  * Value : My Docker ID
* `Repository secret`
  * Key : DOCKERHUB_TOKEN
  * Value : PAT (Personal Access Token)
* ```
  git add .
  git commit -m “commit”
  git push origin main
  ```

## Result

<img width="700" alt="스크린샷 2025-03-10 오후 4 44 23" src="https://github.com/user-attachments/assets/1f8a74b1-78ee-41be-828b-1a8100e69448" />
<img width="700" alt="스크린샷 2025-03-10 오후 4 44 42" src="https://github.com/user-attachments/assets/5ed8468f-adc9-4e40-a3cb-7c05f3fd2a5f" />

* Docker Hub에 이미지가 올라간 것을 확인할 수 있다
