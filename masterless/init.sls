{% import_yaml 'masterless/defaults.yaml' as minion_defs %}

{{ minion_defs.config.base_root }}:
  file.directory:
    - user: jakelyz
    - group: jakelyz
    - mode: '0700'
    - makedirs: True

{{ minion_defs.config.base_repo }}:
  git.latest:
    - target: {{ minion_defs.config.base_root }}
    - force: True

/etc/salt/minion.d:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'

/etc/salt/minion.d/masterless.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://masterless/files/masterless.conf
    - template: jinja
    - defaults:
        base_root: {{ minion_defs.config.base_root }}
    - require:
        - file.directory: /etc/salt/minion.d