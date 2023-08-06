FROM debian:11
RUN apt update && apt -y install git build-essential
RUN apt-get install -y liblua5.1-0-dev
COPY ./makefile /test_lua/makefile
COPY ./lua_from_c_2.c /test_lua/lua_from_c_2.c
COPY ./min_moyenne_max.lua /test_lua/min_moyenne_max.lua