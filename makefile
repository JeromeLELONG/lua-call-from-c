
CC= gcc
CFLAGS= -g $(shell pkg-config --cflags lua5.1) -Wall -Wextra
LDFLAGS+= $(shell pkg-config --libes lua5.1)

build-lua-from-c: 
	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-lua-from-c-3: 
	gcc -o embed_3 lua_from_c_3.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-lua-from-c-with-lua-api: 
	gcc -O2 -Wall    -c -o lapi.o lapi.c
	gcc -O2 -Wall    -c -o lcode.o lcode.c
	gcc -O2 -Wall    -c -o ldebug.o ldebug.c
	gcc -O2 -Wall    -c -o ldo.o ldo.c
	gcc -O2 -Wall    -c -o ldump.o ldump.c
	gcc -O2 -Wall    -c -o lfunc.o lfunc.c
	gcc -O2 -Wall    -c -o lgc.o lgc.c
	gcc -O2 -Wall    -c -o llex.o llex.c
	gcc -O2 -Wall    -c -o lmem.o lmem.c
	gcc -O2 -Wall    -c -o lobject.o lobject.c
	gcc -O2 -Wall    -c -o lopcodes.o lopcodes.c
	gcc -O2 -Wall    -c -o lparser.o lparser.c
	gcc -O2 -Wall    -c -o lstate.o lstate.c
	gcc -O2 -Wall    -c -o lstring.o lstring.c
	gcc -O2 -Wall    -c -o ltable.o ltable.c
	gcc -O2 -Wall    -c -o ltm.o ltm.c
	gcc -O2 -Wall    -c -o lundump.o lundump.c
	gcc -O2 -Wall    -c -o lvm.o lvm.c
	gcc -O2 -Wall    -c -o lzio.o lzio.c
	gcc -O2 -Wall    -c -o lauxlib.o lauxlib.c
	gcc -O2 -Wall    -c -o lbaselib.o lbaselib.c
	gcc -O2 -Wall    -c -o ldblib.o ldblib.c
	gcc -O2 -Wall    -c -o liolib.o liolib.c
	gcc -O2 -Wall    -c -o lmathlib.o lmathlib.c
	gcc -O2 -Wall    -c -o loslib.o loslib.c
	gcc -O2 -Wall    -c -o ltablib.o ltablib.c
	gcc -O2 -Wall    -c -o lstrlib.o lstrlib.c
	gcc -O2 -Wall    -c -o loadlib.o loadlib.c
	gcc -O2 -Wall    -c -o linit.o linit.c
	gcc -O2 -Wall    -c -o struct.o struct.c
	gcc -O2 -Wall    -c -o lfs.o lfs.c
	ar rcu liblua.a lapi.o lcode.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o ltm.o lundump.o lvm.o lzio.o lauxlib.o lbaselib.o ldblib.o liolib.o lmathlib.o loslib.o ltablib.o lstrlib.o loadlib.o linit.o struct.o lfs.o
	gcc -O2 -Wall    -c -o embed.o lua_from_c_2.c
	gcc -o executable  embed.o liblua.a -lm

build-standart-lua-from-c: 
	cc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-standart-lua-from-c-with-libs: 
#	cc  -o embed lua_from_c_2.c -I/usr/include/lua5.1 -Wl,-Bstatic,-rpath=/usr/lib/lua5.1 -llua5.1
#	cc  -o embed lua_from_c_2.c -I/usr/include/lua5.1 -Wl,-Bstatic,-rpath=/usr/lib/lua5.1 -l:liblua5.1.so.0
#	cc  -o embed lua_from_c_2.c -I/usr/include/lua5.1 -Wl,-Bstatic,-rpath=/usr/lib/lua5.1 -l:liblua5.1.a
	cc  -o embed lua_from_c_2.c -I/usr/include/lua5.1 -W -l:liblua5.1.so.0
	
link-library-to-executable:
	gcc -o executable embed


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