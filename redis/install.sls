{%- from "redis/map.jinja" import redis with context %}

redis_package:
  pkg.installed:
    - name: {{ redis.pkg }}
