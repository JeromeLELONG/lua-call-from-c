#include <stdio.h>
#include <stdlib.h>
#include <lauxlib.h>
#include <lualib.h>

typedef struct Instance Instance;

struct Instance {
    int test1;
    double test2;
};

// linstance.c {

    static const char *const tname = "Instance";

    enum { f_test1, f_test2 };
    static const char *const fmap[] = { "test1", "test2" };

    static int
    l_get(lua_State *L) // (t, k) -> v
    {
        Instance *inst = *(Instance **)luaL_checkudata(L, 1, tname);

        switch (luaL_checkoption(L, 2, NULL, fmap)) {
            case f_test1: lua_pushinteger(L, inst->test1); break;
            case f_test2: lua_pushnumber(L, inst->test2); break;
        }
        return 1;
    }

    static int
    l_set(lua_State *L) // (t, k, v)
    {
        Instance *inst = *(Instance **)luaL_checkudata(L, 1, tname);

        switch (luaL_checkoption(L, 2, NULL, fmap)) {
            case f_test1: inst->test1 = luaL_checkinteger(L, 3); break;
            case f_test2: inst->test2 = luaL_checknumber(L, 3); break;
        }
        return 0;
    }

    void
    pushInstance(lua_State *L, Instance *instance)
    {
        Instance **ud = lua_newuserdata(L, sizeof(*ud));
        *ud = instance;

        if (luaL_newmetatable(L, tname)) {
            lua_pushcfunction(L, l_set);
            lua_setfield(L, -2, "__newindex");
            lua_pushcfunction(L, l_get);
            lua_setfield(L, -2, "__index");
            lua_pushstring(L, tname);
            lua_setfield(L, -2, "__metatable");
        }
        lua_setmetatable(L, -2);
    }

// }

int
main(int argc, char *argv[])
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    Instance instance = { -1, -1.0 };

    printf("%d\t\n", instance.test1);

    pushInstance(L, &instance);
    lua_setglobal(L, "instance");

    luaL_dostring(L, "print(instance.test1, instance.test2)");
    luaL_dostring(L, "instance.test1 = 3.14; instance.test2 = 3.14");
    luaL_dostring(L, "print(instance.test1, instance.test2)");
    //printf("%d\t%g\n", instance.test1, instance.test2);
    printf("%d\t\n", instance.test1);

    if (luaL_dostring(L, "print(instance.UNKNOWN)")) {
        printf("%s\n", lua_tostring(L, -1));
        lua_pop(L, 1);
    }

    lua_close(L);
    return 0;
}