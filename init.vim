""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" clang based syntax highlighting
"Plug 'arakashic/chromatica'

" search and replace in multiple files
"Plug 'brooth/far.vim'

" collaborative editing
"Plug 'Floobits/floobits-neovim'

" async ctags/gtags support
"Plug 'jsfaint/gen_tags.vim'

"###### Linters ######
" async linting and making - replacement for syntastic?
"Plug 'neomake/neomake'
"
" 'async build and test dispatcher'
"Plug 'tpope/vim-dispatch'

" 'dispatch meets syntastic'
Plug 'pgdouyon/vim-accio'
"#####################

" tag highlighting from ctags
Plug 'c0r73x/neotags.nvim'

" latex live preview
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" ranger like replacement for NERDtree
Plug 'airodactyl/neovim-ranger'

" grammar etc. checker?
Plug 'fmoralesc/nlanguagetool.nvim'

"###### Completion engines ######
Plug 'roxma/nvim-completion-manager'
"################################

Plug 'airblade/vim-gitgutter'

" signify is like gitgutter but supports many VCS
"Plug 'mhinz/vim-signify'

" granular test runner
Plug 'janko-m/vim-test'

"""""""
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"""""""

"""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"""""""

Plug 'iCyMind/NeoSolarized'
Plug 'tenable/vim-nasl'
Plug 'AndrewRadev/linediff.vim'
Plug 'BenBergman/vsearch.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'

" Deal with trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
map <leader>s :StripWhitespace<CR>

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



augroup AutoCommands
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

syntax enable
set showcmd

set background=dark
set termguicolors
colorscheme NeoSolarized

let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'


imap <C-c> <Esc>

" Move around buffers more easily
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
