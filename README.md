# docker-playground

📝 도커 공부 저장소📝

* [`docker-nginx`](https://github.com/yaezzin/docker-playground/tree/main/docker-nginx)
* [`docker-spring`](https://github.com/yaezzin/docker-playground/tree/main/docker-spring)
* [`docker-compose`](https://github.com/yaezzin/docker-playground/tree/main/docker-compose) - Docker Compose Basic
* [`docker-compose-prometheus-grafana`](https://github.com/yaezzin/docker-playground/tree/main/docker-compose-prometheus-grafana) - Integrate Prometheus and Grafana with Docker Compose
* [`docker-ci`](https://github.com/yaezzin/docker-playground/tree/main/docker-ci) - Build and Push Docker Images with GitHub Actions
* [`docker-release-tag-github-actions`](https://github.com/yaezzin/docker-playground/tree/main/docker-ci) - Manage tags and release with GitHub Actions


## Running 
```
$ docker build -t {image-name}:{tag} .
$ docker run -d -p {port}:{port} --name {name} {image-name}:{tag}
$ docker compose up --build
$ docker exec -it {name} mysql -u root -p
```

