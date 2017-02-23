## Dockerized development environment

**Detailed readme comming soon...**

### What you get?
* NGINX reverse-proxy
* MySQL DB
* Redis
* MailHog email sandbox
* PHP-fmp app container (1 by default, but as many as needed)

## Prepare...
Make sure you have Docker\^1.10 installed on your system by running:
```
$ docker -v
Docker version 1.13.1, build 092cba3
```
Stop any service listening on `port 80` (Apache, Nginx).

Run the `setuser` script to export your UID/GID to the config file:
```
$ ./setuser
User/group environment variables set.
```

## Run
Execute the following command to start up the containers:
```
$ docker-compose up -d
```
For the first time it will take while till docker pulls all the images, but this won't be needed next time.


By default your application webroot is configured `web/app/public`, so go ahead and create and `index.php` there! Also by default your application hostname is configured to `myapp.dev`, so you should set that up in your `hosts` file like this:

    127.0.0.1 myapp.dev

NOTE: On Windows/Mac docker runs in a VM, so the hostname may point rather to the VM's IP. Please refer to the docker documentation depending on your OS.

All done, so just direct your browser to http://myapp.dev and the index output should be displayed.

## Config
### MySQL
  * hostname: `mysql`
  * user: `dev`
  * passwd: `dev`
  * database: `dev`
  * to connect to the server from the host computer:
    * hostname: `localhost` (or VM's IP on Mac/Windows)
    * port: `13306`
    
### Redis
  * hostname: `redis`
  * port: `6379`

### MailHog
  * Use as SMTP server as follows:
    * hostname: `mail`
    * port: `1025`
  * web interface: http://mail.myapp.dev

## Controll
To stop all containers execute
```
$ docker-compose stop
```
To restart:
```
$ docker-compose start
```
To list running services
```
$ docker-compose ps
```
To stop adn destroy all containers
```
$ docker-compose down
```