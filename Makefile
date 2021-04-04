docker-setup:
	./vendor/bin/sail up -d # get services running

backend-install:
	./vendor/bin/sail composer i

backend-setup:
	make backend-install
	./vendor/bin/sail php artisan key:generate
	./vendor/bin/sail php artisan migrate

backend-seed:
	./vendor/bin/sail php artisan db:seed

frontend-clean:
	rm -rf node_modules
	rm package-lock.json
	./vendor/bin/sail npm cache clean --force

frontend-install:
	make frontend-clean
	./vendor/bin/sail npm i
	./vendor/bin/sail npx mix

dev:
	make docker-setup
	make backend-setup
	make backend-seed
	make frontend-install

watch:
	./vendor/bin/sail npx mix watch
