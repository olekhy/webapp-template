# Development Documentation

* [Docker](docker.md)
* [Development](development.md)
  * [wie erstelle ich eine Route](development/route-erstellen.md) 
* [Database](db.md)
* [API](app.md)

### setup DNS entry local
please add next in /etc/hosts

10.120.5.2 zaehlerablesung-frontend-app
10.120.5.3 zaehlerablesung-frontend-db

### working with docker

###### Log in PHP container as a normal user
```bash
docker-compose exec --user $(id -u):$(id -g) app bash
```

```fish
docker-compose exec --user (id -u):(id -g) app bash
```

###### Log in PHP container as root user
```bash
docker-compose exec --user 0:0 app bash
```
