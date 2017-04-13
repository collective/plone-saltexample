{% from "python/map.jinja" import python with context %}

include:
  - base

python:
  pkg.installed

python-dev:
  pkg.installed

pip:
  pkg.installed:
    - name: {{ python.pip_pkg }}

upgrade-pip:
  pip.installed:
    - name: pip
    - upgrade: True
    - require:
      - pkg: pip

python-dev-packages:
  pkg.installed:
    - pkgs: {{ python.dev_pkgs }}
    - require:
      - pkg: pip

virtualenv:
  pip.installed:
    - require:
      - pkg: pip
