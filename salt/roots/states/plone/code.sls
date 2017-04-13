simple-plone-buildout-git:
  git.latest:
    - name: https://github.com/plone/simple-plone-buildout.git
    - user: ubuntu
    - target: /srv/plone

/srv/plone/buildout.cfg:
  file.copy:
    - source: /srv/plone/profiles/buildout.cfg.tmpl
    - preserve: True
    - require:
      - git: simple-plone-buildout-git

