Docker
=========

A role to install docker on Ubuntu, Debian and CentOS.

Role Variables
--------------

```yml
docker_packages: ['docker-ce', 'docker-ce-cli', 'containerd.io']
```

Example Playbook
----------------

```yml
    - hosts: servers
      roles:
         - docker
```

License
-------

MIT
