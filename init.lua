-- ~/.config/nvim/init.lua

-- Leader key must be defined before plugins load.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editing behavior
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.mousemoveevent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.ambiwidth = "single"
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- Neovim 0.12.2 starts Treesitter for Markdown from the bundled ftplugin.
-- On this setup it crashes before our FileType autocmd can stop it, so block
-- Markdown Treesitter start calls before ftplugins run.
local treesitter_start = vim.treesitter.start
vim.treesitter.start = function(bufnr, lang)
  local target = bufnr or 0
  local ok, ft = pcall(function()
    return vim.bo[target].filetype
  end)
  if (ok and (ft == "markdown" or ft == "markdown.mdx")) or lang == "markdown" or lang == "markdown_inline" then
    return
  end
  return treesitter_start(bufnr, lang)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        pcall(vim.treesitter.stop, args.buf)
      end
    end)
  end,
})

-- Keep netrw disabled because neo-tree provides a more VSCode-like explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function is_file_explorer_open()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      return true
    end
  end
  return false
end

function _G.toggle_file_explorer()
  if is_file_explorer_open() then
    vim.cmd("Neotree close source=filesystem position=left")
  else
    vim.cmd("Neotree reveal left")
  end
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>?", group = "help" },
      },
    },
  },

  {
    "keaising/im-select.nvim",
    event = "VeryLazy",
    cond = function()
      return vim.fn.executable("macism") == 1 or vim.fn.executable("im-select") == 1
    end,
    opts = function()
      local command = vim.fn.executable("macism") == 1 and "macism" or "im-select"
      return {
        default_im_select = "com.apple.keylayout.ABC",
        default_command = command,
        set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
        set_previous_events = { "InsertEnter" },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          "location",
          {
            function()
              return "TIP"
            end,
            color = { gui = "bold" },
            on_click = function()
              if _G.show_korean_tips then
                _G.show_korean_tips(nil, { focus = true })
              end
            end,
          },
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-b>", "<cmd>lua _G.toggle_file_explorer()<cr>", desc = "파일 탐색기 열기/닫기" },
      { "<C-n>", "<cmd>lua _G.toggle_file_explorer()<cr>", desc = "파일 탐색기 열기/닫기" },
      { "<leader>e", "<cmd>lua _G.toggle_file_explorer()<cr>", desc = "파일 탐색기 열기/닫기" },
      { "<leader>E", "<cmd>Neotree reveal left<cr>", desc = "현재 파일 위치 보기" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 32,
        mappings = {
          ["<C-b>"] = function()
            _G.toggle_file_explorer()
          end,
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "파일 찾기" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "프로젝트 전체 검색" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "열린 파일 목록" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "도움말 검색" },
      { "<leader>p", "<cmd>Telescope commands<cr>", desc = "명령 팔레트" },
      { "<C-S-p>", "<cmd>Telescope commands<cr>", desc = "명령 팔레트" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        disable = { "markdown", "markdown_inline" },
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_port = "8755"
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown 미리보기 토글" },
      { "<leader>mo", "<cmd>MarkdownPreview<cr>", ft = "markdown", desc = "Markdown 미리보기 열기" },
      { "<leader>mc", "<cmd>MarkdownPreviewStop<cr>", ft = "markdown", desc = "Markdown 미리보기 닫기" },
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        "black",
        "prettier",
      },
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local on_attach = function(_, bufnr)
        local map = function(keys, command, desc)
          vim.keymap.set("n", keys, command, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "정의로 이동")
        map("gr", vim.lsp.buf.references, "참조 찾기")
        map("K", vim.lsp.buf.hover, "문서 보기")
        map("<leader>lr", vim.lsp.buf.rename, "이름 바꾸기")
        map("<leader>la", vim.lsp.buf.code_action, "빠른 수정")
        map("<leader>ld", vim.diagnostic.open_float, "현재 줄 오류 보기")
        map("[d", vim.diagnostic.goto_prev, "이전 오류")
        map("]d", vim.diagnostic.goto_next, "다음 오류")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        pyright = {},
        ts_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
      }

      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = true,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "파일 포맷",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function()
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },
}, {
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- General keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "검색 강조 지우기" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "왼쪽 창으로 이동" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "아래 창으로 이동" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "위 창으로 이동" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "오른쪽 창으로 이동" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "저장" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "닫기" })
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "저장" })
vim.keymap.set("n", "<C-w>", "<cmd>q<CR>", { desc = "현재 창 닫기" })

