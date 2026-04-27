vim.g.cmux_nvim_lang = "ja"
dofile(vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h") .. "/init.lua")
