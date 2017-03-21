"==============================================================================
" neovim configuration
" 2016-06-30

"==============================================================================
" Plugins
" Plugin Manager: vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugins')

Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/vim-auto-save'
" Plug 'vim-scripts/indentLine.vim'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-lang/vim-elixir'
Plug 'neomake/neomake'
" Plug 'Shougo/deoplete.nvim'
" Plug 'mhartington/nvim-typescript'
" Use vim-flow because neomake-flow does not work (2016-07-05)
Plug 'facebook/vim-flow', {
     \ 'autoload': {
     \     'filetypes': 'javascript'
     \ }}

call plug#end()

"===============================================================================
" Colourscheme
" More colorscheme: http://vimcolors.com
" colorscheme kalisi
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set background=dark
" let g:gruvbox_contrast_dark='hard'

"==============================================================================
" Common editor configurations

" clipboard
set clipboard+=unnamedplus

" Show line numbers
set number

" tabs
set tabstop=2
set shiftwidth=2
set expandtab " expand tab to blanks

" mark column 81
set colorcolumn=81

" insert a single character
:nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
:nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

" updatetime (in ms) will be used for the CursorHold autocommand event.
set updatetime=1000

" show whitespace
set list
set listchars=space:·,tab:>>

" Highlight the current line and column
set cursorline
set cursorcolumn

" Delete trailing whitespaces
function DeleteTrailingWhitespaces()
  if &modifiable == 1 && !isdirectory(@%) 
    let l:winview = winsaveview()
    %s/\s*$//
    write
    call winrestview(l:winview)
    redraw
  endif
:endfunction
autocmd BufRead,InsertLeave *.js call DeleteTrailingWhitespaces()

" Swapt iTerm2 cursor in vim insert mode when using tmux.
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Change contrast on enter and leave insert mode
function ChangeContrast(contrast)
  let g:gruvbox_contrast_dark=a:contrast
  colorscheme gruvbox
:endfunction
" autocmd InsertEnter * call ChangeContrast("hard")
" autocmd InsertLeave * call ChangeContrast("soft")

"==============================================================================
" auto save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 1  " save while in insert mode
let g:auto_save_no_updatetime = 1  " change the 'updatetime' option
let g:auto_save_silent = 1  " do not display the auto-save notification

"==============================================================================
" Filetypes
" Add filetype es6
autocmd BufNewFile,BufRead *.es6 set filetype=javascript

"==============================================================================
" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_skip_empty_sections = 1
let g:airline_section_c = '%f'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%c/%l'

"===============================================================================
" neomake configuration
" Check javascripts with eslint
let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
" Check javascripts on enter and write buffer
" autocmd BufWritePost,BufEnter *.js,*.es6 Neomake
autocmd BufWritePost,BufReadPost,InsertLeave *.js,*.es6 silent Neomake
" let g:neomake_open_list = 2
" let g:neomake_verbose = 3

"===============================================================================
" Flow cofiguration
" Typechecking is done automatically on :w if set to 1
let g:flow#enable = 0

"===============================================================================
" gitgutter
let g:gitgutter_sign_column_always = 1

"===============================================================================
let g:deoplete#enable_at_startup = 1
