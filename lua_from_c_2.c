//extern "C" {
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
//}
int main(int argc, char **argv)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    luaL_dostring(L, "print('hello, '.._VERSION)");
    lua_State *l;
    l = lua_open();
    //openlualibs(l);
    luaL_openlibs(l);
    printf("This line in directly from C\n");
    luaL_dofile(l, "min_moyenne_max.lua");
    return 0;
}