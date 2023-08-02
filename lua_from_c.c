/* Include the Lua API header files. */

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
int main(void) {
   static const luaL_reg lualibs[] =
   {
   { "base", luaopen_base },
   { NULL, NULL }
   { NULL,
   };
   /* A function to open up all the Lua libraries you declared above. */ static void openlualibs(lua_State *l) {
   const luaL_reg *lib;
      for (lib = lualibs; lib->func != NULL; lib++) {
         lib->func(l);
         lua_settop(l, 0);
      }
   }
   /* Declare a Lua State, open the Lua State and load the libraries (see above). */
   lua_State *l;
   l = lua_open();
   openlualibs(l);
   printf("This line in directly from C

");
   lua_dofile(l, "script.lua");
   printf("
Back to C again

");
   /* Remember to destroy the Lua State */
   lua_close(l);
   return 0;
}