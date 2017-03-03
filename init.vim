""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
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

"""""""
" Linters
"""""""
" async linting and making - replacement for syntastic?
"Plug 'neomake/neomake'
"
" 'async build and test dispatcher'
"Plug 'tpope/vim-dispatch'

" 'dispatch meets syntastic'
Plug 'pgdouyon/vim-accio'
"""""""

" tag highlighting from ctags
"Plug 'c0r73x/neotags.nvim' " disabled because it was causing errors

" latex live preview
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" ranger like replacement for NERDtree
Plug 'airodactyl/neovim-ranger'

" grammar etc. checker?
Plug 'fmoralesc/nlanguagetool.nvim'

"""""""
" Completion engines
"""""""
Plug 'roxma/nvim-completion-manager'
"""""""

Plug 'airblade/vim-gitgutter'

" signify is like gitgutter but supports many VCS
"Plug 'mhinz/vim-signify'

" granular test runner
Plug 'janko-m/vim-test'

"""""""
" Markdown Composer
"""""""
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"""""""

"""""""
" Airline
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
Plug 'google/vim-searchindex'
Plug 'christoomey/vim-tmux-navigator'

" Deal with trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
map <leader>s :StripWhitespace<CR>

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



augroup AutoCommands
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END


"""""""
" Appearance
"""""""
syntax enable

set background=dark
set termguicolors
colorscheme NeoSolarized
set fillchars+=vert:│

let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

set number
set cursorline
"""""""


set showcmd
set undofile " Store undos persistently
set undolevels=1000
set undoreload=10000
set scrolloff=3 " Minimum number of lines to keep above and below cursor


imap <C-c> <Esc>


" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
nnoremap <up> g<up>
nnoremap <down> g<down>


set pastetoggle=<F12>



"""""""
" NASL
"""""""
autocmd BufNewFile,BufRead *.audit set syntax=xml
autocmd BufNewFile,BufRead *.nasl set filetype=nasl
autocmd BufNewFile,BufRead *.inc set filetype=nasl
autocmd BufNewFile,BufRead *.inc set indentexpr=
autocmd FileType nasl setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 colorcolumn=70
autocmd FileType nasl set commentstring=#\ %s

let g:tagbar_type_nasl = {
	\ 'ctagstype' : 'nasl',
	\ 'kinds'     : [
		\ 'f:functions',
		\ 'v:variables',
		\ 'g:globals',
	\ ]
\ }

let g:syntastic_nasl_checkers = ['nasl_parse', 'nasl']

map <leader>rv :call VimuxRunCommand("clear; validate-plugin -s -s " . bufname("%"))<CR>

autocmd FileType nasl map <silent> <leader>ne [(mnV%:s/,\s*\([^$]\)/,\r\1/g'nf(V%:s/(\s*\([^)]\)/(\r\1/'nf(V%:s/\([^(]\)\s*)/\1\r)/'nf(V%='nf(V%:Tabularize /:

function! DisplayVar(var)
	call setline(line('.'), substitute(getline('.'), a:var, "display('".a:var.": ', ".a:var.", '".'\\n'."');", 'g'))
endfunction
autocmd FileType nasl map <silent> <leader>nd y :call DisplayVar('<C-r>"')<CR>

function! DisplayVarPretty(var)
	call setline(line('.'), substitute(getline('.'), a:var, "display('".a:var.": ', pretty(".a:var."), '".'\\n'."');", 'g'))
endfunction
autocmd FileType nasl map <silent> <leader>np y :call DisplayVarPretty('<C-r>"')<CR>

autocmd FileType nasl map <silent> <leader>no odisplay(FUNCTION_NAME, ': ', LINE_NUMBER, '\n');

function! MakeTiny(url)
	let result = system("mktiny " . a:url)
	let result = substitute(result, '[^a-zA-Z0-9:/.?]', '', 'g')
	call setline(line('.'), substitute(getline('.'), a:url, result, 'g'))
endfunction
vmap mt y :call MakeTiny('<C-r>"')<CR>
"""""""
