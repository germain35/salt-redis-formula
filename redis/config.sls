{%- from "redis/map.jinja" import redis with context %}

include:
  - redis.install
  - redis.service

redis_config_{{ redis.config_version }}:
  file.managed:
    - name: {{ redis.config_file }}
    - template: jinja
    - source: salt://redis/templates/redis-{{ redis.config_version }}.conf.jinja
    - user: {{ redis.user }}
    - group: root
    - mode: 0640
    - require:
      - pkg: redis_package
    - watch_in:
      - service: redis_service

{%- for k, v in redis.get('sysctl', {}).iteritems() %}
redis_sysctl_{{ k }}:
  sysctl.present:
    - name: {{ k }}
    - value: {{ v }}
    - watch_in:
      - service: redis_service
{%- endfor %}

{% if redis.config.overcommit_memory %}
redis_sysctl_overcommit_memory:
  sysctl.present:
    - name: vm.overcommit_memory
    - value: 1
    - watch_in:
      - service: redis_service
{% endif %}


