# Please make sure that you have all needed variables at .env.docker
# docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
destroy:
	clear
	docker-compose down --rmi all --volumes --remove-orphans
build:
	clear
	docker-compose up -d --build
rebuild-container:
	clear
	@make destroy
	@make build

up:
	clear
	docker-compose up -d
down:
	clear
	docker-compose down --remove-orphans

restart:
	clear
	docker-compose down --remove-orphans
	docker-compose up -d

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
mysql-import:
	clear
	docker-compose exec mysql bash -c 'mysql -u$$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE < dump.sql'
logs:
	clear
	docker-compose logs
logs-watch:
	clear
	docker-compose logs --follow
log-php:
	clear
	docker-compose logs php