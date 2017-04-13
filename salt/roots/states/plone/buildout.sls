include:
  - plone.code

plone-buildout:
  cmd.run:
    - name: /srv/plone/env/bin/buildout -N
    - cwd: /srv/plone
    - runas: ubuntu
    - require:
      - file: /srv/plone/buildout.cfg
