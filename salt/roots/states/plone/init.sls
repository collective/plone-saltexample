{% from "supervisor/map.jinja" import supervisor with context %}
{% from "plone/map.jinja" import plone with context %}
{% from "map.jinja" import global with context %}

include:
  - python
  - supervisor
  - varnish
  - plone.code
  - plone.buildout

plone-deps:
    pkg.installed:
        - pkgs:
            - wv
            - lynx
            - poppler-utils
            - {{ plone.deps.freetype }}
            - {{ plone.deps.png }}
            - {{ plone.deps.jpeg }}
            - {{ plone.deps.tiff }}
            - {{ plone.deps.ffi }}

/srv/plone:
  file.directory:
    - user: ubuntu
    - group: ubuntu
    - dir_mode: 775
    - require_in:
      - git: simple-plone-buildout-git

/srv/plone/env:
  virtualenv.managed:
    - python: python2.7
    - requirements: /srv/plone/requirements.txt
    - require:
      - sls: python
      - pip: virtualenv
      - git: simple-plone-buildout-git
    - require_in:
      - module: plone-buildout

supervisor-plone-config:
  file.managed:
    - name: {{ supervisor.conf_dir }}/plone.conf
    - user: root
    - group: {{ global.group }}
    - mode: 664
    - makedirs: True
    - source: salt://plone/files/supervisor-plone.conf
    - template: jinja
    - require:
      - file: supervisord-confd
      - cmd: plone-buildout
    - require_in:
      - service: supervisord-service

