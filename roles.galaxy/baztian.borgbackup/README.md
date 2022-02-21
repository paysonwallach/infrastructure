# borgbackup / borgmatic ansible role

![CI](https://github.com/baztian/ansible-borgbackup/workflows/CI/badge.svg)

Ansible role to install [BorgBackup](https://www.borgbackup.org/) along with
[borgmatic](https://torsion.org/borgmatic/) to allow for automated backup.

The configuration parts are based on
[jprltsnz.borgmatic](https://galaxy.ansible.com/jprltsnz/borgmatic) and
[m3nu.ansible_role_borgbackup](https://galaxy.ansible.com/m3nu/ansible_role_borgbackup).

## Requirements

The `respositories` parent directory from `borgmatic_configs` (see below) need to exist, or this role
will fail.

For older distribution releases borgmatic will be installed using
[baztian.pip_venv](https://galaxy.ansible.com/baztian/pip_venv). Therefore you should consider downloading
that role first.

## Role variables

* `borgmatic_init_repos`: Whether to initialize the repos or not. Set to `False` if
  you want to initialize with `borgmatic init...` yourself.
* `borgmatic_init_encryption`: The
  [encryption algorithm](https://torsion.org/borgmatic/docs/how-to/set-up-backups/#initialization) to use.
  By default it is set no `none`.
* `borgmatic_timer`: The `borgmatic.timer`'s `OnCalendar` value. See
  [systemd documentation](https://www.freedesktop.org/software/systemd/man/systemd.time.html#Calendar%20Events)
  for valid values.
* `borgmatic_configs`: A dict with the contents of borgmatic per application configuration file. This is copied
  verbatim to the borgmatic config folder. This role is set for
  [per-application setup](https://torsion.org/borgmatic/docs/how-to/make-per-application-backups/). See the
  [borgmatic reference documentation](https://torsion.org/borgmatic/docs/reference/configuration/) for a
  complete list of available configuration.

## Example Playbook

    - hosts: servers
      become: yes
      roles:
         - role: baztian.borgbackup
      vars:
        borgmatic_configs:
          backup-etc:
            location:
              source_directories:
                - /etc
              repositories:
                - /srv/backup_etc
              atime: false
              exclude_patterns:
                - icon_cache
            retention:
              keep_daily: 7
              keep_weekly: 4
              keep_monthly: 12

          backup-home:
            location:
              source_directories:
                - /home
              repositories:
                - /srv/backup_home
              atime: false
              exclude_patterns:
                - icon_cache
            retention:
              keep_daily: 7
              keep_weekly: 4
              keep_monthly: 12

## License

MIT
