# Development environment for Kártypláza reloaded.

Ez egy dockeres fejlesztői környezet.

## Előfeltételek
* **docker** telepítve van a gépen \^1.10

## Pro tipp
A `docker-compose` parancsra csinálj egy rövidebb aliast, pl. `doco`, hogy könnyebben tudd hívni. Sokat fogod.

## Használat
Első indítás előtt, illetve bármikor `up` előtt futtasd a
```
$ source setuser
```
parancsot, ez beállítja a saját userednek megfelelő `env` változókat.

Indításhoz használd az `up` parancsot és a `-d` paramétert, hogy detach-elje a processt a terminálodból:
```
$ docker-compose up -d
```

Erre hat konténer fog elindulni:
### Nginx
Ez a proxy a megfelelő konténerekhez irányítja a kéréseket. A konténer a `80`-as portodon figyel. Ha nem indul el a konténer, akkor nálad helyben használja valami a 80-as portot (Apache, nginx). Vagy állítsd le azt a service-t, vagy a `docker-compose.yml` fájlban állítsd át az nginx portját:
```yaml
    ...
    nginx-proxy:
        image: jwilder/nginx-proxy
        container_name: nginx-proxy
        ports:
            - "[host-port]:80"
    ...
```
Ebben az esetben a megfelelő porton éred el az alkalmazásokat, de pl. ezt a magento nem igazán dolgozza fel (asseteket nem tudja betölteni), így neked kell megoldnai, hogy ez működjön.

### MySQL
Ezt lehet használni MySQL szerverként. A konténerekből a `mysql` hostname alatt érhető el, `root`/`1234` adatokkal.

Alapból egy `magento` és egy `admin` adatbázis jön létre, ezeket lehet használni. Az adatokat local folderben tárolja (ld. `./mysql/data/`), így konténer lebontása és újraépítése esetén is megmaradnak az adataid.

### REDIS
Ez egy redis. Semmi konfig. A többi konténer a `redis` hostnéven látja a default `6379` porton.

### MailHog
Ez egy mail-sandbox: elkapkodja a maileket és egy webes felületen megmutatja. A webes felület a http://mail.kartyaplaza.hu címen érhető el. A többi konténer pedig a `mail:1025` címen érheti el az smtp szervert. A magento konténerhez be van konfigolva a `postfix`, hogy ezt a relay-t használja.

### Két Nginx/php-fpm konténer az alkalmazások futtatására
1. `kpshop` (URL: **http://shop.kartyaplaza.dev**)

    Ez a magento konténer. A kód a `./web/shop` könyvtárba kell kerüljön, az nginx configja az `./docker/nginx/shop.conf` fájlban van, ami behúzza a magento default konfigot (`mage.nginx.conf`).
1. `kpadmin` (URL: **http://admin.kartyaplaza.dev**)

    Ez az admin stack konténere. Kódja a `./web/admin` folderbe kerüljön, nginx configja a `./docker/nginx/admin.conf`. Alapból Laravelre van konfigolva, tehát a webroot-ot a `public` könyvtárban keresi.

Ezekben a konténerekben a php-fpm a te usereddel fut, így nem lesznek jogosultsági parák. Legalábbis az fpm-mel nem.

Ha a konténeren belül kellene futtatni valamilyen parancsot, három lehetőség van:
1. `docker-compose exec`

    Ezzel `root`-ként lehet belépni a konténerbe, tehát ha valamiért ilyen jogosultságú parancsot kellene futtatni, akkor ez a megoldás:
    ```
    $ docker-compose exec [service-name] bash
    ```

    **`composer`-t és alkamazás scripteket ne futass vele!**

1. `./app-cli`

    Ez egy olyan bash-t ad, amiben a user az `application`, így ha ez hoz létre fájlokat, azok a tieid lesznek.
    ```
    $ ./app-cli [service name]
    ```

2. `./cmd`

    Ha csak egy parancsot kell futtatni, akkor ezt használd. Például `composer` parancsok, vagy alkalmazás scriptek esetén.
    ```
    $ ./cmd [service name] [command and arguments]

    // ex.
    $ ./cmd kpadmin composer dump-autoload

    $ ./cmd kpadmin php artisan cache:clear
    ```
**FONTOS!**
* A `kpshop` konténerben a `mage` alias működik a `./bin/magento`-ra.
* A konténereken végrehajtott változtatások (pl. telepített csomag, cron job, stb.) `stop/start` esetén megmaradnak, de `down/up` után nem!
* A `./cmd` script **nem a futó konténeren futtatja a parancsot**, hanem annak egy klónján, amit utána eldob! Tehát alkalmas alkalmazással kapcsolatos scriptek futtatására (composer, magento), de pl. ha egy cron job-ot ilyennel akarsz létrehozni, az csak az ideiglenes konténerben jön létre.

### Kontroll
Konténerek listázása:
```
$ docker-compose ps
```
Logok:
```
$ docker-compose logs

// tail
$docker-compose logs -f

// service
$docker-compose logs [service name]
```
Leállítás:
```
$ docker-compose stop

// service
$docker-compose stop [service name]
```
Ezután újraindításhoz:
```
$ docker-compose start

// service
$ docker-compose start [service name]
```
Leállítás és a konténerek eldobása:
```
$ docker-compose down
```
Innen már csak újraépítéssel lehet indítani:
```
$ docker-compose up -d
```