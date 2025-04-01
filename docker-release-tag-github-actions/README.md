# docker-release-tag

GitHub Action을 이용하여 도커 이미지의 버전을 생성하고, Release 자동화하는 법 
* `버전 관리 용이` : 태그를 사용하여 프로젝트의 특정 버전이 언제, 어떤 코드로 이루어졌는지 추적 가능
* `배포 자동화` : 태그와 릴리즈를 사용하면 자동화된 CI/CD 파이프라인에서 빌드된 결과물을 특정 버전으로 배포할 수 있으므로 배포 프로세스가 자동화되고, 일관성 있는 배포가 가능
* `릴리즈 노트 관리` : 릴리즈노트를 통해 변경 사항, 버그 수정, 새로운 기능 등의 설명을 담을 수 있음

## CI.yaml

```yaml
name: CI

# main 브랜치에 푸쉬가 일어나면 실행 
on:
  push:
    branches:
      - main

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      # 깃허브 레포의 소스코드를 Github Actions 환경에 복제하여 이후 단계에서 사용할 수 있도록 함 
      - name: Checkout repository
        uses: actions/checkout@v4

      # JDK 17 설정
      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '17'

      # Docker Buildx를 설정하여 멀티 플랫폼 빌드 지원
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      # 도커 허브에 로그인
      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      # version을 증가하고 태그를 푸쉬 
      - name: Bump version and push tag
        id: tag_version
        uses: mathieudutour/github-tag-action@v6.2
        with:
          github_token: ${{ secrets.GIT_TOKEN }}
          #default_bump: false
          #release_branches: main

      # 새로운 태그가 생성되었는지 확인 후 환경변수에 저장
      - name: check if new_tag exists
        id: check_tag
        run: |
          echo "NEW_TAG=${{ steps.tag_version.outputs.new_tag }}" >> $GITHUB_ENV

      # 릴리즈 생성
      - name: Create a GitHub release
        if: ${{ env.NEW_TAG != '' }}
        uses: ncipollo/release-action@v1
        with:
          token: ${{ secrets.GIT_TOKEN }}
          tag: ${{ steps.tag_version.outputs.new_tag }}
          name: Release ${{ steps.tag_version.outputs.new_tag }}
          body: ${{ steps.tag_version.outputs.changelog }}

      # 태그값이 비어있으면 timestamp를 사용하여 태그를 생성 (NEW_TAG값이 있으면 그 값을 사용)
      - name: create Tag
        id: created_tag
        run: |
          if [[ "${{ env.NEW_TAG }}" != "" ]]; then
             echo "Using version tag: ${{ env.NEW_TAG }}"
             echo "TAG=${{ env.NEW_TAG }}" >> $GITHUB_ENV
          else
             TIMESTAMP=$(date '+%s')
             echo "Using timestamp tag: $TIMESTAMP"
             echo "TAG=$TIMESTAMP" >> $GITHUB_ENV
          fi

      # 도커 이미지를 빌드하고 푸쉬
      - name: Build and push Docker image
        if: ${{ env.NEW_TAG != '' }}
        uses: docker/build-push-action@v5
        with:
          context: .
          file: Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/release-tag:${{ env.NEW_TAG }}
```

## 결과물

<img width="700" alt="스크린샷 2025-04-01 오후 5 18 56" src="https://github.com/user-attachments/assets/03255dc0-3e4f-4751-b554-a8c33c300a46" />

<img width="700" alt="스크린샷 2025-04-01 오후 5 19 37" src="https://github.com/user-attachments/assets/ecf41817-d4bf-4798-b791-9610acc11534" />

## 주의할 점

<img width="700" alt="스크린샷 2025-04-01 오후 5 14 11" src="https://github.com/user-attachments/assets/b15269eb-235b-428c-854d-456d3d281f05" />

* 커밋 메세지를 통해 버전 태그를 업데이트하고 새버전을 생성하는데, `fix:` 를 사용하면 Patch릴리즈를, `feat:`을 사용하면 Minor Release를 수행한다.
  * `fix: ` <이 형태를 갖추어야 제대로 작동함
* 설정해야할 정보들
  * `DOCKER_USERNAME` : 나의 도커 ID
  * `DOCKER_PASSWORD` : 도커 PAT
    * https://docs.docker.com/security/for-developers/access-tokens/ 
  * `GIT_TOKEN` : 깃허브 토큰
  
## 관련문서

`Events that trigger workflows`
* https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#push

`mathieudutour/github-tag-action@v6.2`
* https://github.com/mathieudutour/github-tag-action

`ncipollo/release-action@v1`
* https://github.com/ncipollo/release-action