local function open_file_explorer(opts)
  local args = opts.args or ""
  if args ~= "" then
    local dir = vim.fn.fnamemodify(args, ":p")
    vim.cmd("Neotree reveal left dir=" .. vim.fn.fnameescape(dir))
  else
    _G.toggle_file_explorer()
  end
end

vim.api.nvim_create_user_command("Folder", open_file_explorer, { nargs = "?", complete = "dir", desc = "파일 탐색기 열기" })
vim.api.nvim_create_user_command("Tree", open_file_explorer, { nargs = "?", complete = "dir", desc = "파일 탐색기 열기" })
vim.api.nvim_create_user_command("Files", open_file_explorer, { nargs = "?", complete = "dir", desc = "파일 탐색기 열기" })
vim.api.nvim_create_user_command("Dir", open_file_explorer, { nargs = "?", complete = "dir", desc = "파일 탐색기 열기" })

local korean_command_aliases = {
  ["ㅂ"] = "q",
  ["ㅈ"] = "w",
  ["ㅈㅂ"] = "wq",
  ["ㅌ"] = "x",
  ["ㅂㅁ"] = "qa",
  ["ㅈㅂㅁ"] = "wqa",
  ["ㄷ"] = "e",
  ["ㄷㅇㅑㅅ"] = "edit",
  ["ㅠㅇ"] = "bd",
  ["ㅠㅜ"] = "bn",
  ["ㅠㅔ"] = "bp",
  ["ㅣㄴ"] = "ls",
  ["ㅠㅕㄹㄹㄷㄱㄴ"] = "buffers",
  ["ㅜㅐㅗ"] = "noh",
  ["ㅜㅐㅗㅣㄴㄷㅁㄱㅊㅗ"] = "nohlsearch",
  ["ㅗㄷㅣㅔ"] = "help",
  ["ㅅㅁㅠㅜㄷㅈ"] = "tabnew",
  ["ㅅㅁㅠㅜㄷㅌㅅ"] = "tabnext",
  ["ㅅㅁㅠㅔㄱㄷㅍ"] = "tabprev",
  ["ㅅㅁㅠ채ㅐㄴㄷ"] = "tabclose",
  ["ㄹㅐㅣㅇㄷㄱ"] = "Folder",
  ["ㄹㅑㅣㄷㄴ"] = "Files",
  ["ㅅㄱㄷㄷ"] = "Tree",
  ["ㅇㅑㄱ"] = "Dir",
  ["ㄷㅌㅔㅣㅐㄱㄷ"] = "Folder",
}

vim.keymap.set("c", "<CR>", function()
  if vim.fn.getcmdtype() ~= ":" then
    return "<CR>"
  end

  local command = vim.fn.getcmdline()
  local leading, range, token, bang, rest = command:match("^(%s*)([%d%%'<>,.$%-%+;]*)([^%s!]+)(!?)(.*)$")
  if not token then
    return "<CR>"
  end

  local translated = korean_command_aliases[token]
  if not translated then
    return "<CR>"
  end

  return ("<C-u>%s%s%s%s<CR>"):format(range or leading or "", translated, bang or "", rest or "")
end, { expr = true, desc = "한글 명령어 보정" })

