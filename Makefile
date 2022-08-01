# docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
permissions:
	sudo chmod -R 777 bootstrap/cache/ && sudo chmod -R 777 storage/ && [ -d "vendor/" ] && sudo chmod -R 777 vendor/
build:
	clear
	docker-compose up -d --build
up:
	clear
	docker-compose up -d
down:
	clear
	docker-compose down --remove-orphans
stop:
	clear
	docker-compose stop
restart:
	@make down
	@make up
destroy:
	clear
	docker-compose down --rmi all --volumes --remove-orphans

conf:
	clear
	docker-compose config

ps:
	clear
	docker ps --format "table {{.Image}}\t{{.Ports}}"
php-bash:
	clear
	docker-compose exec php bash
nginx-bash:
	clear
	docker-compose exec nginx bash
mysql-bash:
	clear
	docker-compose exec mysql bash -c 'mysql -u$$MYSQL_USER -p$$MYSQL_PASSWORD'
phpmyadmin-bash:
	clear
	docker-compose exec phpmyadmin bash
logs:
	clear
	docker-compose logs
logs-watch:
	clear
	docker-compose logs --follow
log-php:
	clear
	docker-compose logs php
log-php-watch:

init:
	clear
	docker-compose exec php rm -rfv vendor/ public/storage bootstrap/cache/*.tmp bootstrap/cache/*.php compsoer.lock
	docker-compose exec php composer install
	docker-compose exec php php artisan storage:link
	docker-compose exec php chmod -R 777 storage bootstrap/cache
migrate:
	clear
	docker-compose exec php php artisan migrate
seed:
	clear
	docker-compose exec php php artisan db:seed
migrate-seed:
	clear
	docker-compose exec php php artisan migrate:fresh --seed
test:
	clear
	docker-compose exec php php artisan test
rollback:
	clear
	docker-compose exec php php artisan migrate:fresh
	docker-compose exec php php artisan migrate:refresh
tinker:
	clear
	docker-compose exec php php artisan tinker
optimize:
	clear
	docker-compose exec php php artisan view:cache
	docker-compose exec php php artisan event:cache
	docker-compose exec php php artisan event:clear
	docker-compose exec php php artisan optimize:clear
	docker-compose exec php php artisan clear-compiled
	docker-compose exec php composer clear-cache
	docker-compose exec php composer dump-autoload -o
	docker-compose exec php php artisan optimize
