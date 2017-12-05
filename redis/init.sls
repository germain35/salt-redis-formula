{%- from "redis/map.jinja" import redis with context %}

include:
  - redis.install
  - redis.config
  - redis.service
