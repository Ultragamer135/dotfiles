vim.g.mapleader = " "

vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim", -- Mini.nvim - text objects, surround actions, icons, and status line
  "https://github.com/stevearc/oil.nvim", -- file explorer
  "https://github.com/NicolasGB/jj.nvim", -- Jujutsu integration
  "https://github.com/folke/which-key.nvim", -- keymap hints
  "https://github.com/folke/flash.nvim", -- jump navigation
  "https://github.com/nvim-lua/plenary.nvim", -- dependency utilities
  "https://github.com/folke/todo-comments.nvim", -- TODO highlighting
  "https://github.com/lewis6991/gitsigns.nvim", -- Git signs and hunks
  "https://github.com/nvim-treesitter/nvim-treesitter", -- parsers and queries
  "https://github.com/neovim/nvim-lspconfig", -- LSP server configs
  "https://github.com/MunifTanjim/nui.nvim", -- UI dependency
  "https://github.com/folke/noice.nvim", -- command and message UI
  "https://github.com/chipsenkbeil/distant.nvim" -- Distant Editing
})

require("mini.icons").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.statusline").setup()
require('mini.pick').setup()
require('mini.files').setup({
  mappings = {
    close = '<Esc>',
    go_in = '<Right>',
    go_out = '<Left>',
  },
})
require("oil").setup()
require("jj").setup()
require("todo-comments").setup()
require("gitsigns").setup()
require('distant'):setup()
require("noice").setup({
  lsp = {
    hover = {
      enabled = false,
    },
  },
  messages = {
    view_search = false
  }
})

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- nvim-lspconfig supplies standard server definitions; Neovim still provides the LSP client and completion system.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.list_extend(
          { vim.env.VIMRUNTIME },
          vim.api.nvim_get_runtime_file("", true)
        ),
      },
    },
  },
})

vim.lsp.enable({ "lua_ls", "jsonls", "vtsls", "svelte", "astro", "marksman", "c_sharp", "go" })

local function show_lsp_hover()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" }) == 0 then
    return
  end

  local width = math.min(60, math.max(20, vim.o.columns - 4))
  vim.lsp.buf.hover({
    anchor_bias = "below",
    border = "rounded",
    focusable = false,
    max_height = math.floor(vim.o.lines * 0.4),
    close_events = { "BufLeave" },
    relative = "editor",
    offset_x = math.max(0, vim.o.columns - 3),
    silent = true,
    width = width,
  })
end

vim.api.nvim_create_autocmd("CursorHold", {
  callback = show_lsp_hover,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf, silent = true }

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end

    vim.keymap.set("n", "K", show_lsp_hover, vim.tbl_extend("force", opts, {
      desc = "Show documentation",
    }))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
      desc = "Go to definition",
    }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
      desc = "Find references",
    }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
      desc = "Rename symbol",
    }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
      desc = "Code action",
    }))
  end,
})

vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get)

require("which-key").setup({
  triggers = {
    { "<auto>", mode = "nxso" },
    { "s", mode = { "n", "x" } },
  },
  preset = {
    motions = true,
    text_objects = true,
  },
  win = {
    width = math.huge,
  },
  layout = {
    width = { min = 20, max = 60 },
  },
})

require("flash").setup()

-- Custom keymaps
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "-", "<cmd>Oil<cr>")
vim.keymap.set("n", "<leader>jj", "<cmd>J status<cr>")
vim.keymap.set("n", "<C-w><Left>", "<C-w>h", {
  desc = "Move to left split",
})
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", {
  desc = "Move to right split",
})
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", {
  desc = "Move to upper split",
})
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", {
  desc = "Move to lower split",
})
vim.keymap.set({ "n", "x", "o" }, "r", function()
  require("flash").jump()
end)
vim.keymap.set('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open File Explorer' })

-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.updatetime = 250
-- Splits
vim.o.splitbelow = true
vim.o.splitright = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- Indentation
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = vim.o.shiftwidth
-- Searching
vim.o.smartcase = true
vim.o.hlsearch = false
