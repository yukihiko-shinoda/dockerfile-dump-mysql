<!-- markdownlint-disable first-line-h1 -->
[![docker build automated?](https://img.shields.io/docker/cloud/automated/futureys/dump-mysql.svg)](https://hub.docker.com/r/futureys/dump-mysql/builds)
[![docker build passing?](https://img.shields.io/docker/cloud/build/futureys/dump-mysql.svg)](https://hub.docker.com/r/futureys/dump-mysql/builds)
[![image size and number of layers](https://images.microbadger.com/badges/image/futureys/dump-mysql.svg)](https://hub.docker.com/r/futureys/dump-mysql/dockerfile)

<!-- markdownlint-disable no-trailing-punctuation -->
# What is Dump MySQL?
<!-- markdownlint-enable no-trailing-punctuation -->

This is batch task to dump only user databases from MySQL.

In some case like upgrading MySQL version, When dump includes system databases, importing dump may fail.

There are also several way to back up MySQL databases:

- "Creating database dumps" and "Restoring data from dump files" in [Description of MySQL Docker Official Image](https://hub.docker.com/_/mysql))
- [Backup, restore, or migrate data volumes | Use volumes  | Docker Documentation](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes)

However, they are the way for full backup, we need the way to dump only user databases.

# How to use this image

1\.

Prepare file to load environment variables, for example, let's name ```env.list```:

```text
LOGIN_USER=root
LOGIN_PASSWORD=p@ssW0rd
LOGIN_HOST=database
```

\* cf. [Set environment variables (-e, --env, --env-file) | docker run | Docker Documentation](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file)

2\.

Run following command:

```console
docker run --env-file env.list --network some-network --rm -v $(pwd)/backup:/root/storage futureys/dump-mysql
```

Then, user databases are dumped in ```./backup``` directory on host.

## ... via docker-compose

1\.

Assume that following ```docker-compose.yml``` are upping:

```yaml
---
version: '3.7'
services:
  database:
    container_name: database
    environment:
      MYSQL_ROOT_PASSWORD: ${DATABASE_ROOT_PASSWORD}
      MYSQL_DATABASE: service
    image: mysql
  # ...
```

2\.

Prepare ```docker-compose.dump.yml```:

```yaml
---
version: '3.7'
services:
  dump:
    container_name: dump
    image: futureys/dump-mysql
    environment:
      LOGIN_USER: root
      LOGIN_PASSWORD: ${DATABASE_ROOT_PASSWORD}
      LOGIN_HOST: database
    volumes:
      - ./backup:/root/storage
```

3\.

Run following command:

```console
docker-compose -f docker-compose.yml -f docker-compose.dump.yml run --rm dump
```

Then, user databases are dumped in ```./backup``` directory on host.

## Environment Variables

### ```LOGIN_USER```

Login user name for MySQL to dump. Required.

### ```LOGIN_PASSWORD```

Login user password for MySQL to dump. Required.

### ```LOGIN_HOST```

Host name of MySQL to dump. Optional. Default value: ```database```

### ```LOGIN_PORT```

Port number of MySQL to dump. Optional. Default value: ```3306```

# License

View license information for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
