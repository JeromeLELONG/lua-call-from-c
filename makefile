

build-lua-from-c: 
	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib

build-standart-lua-from-c: 
	cc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1
#   	gcc -o embed lua_from_c_2.c -I/usr/include/lua5.1 -L/usr/lib/lua5.1 -llua5.1 -lliblua5.1
#	gcc -o embed lua_from_c.c -I/usr/local/include -L/usr/local/lib -llua -llualib


look-for-libraries-lua:
	ld -llua5.1 --verbose
#   	ld -lliblua5.1 --verbose

look-for-zlib:
	ld -lzlib --verbose