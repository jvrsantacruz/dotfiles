-- Modern Neovim Configuration (2026)
-- Migrated from init.vim with modern idiomatic plugins

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM (Modern Plugin Manager)
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================
vim.g.mapleader = " " -- Set leader key to space

-- Visual settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.title = true
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.laststatus = 2
vim.opt.display = "lastline"
vim.opt.ttyfast = true
vim.opt.lazyredraw = true

-- Backup and undo settings
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.config/nvim/files/backup/")
vim.opt.backupext = "-vimbackup"
vim.opt.directory = vim.fn.expand("~/.config/nvim/files/swap/")
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/files/undo/")

-- Create directories if they don't exist
for _, dir in ipairs({ "backup", "swap", "undo" }) do
  local path = vim.fn.expand("~/.config/nvim/files/" .. dir)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,latin1"

-- Editing settings
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.backspace = "indent,eol,start"
vim.opt.textwidth = 79
vim.opt.colorcolumn = "79"

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wildmode = "longest,list"
vim.opt.wildmenu = true
vim.opt.wildignore = "*.swp,*.bak,*.pyc,*.class,bower_components,node_modules,build/**,dist/**"

-- History
vim.opt.history = 1000
vim.opt.undolevels = 1000

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = { tab = ">·", trail = "·", extends = "#", nbsp = "·" }

-- ============================================================================
-- PLUGINS
-- ============================================================================
require("lazy").setup({
  -- Color schemes
  { "morhetz/gruvbox" },
  { "altercation/vim-colors-solarized" },
  { "arcticicestudio/nord-vim" },
  { "folke/tokyonight.nvim", priority = 1000 },

  -- Treesitter (Modern syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "python", "go", "lua", "vim", "bash", "javascript", "html", "css", "json", "yaml", "toml", "markdown", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use mason-lspconfig's automatic setup (avoids deprecated lspconfig API)
      require("mason-lspconfig").setup({
        -- Install only core servers automatically, others install on-demand via :Mason
        ensure_installed = { "lua_ls", "pyright", "gopls" },
        automatic_installation = true, -- Auto-install servers when opening files
        handlers = {
          -- Default handler for all servers
          function(server_name)
            vim.lsp.enable(server_name)
          end,

          -- Custom handler for lua_ls (needs special config)
          ["lua_ls"] = function()
            vim.lsp.config.lua_ls = {
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                },
              },
            }
            vim.lsp.enable("lua_ls")
          end,
        },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
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
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Telescope (Fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              width = 0.95,        -- Use 95% of screen width
              height = 0.90,       -- Use 90% of screen height
              preview_width = 0.55, -- Preview takes 55% of the width
            },
          },
        },
      })
    end,
  },

  -- Neo-tree (File explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 30 },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  },

  -- Lualine (Status line)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "diagnostics" },  -- Removed 'branch'
          lualine_c = {
            { "filename", path = 1 }  -- Show relative path
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },  -- GitHub support for :GBrowse
  { "shumphrey/fugitive-gitlab.vim" },

  -- Diffview (visual diff and commit review)
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup()
    end,
  },

  -- Formatting and linting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black", "isort" },
          go = { "gofmt", "goimports" },
          lua = { "stylua" },
          javascript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = false, -- Manual formatting with <leader>f
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
        go = { "golangcilint" },
      }

      -- Auto-lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- Tpope essentials
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-characterize" },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment.nvim (Modern commenting)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Undotree (Undo history visualizer)
  { "mbbill/undotree" },

  -- Tagbar alternative (Symbol outline)
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  },

  -- File type support
  { "cespare/vim-toml" },
  { "chr4/nginx.vim" },
  { "elzr/vim-json" },
  { "avakhov/vim-yaml" },
  { "rodjek/vim-puppet" },

  -- EditorConfig support
  { "editorconfig/editorconfig-vim" },

  -- Startify (Start screen)
  { "mhinz/vim-startify" },

  -- Grepper (Multi-tool search)
  { "mhinz/vim-grepper" },

  -- Which-key (Keybinding hints)
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Trouble (diagnostics panel)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },

  -- Avante.nvim (Claude AI Assistant)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-5-20250929",
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,  -- Increased for more context
          },
        },
      },
      behaviour = {
        auto_suggestions = true, -- Enable auto-suggestions
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
        auto_add_current_file = true,  -- DOCUMENTED: Auto-add current file to chat
      },
      -- DOCUMENTED: File selector for choosing context files
      selector = {
        provider = "native",  -- Use native selector
      },
      -- DOCUMENTED: Global instructions file (managed by stow)
      instructions_file = vim.fn.expand("~/.config/avante/avante.md"),
      -- DOCUMENTED: System prompt customization
      system_prompt = [[You are an expert programmer. Consider LSP types, diagnostics, and project structure when making suggestions.]],
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<C-y>",  -- Changed to Ctrl+y (works reliably on macOS)
          next = "<C-n>",    -- Changed to Ctrl+n
          prev = "<C-p>",    -- Changed to Ctrl+p
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- Sidebar on the right
        wrap = true,
        width = 30, -- % of editor width
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua", -- optional
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
})

