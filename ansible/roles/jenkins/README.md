Jenkins
=========

A role to install jenkins on Ubuntu, Debian and CentOS.

Requirements
------------

All requirements are handled by meta main.yml and boil down to docker.

Role Variables
--------------

```yml
docker_packages: ['docker-ce', 'docker-ce-cli', 'containerd.io']
```

Dependencies
------------

* [docker](../docker)

Example Playbook
----------------
```yml
    - hosts: servers
      roles:
         - docker
         - jenkins
```

License
-------

MIT
