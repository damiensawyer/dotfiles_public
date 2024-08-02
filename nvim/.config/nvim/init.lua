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

    -- File Explorer with Icons
    use 'preservim/nerdtree'
    use 'ryanoasis/vim-devicons'

    -- Fuzzy Finder
    use {
        'junegunn/fzf',
        run = './install --all'
    }
    use 'junegunn/fzf.vim'

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
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-rust-analyzer', 'coc-sh']
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

