{%- from "redis/map.jinja" import redis with context %}

include:
  - redis.install

redis_service:
  service.running:
    - name: {{ redis.service }}
    - enable: {{ redis.service_enabled }}
    - reload: {{ redis.service_reload }}
    - require:
      - pkg: redis_package
