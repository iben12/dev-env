cp /mydocker/nginx/app.conf /opt/docker/etc/nginx/vhost.conf

cp /mydocker/php/app_php.ini /opt/docker/etc/php/php.ini

cp /mydocker/supervisor.d/app_postfix.conf /opt/docker/etc/supervisor.d/postfix.conf
cp /mydocker/script/appcommand /usr/bin/appcommand

cp /mydocker/cron/app_cron /var/spool/cron/crontabs/application

# echo alias artisan=\'php artisan\' >> /etc/bash.bashrc

if [[ ! $APPLICATION_UID == $(id -u application) ]]
then
    usermod -u $APPLICATION_UID application
    groupmod -g $APPLICATION_GID application
fi