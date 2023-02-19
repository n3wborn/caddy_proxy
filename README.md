# Caddy Proxy

**This container will serve as a reverse proxy available for every container
plugged in caddy network.**

Image we have a web project called web-project.
This project uses 2 services, Nginx and PHP-FPM.
We can have a docker-compose in which these services are defined.
This project need a database. Instead of adding a service inside or project
we can use a Pgsql external container and use it.
This way, instead of having many web projects with a new database each time,
we use only one container for all of them.

In our Caddy container we will be able to assign domain names
to our containers.
Our project will be available on our host with web-project.localhost
and the database will be available with, for example, database.localhost.
Both containers will share a common network (caddy network) and caddy will
help by making them easily available.

Caddy and Database are only on caddy network while web-project has it's own
and caddy network too.

```txt

---------------------           ---------------------
|       Caddy       |-----------|       Database    |
|   (caddy network) |           |   (caddy network) |
---------------------           ---------------------
        |
        |
---------------------------------
|       Nginx / PHP-FPM         |
| (caddy & web-project networks)|
---------------------------------
```

## Install

```bash
git clone git remote add origin git@github.com:n3wborn/caddy_proxy.git
cd caddy_proxy
make install
```

## Configure Reverse Proxy

examples are already shown in Caddyfile.
If you need more, take a looj at [caddy reverse proxy doc](https://caddyserver.com/docs/caddyfile/directives/reverse_proxy)

## Notes

If you want you app to be available on "hello.localdev" in your browser.

- configure your caddyfile accordingly
- append `127.0.0.1 hello.localdev` to your /etc/hosts file
- browse to [https://hello.localdev](https://hello.localdev)
- enjoy
