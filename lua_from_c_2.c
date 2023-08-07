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
    luaL_dostring(l, "min, _, max = min_moyenne_max(78, 34, 91, 7, 28)");
    luaL_dostring(l, "print(\"Le minimum et le maximum des nombres sont\", min, max)");
    luaL_dostring(l, "print(\"--I am using Lua from within C--\")");
    printf("%s", lua_tostring(l, 1));
    lua_pushstring(l, "nick");         // push a string on the stack
    lua_setglobal(l, "name");          // set the string to the global 'name'

    luaL_loadstring(l, "print(name)"); // load a script
    lua_pcall(l, 0, 0, 0);  
    
    luaL_loadstring(l, "print(min)"); // load a script
    lua_pcall(l, 0, 0, 0);  
    return 0;
}