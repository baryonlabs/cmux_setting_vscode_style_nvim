vim.g.cmux_nvim_lang = "en"
local dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")
local base = dir .. "/cmux-base.lua"
if vim.uv.fs_stat(base) then
  dofile(base)
else
  if vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":t") == "init.lua" then
    error("cmux-base.lua is required when installing a language entrypoint as init.lua")
  end
  dofile(dir .. "/init.lua")
end
