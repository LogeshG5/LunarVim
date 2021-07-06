local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

-- Place the below contents in .ccls in the root of the project
-- this will help ccls index if compile_commands.json is not available

-- clang
-- %c -std=c11
-- %cpp -std=c++2a
-- %h %hpp --include=Global.h
-- -Iinc
-- -DMACRO
