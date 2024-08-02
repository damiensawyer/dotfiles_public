-- Ensure packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
    end
end

ensure_packer()

-- Autocommand to reload Neovim whenever you save this file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

-- Plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'dracula/vim'

    -- LSP and Autocompletion
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }
    use 'dense-analysis/ale'
    use 'neovim/nvim-lspconfig'  -- LSP configurations
    use 'jose-elias-alvarez/typescript.nvim'  -- TypeScript support

    -- Syntax Highlighting and Code Understanding
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- File Explorer with Icons
    use 'preservim/nerdtree'
    use 'ryanoasis/vim-devicons'

    -- Fuzzy Finder
    use {
        'junegunn/fzf',
        run = './install --all'
    }
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Commenting and Surrounding
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    -- TypeScript and JavaScript
    use 'leafgarland/typescript-vim'
    use 'peitalin/vim-jsx-typescript'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'timonv/vim-cargo'

    -- Utility Plugins
    use 'dyng/ctrlsf.vim'
    use 'dhruvasagar/vim-zoom'
end)

-- General Settings
vim.o.termguicolors = true
vim.cmd 'colorscheme dracula'
vim.g.mapleader = '-'

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeIgnore = {}
vim.g.NERDTreeStatusline = ''
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<CR>', {
    noremap = true,
    silent = true
})

-- FZF
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<CR>', {
    noremap = true,
    silent = true
})
vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-s'] = 'split',
    ['ctrl-v'] = 'vsplit'
}
vim.g.fzf_command_prefix = 'FZF'

-- Rust settings
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0

-- coc.nvim settings
vim.cmd [[
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-rust-analyzer', 'coc-sh', 'coc-tsserver']
  let g:coc_node_path = trim(system('which node'))

  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "\<Tab>" : coc#refresh()

  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <c-space> coc#refresh()
  
  hi CocSearch ctermfg=12 guifg=#18A3FF
  hi CocMenuSel ctermbg=109 guibg=#13354A
]]

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

vim.api.nvim_set_keymap('i', '<TAB>',
    [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "\<TAB>" : coc#refresh()]], {
        expr = true,
        noremap = true
    })
vim.api.nvim_set_keymap('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], {
    expr = true,
    noremap = true
})

-- LSP settings for TypeScript
require('lspconfig').tsserver.setup {
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end,
    flags = {
        debounce_text_changes = 150,
    }
}

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript", "html", "css" }, -- Install these parsers
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

-- Telescope keybindings for better navigation
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- Other settings and keymaps
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {
    noremap = true
})
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', {
    noremap = true
})
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', {
    noremap = true
})
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', {
    noremap = true
})
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', {
    noremap = true
})
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {
    noremap = true
})
