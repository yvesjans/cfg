"===[UI config ]================================================================
set background=dark
set nocompatible
set number
set pastetoggle=<F2>
set wildmenu
set wrap
"colo slate

"===[ Tab handling ]============================================================
set expandtab
set smarttab
set softtabstop=2
set tabstop=2

"===[ Identation ]==============================================================
set autoindent
set smartindent
set shiftwidth=2
filetype on
au BufNewFile,BufRead *.pp set filetype=ruby

"===[ syntax highlighting ]=====================================================
syntax on

"===[ better tmux integration ]=================================================
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"===[ Make tabs, trailing whitespace, and non-breaking spaces visible ]=========
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

"===[ search highlighting ]=====================================================
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=white
nnoremap <leader><space> :nohlsearch<CR>

"===[ pathogen ]================================================================
execute pathogen#infect()

"===[ syntastic ]================================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

"===[ airline ]==================================================================
set laststatus=2
set t_Co=256
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

"===[ NERDTree ]=================================================================
map <C-n> :NERDTreeToggle<CR>
