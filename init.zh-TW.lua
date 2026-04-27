vim.g.cmux_nvim_lang = "zh-TW"
dofile(vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h") .. "/init.lua")
