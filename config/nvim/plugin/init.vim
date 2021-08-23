"==============================================================================
set encoding=utf-8
" set spell

" ==============================================================================
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

" ==============================================================================
" Hybrid line numbers - toggle
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" ==============================================================================
" Fuzzy Open
nmap <unique> <C-p> <Plug>(PickerEdit)
nmap <unique> <C-o> <Plug>(PickerBuffer)

" ==============================================================================
" Auto Save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0  " save while in insert mode
let g:auto_save_no_updatetime = 1  " change the 'updatetime' option
let g:auto_save_silent = 1  " do not display the auto-save notification

" ==============================================================================
" Whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" ==============================================================================
" Elixir format
nnoremap <silent> f :!mix format %<CR>

" ==============================================================================
autocmd FileType elixir setlocal commentstring=#\ %s
