{% set node_type = salt['grains.get']('node_type', '') %}
{% from "supervisor/map.jinja" import supervisor with context %}
{% from "supervisor/map.jinja" import supervisor_user with context %}
{% from "map.jinja" import global with context %}

include:
  - python

supervisor:
  pip.installed:
    - require:
      - sls: python

superlance:
  pip.installed:
    - require:
      - sls: python

supervisord-confd:
  file.directory:
    - name: {{ supervisor.conf_dir }}
    - user: root
    - group: {{ global.group }}
    - mode: 775
    - makedirs: True
    - require_in:
      - file: supervisord-conf

supervisord-conf:
  file.managed:
    - name: {{ supervisor.conf_file }}
    - user: root
    - group: {{ global.group }}
    - mode: 664
    - source: salt://supervisor/files/supervisord.conf
    - template: jinja
    - makedirs: True
    - require:
      - pip: supervisor

supervisord-log:
  file.managed:
    - name: /var/log/supervisord.log
    - user: ubuntu
    - group: ubuntu
    - mode: 664
    - replace: False
    - require:
      - pip: supervisor

supervisord-init:
  file.managed:
    - name: {{supervisor.init_file }}
    - user: root
    - group: {{ global.group }}
    - mode: 755
    - source: {{ supervisor.init_source }}
    - require:
      - pip: supervisor

supervisord-service:
  service.running:
    - name: {{ supervisor.service }}
    - enable: True
    - require:
      - file: supervisord-init
