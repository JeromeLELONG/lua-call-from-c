

build-lua-from-c: 
	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-standart-lua-from-c: 
	cc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-standart-lua-from-c-with-libs: 
	cc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -Wl,-rpath=/usr/lib/lua5.1 -llua5.1


look-for-libraries-lua:
	ld -llua5.1 --verbose
#   	ld -lliblua5.1 --verbose

look-for-zlib:
	ld -lzlib --verbose

start: ## Run ALL the services in development mode
	docker-compose up --build
	
stop: ## start e2e tests in already running container
	docker-compose down

delete-images:
	docker rmi lua-call-from-c_docker-lua-builder
	docker rmi lua-call-from-c_docker-lua-tester

connect-builder: ## Start a terminal session in server container
	docker-compose exec docker-lua-builder bash

connect-tester: ## Start a terminal session in server container
	docker-compose exec docker-lua-tester bash