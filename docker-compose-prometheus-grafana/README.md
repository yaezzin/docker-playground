# Prometheus Grafana 연동

#### 📍 Prometheus

프로메테우스는 시계열 데이터를 수집하고 저장하는 데 특화된 데이터베이스로, 주기적으로 애플리케이션의 엔드포인트를 폴링하여 데이터를 가져오는 방식으로 동작함

#### 📍 Grafana

프로메테우스와 같은 데이터 소스에서 데이터를 가져와 시각화하는 데 사용

## Project structure

```
.
├── docker-compose.yaml
├── grafana
│   └── datasource.yaml
├── prometheus
│   └── prometheus.yaml
└── README.md
```

## docker-compose.yaml

```yaml
version: '3.7'

services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    # Prometheus 실행 시 사용할 설정 파일 경로 지정
    command:
      - '--config.file=/etc/prometheus/prometheus.yaml'
    ports:
      - 9090:9090
    restart: unless-stopped
    volumes:
      # 호스트의 prometheus.yaml을 컨테이너 내 /etc/prometheus/prometheus.yaml로 마운트
      - ./prometheus/prometheus.yaml:/etc/prometheus/prometheus.yaml 
      - prom_data:/prometheus

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - 3000:3000
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_USER=${GRAFANA_ADMIN_USER}
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_ADMIN_PASSWORD}
    volumes:
      - ./grafana:/etc/grafana/provisioning/datasources

volumes:
  prom_data:
```

## datasource.yaml

```yaml
apiVersion: 1

datasource:
  - name: Prometheus
    type: prometheus
    url: http://prometheus:9090
    isDefault: true
    access: proxy
    editable: true
```
* Grafana에서 Prometheus를 데이터 소스로 등록하기 위한 자동 프로비저닝 설정 파일

## prometheus.yaml

```yaml
global: # 전역 설정
  # 메트릭 수집 주기를 설정
  scrape_interval: 15s
  # 메트릭을 가져올 최대 시간
  scrape_timeout: 10s
  # 알림 규칙을 평가하는 주기
  evaluation_interval: 15s

alerting: # 알림 설정
  alertmanagers:
  - static_configs:
      - targets: []
    scheme: http
    timeout: 10s
    api_version: v1

scrape_configs: # 매트릭 수집 설정
  - job_name: prometheus
    honor_timestamps: true
    scrape_interval: 15s
    scrape_timeout: 10s
    metrics_path: /metrics
    scheme: http
    static_configs:
      - targets:
        - localhost:9090
```
* Prometheus가 메트릭을 수집하고, 평가하며, 알림을 보내는 방식을 정의

## Deploy with docker compose

```
$ docker compose up -d
$ docker ps
```
<img width="1083" alt="스크린샷 2025-03-31 오후 4 33 38" src="https://github.com/user-attachments/assets/e18d8dde-7c2c-4233-91c4-1121b67eef6a" />

* `localhost:3000`, `localhost:9090`으로 접속
