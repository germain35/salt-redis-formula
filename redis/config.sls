{%- from "redis/map.jinja" import redis with context %}

include:
  - redis.install
  - redis.service

redis_config_{{ redis.config_version }}:
  file.managed:
    - name: {{ redis.config_file }}
    - template: jinja
    - source: salt://redis/templates/redis-{{ redis.config_version }}.conf.jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: redis_package
    - watch_in:
      - service: redis_service

{% if redis.overcommit_memory %}
redis_overcommit_memory:
  sysctl.present:
    - name: vm.overcommit_memory
    - value: 1
    - watch_in:
      - service: redis_service
{% endif %}
