# docker-playground

## [docker-nginx](https://github.com/yaezzin/docker-playground/tree/main/docker-nginx)

```
$ docker build -t nginx:simple-nginx .
$ docker run -d -p 8080:80 --name simple-nginx nginx:simple-nginx
```

## [docker-spring](https://github.com/yaezzin/docker-playground/tree/main/docker-spring)

```
$ docker build -t docker-spring .
$ docker run -d --name docker-spring -p 8080:80 docker-spring
```

## [docker-compose](https://github.com/yaezzin/docker-playground/tree/main/docker-compose)

```
$ docker compose up --build
$ docker exec -it docker-practice-db mysql -u root -p
```

## [docker-ci](https://github.com/yaezzin/docker-playground/tree/main/docker-ci)

```
$ git push origin main
> Actions
```
