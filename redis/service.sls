{%- from "redis/map.jinja" import redis with context %}

include:
  - redis.install

redis_service:
  service.running:
    - name: {{ redis.service }}
    - enabled: True
    - require:
      - pkg: redis_package
