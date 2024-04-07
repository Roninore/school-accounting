dev-build:
	docker-compose -f docker-compose.postgres.yml build --no-cache

dev-start:
	docker-compose -f docker-compose.postgres.yml up --force-recreate --remove-orphans

dev-initdb:
	docker-compose -f docker-compose.initdb.yml up --force-recreate --remove-orphans

dev-build-1c:
	docker-compose -f docker-compose.1c.yml build --no-cache

dev-start-1c:
	docker-compose -f docker-compose.1c.yml up --force-recreate --remove-orphans