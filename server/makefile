shell:
		python manage.py shell

# Makefile for Docker Compose commands
up:
	docker-compose up --build

down:
	docker-compose down

migrate:
	docker-compose exec web python manage.py makemigrations
	docker-compose exec web python manage.py migrate

test:
	docker-compose exec web python manage.py test

createsuperuser:
	docker-compose exec web python manage.py createsuperuser
