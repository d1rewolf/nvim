

local M = {}
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"


--jbwif fn.empty(fn.glob(install_path)) > 0 then
--jbw  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
--jbw  execute "packadd packer.nvim"
--jbwend

vim.cmd [[packadd packer.nvim]]

local packer_config = {
    display = {
        open_fn = require('packer.util').float,
    },
}

require("plugin")

local plugins = {
    Plugin:new("packer"):enabled(true):pack{"wbthomason/packer.nvim"},

    Plugin:new("vimwiki"):enabled(true):pack{"vimwiki/vimwiki"},

    Plugin:new("black"):enabled(true):pack{"averms/black-nvim"},

    -- structure browser
    Plugin:new("aerial"):enabled(true):pack{"stevearc/aerial.nvim"},

    -- Lua based status line
    Plugin:new("lualine"):enabled(true):pack{"hoob3rt/lualine.nvim"},

    -- Nord colour theme
    Plugin:new("nord"):enabled(true):pack{"shaunsingh/nord.nvim"},

    -- icon set
    Plugin:new("nvim-web-devicons"):enabled(true):pack{"kyazdani42/nvim-web-devicons"},

    -- kitty navigation
    Plugin:new("vim-kitty-navigator"):enabled(true):pack{"knubie/vim-kitty-navigator"},

    Plugin:new("copilot"):enabled(false):pack{"github/copilot.vim"},

    -- CSV Tools
    Plugin:new("csv"):enabled(true):pack{"chrisbra/csv.vim"},

    --[[
    -- Completion
    Plugin:new("coq_nvim"):enabled(true):pack{
        "ms-jpq/coq_nvim",
        branch = "coq"
    },
    Plugin:new("coq.artifacts"):enabled(true):pack{
        "ms-jpq/coq.artifacts",
        branch = "artifacts"
    },
    ]]--

    Plugin:new("coc"):enabled(true):pack{"neoclide/coc.nvim",
    					 branch = "release"},

    -- editorconfig support
    Plugin:new("editorconfig-vim"):enabled(false):pack{"editorconfig/editorconfig-vim"},

    -- Neovim in the browser
    Plugin:new("firenvim"):enabled(true):pack{
        "glacambre/firenvim",
        run = function() vim.fn["firenvim#install"](0) end
    },

    -- Indentation guide lines
    Plugin:new("indent-blankline"):enabled(true):pack{"lukas-reineke/indent-blankline.nvim"},

    -- Code commenting
    Plugin:new("kommentary"):enabled(true):pack{"b3nj5m1n/kommentary"},

    -- Improved lsp ui
    Plugin:new("lspsaga"):enabled(true):pack{"tami5/lspsaga.nvim"},
    --Common lsp config setting
    Plugin:new("nvim-lspconfig"):enabled(true):pack{"neovim/nvim-lspconfig"},

    -- Debug Adapter Protocol
    Plugin:new("nvim-dap"):enabled(true):pack{"mfussenegger/nvim-dap"},
    Plugin:new("nvim-dap-python"):enabled(true):pack{"mfussenegger/nvim-dap-python"},
    Plugin:new("nvim-dap-ui"):enabled(true):pack{"rcarriga/nvim-dap-ui"},

    -- File Explorer Tree
    Plugin:new("nvim-tree"):enabled(true):pack{"kyazdani42/nvim-tree.lua"},

    -- Treesitter
    Plugin:new("nvim-treesitter"):enabled(true):pack{
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    },

    -- Merge Conflicts
    Plugin:new("splice"):enabled(true):pack{"sjl/splice.vim"},

    -- Help file for strftime formats
    Plugin:new("strftimedammit"):enabled(true):pack{"sjl/strftimedammit.vim"},

    -- Telescope
    Plugin:new("popup"):enabled(true):pack{"nvim-lua/popup.nvim"},
    Plugin:new("plenary"):enabled(true):pack{"nvim-lua/plenary.nvim"},
    Plugin:new("telescope"):enabled(true):pack{"nvim-telescope/telescope.nvim"},
    Plugin:new("telescope-dap"):enabled(true):pack{"nvim-telescope/telescope-dap.nvim"},

    -- Persistent, toggled terminals
    Plugin:new("toggleterm"):enabled(true):pack{"akinsho/toggleterm.nvim"},

    -- Code linting helper
    Plugin:new("trouble"):enabled(true):pack{"folke/trouble.nvim"},

    -- LaTeX integration
    Plugin:new("vimtex"):enabled(false):pack{"lervag/vimtex"},

    -- Git status flags in LHS gutter -- need to look at gitsigns as lua alternative
    Plugin:new("vim-gitgutter"):enabled(true):pack{"airblade/vim-gitgutter"},

    -- Syntax highlighting of .xsh and .xonshrc files
    Plugin:new("xonsh-vim"):enabled(true):pack{"linkinpark342/xonsh-vim"},
    
    Plugin:new("which-key"):enabled(true):pack{"folke/which-key.nvim"},
}


function M.load(config)
    local packerTable = {}
    for x, value in ipairs(plugins) do
	if value.isEnabled then
	    table.insert(packerTable, value.packerConfig)
	end
    end

    local installRocks = {
	'mobdebug'
    }
    require("packer").startup(
        {
            packerTable,
            config = packer_config,
	    rocks = installRocks,
        }
    )
    basic()
end

--local M = {}
local map = require("keybindings")

global_settings = {
    mapleader = " ",
    maplocalleader = ",",
    python3_host_prog = "$HOME/.local/venv/nvim/bin/python",
    splitbelow = true,
    splitright = true,
    termguicolors = true,
}

-- options (I believe) are things typically set with set, like "set number=true"
-- make sure you surround options with quotes where necessary and appropriate
options = {
    colorcolumn = {88},
    completeopt = {"menuone", "noinsert"},
    cursorline = true,
    guifont = "SauceCodePro Nerd Font Mono:h20",
    hidden = true,
    -- will this work
    number = true,
    shell = "/bin/zsh",
    mouse = "nv",
    -- the following makes all copy operations work with 
    -- system clipboard
    clipboard = "unnamed",
}

keybindings = {
    {"i", "jk", "<esc>"},
   -- {"i", "<esc>", "<nop>"},
    {"n", "<leader>n", ":set relativenumber!<CR>"},
    {"n", "<leader><leader>", ":source $MYVIMRC"},
}

function basic()
    for k, v in pairs(global_settings) do
        vim.g[k] = v
    end

    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    for k, v in pairs(keybindings) do
        map(v)
    end
    require("plugins.nord")

    cmds = {
        "autocmd FocusLost * :wa",
        "autocmd BufWinEnter * silent! :%foldopen!",
    }
    for k, v in pairs(cmds) do
        vim.cmd(v)
    end
    for k, v in pairs(plugins) do
	--print("Loading......................" .. v.name)
        v:loadConfigFile()    
    end
end


return M