local function show_korean_help()
  local lines = {
    "Neovim 초보자 단축키",
    "",
    "i              입력 시작",
    "Esc            입력 종료 / 명령 모드",
    "Space e        파일 탐색기",
    "Space ff       파일 찾기",
    "Space fg       프로젝트 전체 검색",
    "Space p        명령 팔레트",
    "Ctrl+s         저장",
    "Space w        저장",
    "Space q        닫기",
    "Ctrl+w         현재 창 닫기",
    "gd             정의로 이동",
    "K              문서 보기",
    "Space la       빠른 수정",
    "Space lf       파일 포맷",
    "",
    "한글 입력 팁",
    "Normal mode에서 명령키가 안 먹으면 입력기를 영문으로 바꾸세요.",
    ":ㅂ, :ㅈ, :ㅈㅂ  :q, :w, :wq로 실행",
    ":ㅂ!, :ㅈ!     :q!, :w!로 실행",
    "macOS에서 macism 또는 im-select가 있으면 자동 전환됩니다.",
  }

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.min(width + 4, vim.o.columns - 4),
    height = #lines,
    row = math.max(0, math.floor((vim.o.lines - #lines) / 2) - 1),
    col = math.max(0, math.floor((vim.o.columns - width) / 2) - 2),
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, desc = "도움말 닫기" })
end

vim.keymap.set("n", "<leader>?", show_korean_help, { desc = "초보자 도움말" })
vim.api.nvim_create_user_command("NvimHelpKo", show_korean_help, { desc = "한글 Neovim 초보자 도움말" })

local tip_sections = {
  project = {
    title = "프로젝트를 처음 열었을 때",
    lines = {
      "Ctrl+b        파일 탐색기 열기/닫기",
      ":Folder .     현재 폴더를 탐색기로 보기",
      ":Folder ~/dev 특정 폴더 열기",
      "Space ff      파일 이름으로 빠르게 찾기",
      "Space fg      프로젝트 전체에서 문자열 검색",
    },
  },
  edit = {
    title = "파일을 편집할 때",
    lines = {
      "i             입력 시작",
      "Esc           명령 모드로 돌아가기",
      "Ctrl+s        저장",
      "Space w       저장",
      "Space q       닫기",
      "Ctrl+w        현재 창 닫기",
      ":wq           저장 후 닫기",
      ":q!           저장하지 않고 닫기",
      "u             실행 취소",
      "Ctrl+r        다시 실행",
    },
  },
  files = {
    title = "여러 파일을 오갈 때",
    lines = {
      "Space fb      열린 파일 목록 보기",
      "Space p       명령 팔레트 열기",
      ":bn           다음 버퍼",
      ":bp           이전 버퍼",
      ":bd           현재 버퍼 닫기",
      "Ctrl+h/j/k/l  왼쪽/아래/위/오른쪽 창으로 이동",
    },
  },
  code = {
    title = "코드를 읽거나 고칠 때",
    lines = {
      "gd            정의로 이동",
      "gr            참조 찾기",
      "K             문서/타입 설명 보기",
      "Space lr      이름 바꾸기",
      "Space la      빠른 수정",
      "Space ld      진단 메시지 보기",
      "]d / [d       다음/이전 오류로 이동",
      "Space lf      파일 포맷",
    },
  },
  markdown = {
    title = "Markdown 문서를 쓸 때",
    lines = {
      "Space mp      미리보기 열기/닫기",
      "Space mo      미리보기 열기",
      "Space mc      미리보기 닫기",
      "localhost:8755 고정 preview 포트",
    },
  },
  trouble = {
    title = "화면이 이상하거나 확인이 필요할 때",
    lines = {
      "Esc           검색 강조 지우기",
      ":noh          검색 강조 지우기",
      "Space         단축키 안내 보기",
      "Space ?       초보자 도움말",
      ":Lazy         플러그인 상태 확인",
      ":Mason        언어 도구 상태 확인",
    },
  },
}

local tip_menu = {
  { key = "project", label = "프로젝트 시작" },
  { key = "edit", label = "파일 편집" },
  { key = "files", label = "파일 이동" },
  { key = "code", label = "코드 작업" },
  { key = "markdown", label = "Markdown" },
  { key = "trouble", label = "문제 해결" },
}

local tips_state = {
  buf = nil,
  win = nil,
  current = "project",
}

local function tips_window_is_valid()
  return tips_state.win and vim.api.nvim_win_is_valid(tips_state.win)
end

local function show_korean_tips(initial_section, opts)
  opts = opts or {}
  tips_state.current = initial_section or tips_state.current or "project"

  if not tips_state.buf or not vim.api.nvim_buf_is_valid(tips_state.buf) then
    tips_state.buf = vim.api.nvim_create_buf(false, true)
  end

  local function render()
    local section = tip_sections[tips_state.current] or tip_sections.project
    local lines = {
      "상황별 사용 팁",
      "하단 상태바의 TIP 위에 마우스를 올리거나 클릭하면 열립니다. q로 닫습니다.",
      "",
    }

    for index, item in ipairs(tip_menu) do
      local marker = item.key == tips_state.current and "*" or " "
      table.insert(lines, string.format("%s %d. %s", marker, index, item.label))
    end

    table.insert(lines, "")
    table.insert(lines, section.title)
    table.insert(lines, string.rep("-", vim.fn.strdisplaywidth(section.title)))

    for _, line in ipairs(section.lines) do
      table.insert(lines, line)
    end

    vim.bo[tips_state.buf].modifiable = true
    vim.api.nvim_buf_set_lines(tips_state.buf, 0, -1, false, lines)
    vim.bo[tips_state.buf].modifiable = false
  end

  render()

  if tips_window_is_valid() then
    if opts.focus ~= false then
      vim.api.nvim_set_current_win(tips_state.win)
    end
  else
    tips_state.win = vim.api.nvim_open_win(tips_state.buf, opts.focus ~= false, {
      relative = "editor",
      width = math.min(70, vim.o.columns - 4),
      height = math.min(20, vim.o.lines - 4),
      row = math.max(0, vim.o.lines - 23),
      col = 2,
      style = "minimal",
      border = "rounded",
    })
  end

  local function choose(index)
    local item = tip_menu[index]
    if item then
      tips_state.current = item.key
      render()
    end
  end

  for index = 1, #tip_menu do
    vim.keymap.set("n", tostring(index), function()
      choose(index)
    end, { buffer = tips_state.buf, nowait = true, desc = "팁 선택 " .. index })
  end

  vim.keymap.set("n", "<LeftRelease>", function()
    local mouse = vim.fn.getmousepos()
    if mouse.winid ~= tips_state.win then
      return
    end
    local index = mouse.line - 3
    choose(index)
  end, { buffer = tips_state.buf, nowait = true, desc = "마우스로 팁 선택" })

  local function close_tips()
    if tips_window_is_valid() then
      vim.api.nvim_win_close(tips_state.win, true)
    end
  end

  for _, key in ipairs({ "q", "<Esc>", "ㅂ" }) do
    vim.keymap.set("n", key, close_tips, { buffer = tips_state.buf, nowait = true, desc = "팁 닫기" })
  end
end

_G.show_korean_tips = show_korean_tips

vim.keymap.set("n", "<leader>t", show_korean_tips, { desc = "상황별 팁" })
vim.api.nvim_create_user_command("NvimTipsKo", function()
  show_korean_tips()
end, { desc = "한글 상황별 Neovim 사용 팁" })

vim.cmd([[silent! aunmenu PopUp.상황별\ 팁<Tab>Space\ t]])
vim.cmd([[anoremenu <silent> 499.10 PopUp.상황별\ 팁<Tab>Space\ t :NvimTipsKo<CR>]])
vim.cmd([[silent! aunmenu PopUp.Markdown\ 미리보기<Tab>Space\ mp]])
vim.cmd([[anoremenu <silent> 499.20 PopUp.Markdown\ 미리보기<Tab>Space\ mp :MarkdownPreviewToggle<CR>]])

local last_tip_hover = 0
vim.keymap.set("n", "<MouseMove>", function()
  local mouse = vim.fn.getmousepos()
  local in_tip_hotspot = mouse.screenrow >= vim.o.lines - 2 and mouse.screencol >= vim.o.columns - 8
  if not in_tip_hotspot or tips_window_is_valid() then
    return
  end

  local now = vim.uv.now()
  if now - last_tip_hover < 500 then
    return
  end
  last_tip_hover = now
  show_korean_tips(nil, { focus = false })
end, { desc = "상태바 TIP 마우스오버 팁" })

local startup_state = {
  buf = nil,
  win = nil,
}

local function startup_window_is_valid()
  return startup_state.win and vim.api.nvim_win_is_valid(startup_state.win)
end

local function close_startup_status()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "nvim-startup-status" then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end

  startup_state.win = nil
  startup_state.buf = nil
end

local function get_git_status_lines()
  if vim.fn.executable("git") ~= 1 then
    return { "Git: git 명령을 찾을 수 없음" }
  end

  local inside = vim.fn.systemlist({ "git", "rev-parse", "--is-inside-work-tree" })
  if vim.v.shell_error ~= 0 or inside[1] ~= "true" then
    return { "Git: 저장소 아님" }
  end

  local branch = vim.fn.systemlist({ "git", "branch", "--show-current" })[1]
  if branch == nil or branch == "" then
    branch = vim.fn.systemlist({ "git", "rev-parse", "--short", "HEAD" })[1] or "detached"
  end

  local status = vim.fn.systemlist({ "git", "status", "--short" })
  local lines = { "Git branch: " .. branch }
  if #status == 0 then
    table.insert(lines, "Git status: clean")
  else
    table.insert(lines, "Git status: " .. #status .. " changed file(s)")
    for index, item in ipairs(status) do
      if index > 8 then
        table.insert(lines, "  ...")
        break
      end
      table.insert(lines, "  " .. item)
    end
  end

  return lines
end

local function show_startup_status()
  close_startup_status()

  local cwd = vim.fn.getcwd()
  local lines = {
    "시작 상태",
    "",
    "현재 폴더: " .. cwd,
    "",
  }

  vim.list_extend(lines, get_git_status_lines())
  vim.list_extend(lines, {
    "",
    "Ctrl+b 파일 탐색기  Space p 명령 팔레트  Space t 팁",
    "q / Esc / ㅂ 으로 닫기",
  })

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  startup_state.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(startup_state.buf, 0, -1, false, lines)
  vim.bo[startup_state.buf].filetype = "nvim-startup-status"
  vim.bo[startup_state.buf].modifiable = false

  startup_state.win = vim.api.nvim_open_win(startup_state.buf, true, {
    relative = "editor",
    width = math.min(width + 4, vim.o.columns - 4),
    height = math.min(#lines, vim.o.lines - 4),
    row = 1,
    col = 2,
    style = "minimal",
    border = "rounded",
  })

  for _, key in ipairs({ "q", "<Esc>", "ㅂ" }) do
    vim.keymap.set("n", key, close_startup_status, { buffer = startup_state.buf, nowait = true, desc = "시작 상태 닫기" })
  end
end

vim.keymap.set("n", "q", function()
  if startup_window_is_valid() then
    close_startup_status()
    return ""
  end
  return "q"
end, { expr = true, desc = "시작 상태 닫기 또는 q" })

vim.keymap.set("n", "ㅂ", function()
  if startup_window_is_valid() then
    close_startup_status()
  end
end, { desc = "시작 상태 닫기" })

vim.keymap.set("n", "<Esc>", function()
  if startup_window_is_valid() then
    close_startup_status()
  else
    vim.cmd("nohlsearch")
  end
end, { desc = "시작 상태 닫기 또는 검색 강조 지우기" })

vim.api.nvim_create_user_command("NvimStartupStatus", show_startup_status, { desc = "현재 폴더와 Git 상태 보기" })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      if vim.o.columns > 20 and vim.o.lines > 8 then
        show_startup_status()
      end
    end)
  end,
})
