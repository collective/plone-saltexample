{% from "base/map.jinja" import base with context %}

base-packages:
  pkg.installed:
    - pkgs:
      - {{ base.bzip2 }}
      - unzip
      - dmidecode
      - git
      - {{ base.libxml2 }}
      - {{ base.libxslt }}
      - {{ base.sqlite }}
      - {{ base.vim }}
      - wget
      - nmap
{% if grains['os_family'] == 'Debian' %}
      - libssl-dev
      - rcconf
      - tmpreaper
      - mailutils
{% endif %}