-- ============================================================================
-- COLORSCHEME
-- ============================================================================
vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark"

-- Highlight customization
vim.api.nvim_set_hl(0, "SpellBad", { underline = true, fg = "Red" })
vim.api.nvim_set_hl(0, "BadWhitespace", { bg = "red" })

-- Match bad whitespace patterns (globally, except tabs)
vim.fn.matchadd("BadWhitespace", [[^\s\+$]])  -- Trailing whitespace

-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================
local keymap = vim.keymap.set

-- Telescope
keymap("n", "<leader>t", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- Undotree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })

-- Aerial (symbol outline)
keymap("n", "<leader>h", "<cmd>AerialToggle<cr>", { desc = "Toggle symbol outline" })

-- Format with conform
keymap("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Lint current file (works for all languages)
keymap("n", "<leader>l", function()
  require("lint").try_lint()
  vim.cmd("lopen")
end, { desc = "Lint and show errors" })

-- Cleanup trailing spaces
keymap("n", "<leader>cs", [[:%s/\s\+$//g<CR>]], { desc = "Clean trailing spaces" })

-- Fix tabs to spaces
keymap("n", "<leader>ct", [[:%s/\t/    /g<CR>]], { desc = "Convert tabs to spaces" })

-- Sudo write
keymap("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Sudo write" })

-- Change directory to current file
keymap("n", "<leader>cd", "<cmd>cd %:p:h<cr>", { desc = "CD to current file" })
keymap("n", "<leader>cdl", "<cmd>lcd %:p:h<cr>", { desc = "LCD to current file" })

-- Edit/Insert file under cursor
keymap("n", "<leader>of", "<cmd>edit <cfile><cr>", { desc = "Open file under cursor" })
keymap("n", "<leader>if", "<cmd>read <cfile><cr>", { desc = "Insert file under cursor" })

-- Search visual selection
keymap("v", "<leader>sv", [[y/<C-R>"<CR>]], { desc = "Search visual selection" })

-- Grepper
keymap("n", "gs", "<Plug>(GrepperOperator)", { desc = "Grep operator" })
keymap("x", "gs", "<Plug>(GrepperOperator)", { desc = "Grep operator" })

-- Diffview
keymap("n", "<leader>do", "<cmd>DiffviewOpen<cr>",          { desc = "Diffview: open (working tree)" })
keymap("n", "<leader>dc", "<cmd>DiffviewOpen HEAD~1<cr>",   { desc = "Diffview: review last commit" })
keymap("n", "<leader>dh", "<cmd>DiffviewFileHistory<cr>",   { desc = "Diffview: repo file history" })
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: current file history" })
keymap("n", "<leader>dx", "<cmd>DiffviewClose<cr>",         { desc = "Diffview: close" })

-- LSP keybindings
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Trouble (diagnostics panel)
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",        { desc = "Trouble: toggle diagnostics" })
keymap("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: buffer diagnostics" })
keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",             { desc = "Trouble: quickfix list" })
keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",            { desc = "Trouble: location list" })

-- Avante (Claude AI) keybindings
keymap("n", "<leader>aa", function() require("avante.api").ask() end, { desc = "Avante: Ask" })
keymap("v", "<leader>aa", function() require("avante.api").ask() end, { desc = "Avante: Ask" })
keymap("n", "<leader>ar", function() require("avante.api").refresh() end, { desc = "Avante: Refresh" })
keymap("n", "<leader>ae", function() require("avante.api").edit() end, { desc = "Avante: Edit" })
keymap("v", "<leader>ae", function() require("avante.api").edit() end, { desc = "Avante: Edit" })

-- ============================================================================
-- FILETYPE SPECIFIC SETTINGS
-- ============================================================================
local augroup = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

-- Python
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.foldenable = false
    -- Highlight tabs as bad whitespace (Python uses spaces)
    vim.fn.matchadd("BadWhitespace", [[^\t\+]])
  end,
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 99
    vim.opt_local.colorcolumn = "99"
  end,
})

-- HTML/XML
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "html", "xml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Makefile
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- ============================================================================
-- PLUGIN SPECIFIC SETTINGS
-- ============================================================================

-- Fugitive GitLab domains
vim.g.fugitive_gitlab_domains = { "http://gitlab", "http://gitlab.xcade.net" }

-- Grepper configuration
vim.g.grepper = {
  tools = { "rg", "git", "grep" },
  searchreg = 1,
}

-- Python host program
vim.g.python3_host_prog = vim.fn.exepath("python3")

print("Neovim configuration loaded successfully!")
