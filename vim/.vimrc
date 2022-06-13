" Yank mapping
map <C-c> "+y
nmap <leader>yq :w! /tmp/last_scratchpad.txt<CR>gg0vG$"+y:q!<CR>

" Show Full Filepath Vim
" map  <F7> <Esc>:echo expand('%:p')<Return>

" Enable command to toggle visual mode (WIP)
"command! Vb normal! <C-v>

" Silicon
" let g:silicon = {
" \   'theme'               : 'Sublime Snazzy',
" \   'font'                : '{{fonts.main}}',
" \   'output'              : '/home/dan/Pictures/silicon-{time:%Y-%m-%d-%H%M%S}.png',
" \   'background'          : '{{colors.main_highlight}}',
" \   'shadow-color'        : '#111111',
" \   'line-pad'            : 5,
" \   'pad-horiz'           : 1000,
" \   'pad-vert'            : 1000,
" \   'shadow-blur-radius'  : 15,
" \   'shadow-offset-x'     : 0,
" \   'shadow-offset-y'     : 0,
" \   'line-number'         : v:true,
" \   'round-corner'        : v:true,
" \   'window-controls'     : v:false,
" \ }

" Vdebug
" let g:vdebug_options = {
" \   "port"                : "9000",
" \   "timeout"             : 20,
" \   "on_close"            : "detach",
" \   "break_on_open"       : 0,
" \   "ide_key"             : "vdebug",
" \   "debug_window_level"  : 0,
" \   "debug_file_level"    : 2,
" \   "path_maps"           : { "/app/public/": "/home/dan/Local Sites/surgicorps/app/public/" },
" \   "debug_file"          : "/home/dan/.config/xdebug/xdebug.log",
" \   "watch_window_style"  : "compact",
" \   "layout"              : "horizontal",
" \   "marker_default"      : "⬦",
" \   "marker_closed_tree"  : "▸",
" \   "marker_open_tree"    : "▾"
" }

" # Tab navigation
" ## AIRLINE TABS
" ### Go to tab by number
noremap <leader>1 :b1<cr>
noremap <leader>2 :b2<cr>
noremap <leader>3 :b3<cr>
noremap <leader>4 :b4<cr>
noremap <leader>5 :b5<cr>
noremap <leader>6 :b6<cr>
noremap <leader>7 :b7<cr>
noremap <leader>8 :b8<cr>
noremap <leader>9 :b9<cr>
noremap <leader>0 :blast<cr>

" Use Ctrl+h (left) and Ctrl+l (right)
" to navigate tabs in vim
"nnoremap <C-left> :bp<CR>
"nnoremap <C-right> :bn<CR>

" Use double-tap "h" (left) or double-tap "l" (right)
" to navigate tabs in vim
nnoremap gt :bp<cr>
nnoremap gT :bn<cr>

" " Go to tab by number
"noremap <leader>1 1gt
"noremap <leader>2 2gt
"noremap <leader>3 3gt
"noremap <leader>4 4gt
"noremap <leader>5 5gt
"noremap <leader>6 6gt
"noremap <leader>7 7gt
"noremap <leader>8 8gt
"noremap <leader>9 9gt
"noremap <leader>0 :tablast<cr>

" Use Ctrl+h (left) and Ctrl+l (right)
" to navigate tabs in vim
"nnoremap <C-left> :tabprevious<CR>
"nnoremap <C-right> :tabnext<CR>

" default updatetime 4000ms is not good for async update
set updatetime=300

" Check keypress within 200ms of opening vim
" function! GetKeyUnder200ms()
"  let l:start = reltimefloat(reltime())
"  let l:char = getchar()

"  if reltimefloat(reltime()) - l:start < 0.200
"    echo l:char
"  else
"    echo "Too slow!"
"  endif
" endfunction

" Toggle Context-Awareness
let g:context_enabled = 0
noremap <silent> <Leader>c :ContextToggle<CR>

" Toggle line-wrap on or off
noremap <silent> <Leader>tw :call ToggleWrap()<CR>

function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    silent! nmap <buffer> <k>
    silent! nmap <buffer> <j>
    silent! nmap <buffer> <h>
    silent! nmap <buffer> <l>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    noremap  <buffer> <silent> k gk
    noremap  <buffer> <silent> j gj
  endif
endfunction

fun! Retab() range
  '<,'>s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g
  norm!gv
endfun
noremap <silent> <Leader>re :'<,'>call Retab()<CR>

" PHP Assoc Array quick column tabularization
noremap <silent> <Leader>fa :Tabularize /=>/<CR>
" Open file browser sidebar
map <silent> <leader>n :CocCommand explorer<CR>

" Colorschemes
" ========================================
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
let g:beacon_size=&columns
hi Beacon guibg=white ctermbg=0


" Fix Colors
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" For 'one' colorscheme
" ---------------------
" set background=light
" colorscheme one
" let g:one_allow_italics = 1
" set t_8b=^[[48;2;%lu;%lu;%lum
" set t_8f=^[[38;2;%lu;%lu;%lum
" ---------------------
" colo desertedocean
" colo Atelier_SulphurpoolDark
" colo corvine
" colo vwilight
" colo anderson
" colo xcode
" colo skittles_autumn
" colo angr

if !empty($VIM_COLOR)
  colo $VIM_COLOR

  if $VIM_COLOR == "Tomorrow"
    let g:airline_theme='base16_snazzy'
  endif

  if $VIM_COLOR == "gruvbox"
    let g:airline_theme='distinguished'
  endif

  if $VIM_COLOR == "duotone-dark"
    let g:airline_theme='lucius'
  endif

  if $VIM_COLOR == "synthwave"
    let g:airline_theme='zenburn'
  endif

  if $VIM_COLOR == "monokai-phoenix"
    let g:airline_theme='molokai'
  endif

  if $VIM_COLOR == "wwdc16"
    let g:airline_theme='base16color'
  endif

  if $VIM_COLOR == "molokai"
    let g:airline_theme='molokai'
  endif

  if $VIM_COLOR == "Atelier_DuneDark"
    let g:airline_theme='hybrid'
  endif

  if $VIM_COLOR == "afterglow" || $VIM_COLOR == "material"
    let g:airline_theme='base16_horizon_terminal_dark'
  endif

else

  colo "wwdc16"
  let g:airline_theme = 'base16color'

endif

" Use Terminal background color (transparent BG)
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
" Transparent popups in neovim
" (lower is more opaque)
set pumblend=5
set winblend=5

" Highlight current row in NORMAL mode,
" hide highlight in INSERT mode
autocmd InsertEnter,InsertLeave * set cul!

" Vertical Scrolling
set scrolloff=15
" Horizontal Scrolling
set sidescroll=1
set sidescrolloff=15
noremap <C-ScrollWheelDown> 10zl
noremap <C-2-ScrollWheelDown> 10zl
noremap <C-3-ScrollWheelDown> 10zl
noremap <C-4-ScrollWheelDown> 10zl
noremap <C-ScrollWheelUp> 10zh
noremap <C-2-ScrollWheelUp> 10zh
noremap <C-3-ScrollWheelUp> 10zh
noremap <C-4-ScrollWheelUp> 10zh

" Filetype-aware Indent
filetype plugin indent on

" Syntax highlighting
set nocompatible
syntax on
syntax enable
" Highlight matching tags in white
hi MatchParen ctermbg=NONE guibg=NONE ctermfg=white guifg=white cterm=italic gui=italic
" Italics
highlight Comment cterm=italic gui=italic
" Extra HTML syntax highlighting
highlight htmlArg cterm=italic
highlight htmlBold cterm=bold gui=bold
highlight htmlItalic cterm=italic gui=italic
highlight htmlBoldItalic cterm=bold,italic gui=bold,italic

" Mouse features on
set mouse+=a
if &term =~ '^screen'
  set ttymouse=xterm2
endif

" Tabs, numbers, spelling
set virtualedit=onemore
set clipboard=unnamedplus
set encoding=utf8
set spelllang=en
set spell
set shortmess+=c
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set number
set noswapfile
set wrap
set incsearch
set smartcase
set ignorecase
set ls=2

" Set indentation
set sts=2 ts=2 sw=2 et
set smartindent
set smarttab
" Python set 4
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
" JS Tab instead of spaces
autocmd FileType javascript setlocal smartindent noexpandtab shiftwidth=2 tabstop=2

" Show title
set title
set noshowmode

".vimrc
map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <leader>b :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>b :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <leader>b :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>b :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>b :call CSSBeautify()<cr>

" Indent wrapped lines
set breakindentopt=shift:0,min:40,sbr
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,README.md  setf markdown
au FileType markdown setl breakindent
au FileType markdown setl textwidth=0
au FileType markdown setl wrap
au FileType markdown setl linebreak  " wrap line at word boundaries
au FileType php setl breakindent
au FileType html setl breakindent
au FileType json setl breakindent
au FileType js setl breakindent
au User Startified setl breakindent

" Don't break on words
set formatoptions=l
set lbr

" Vim folding settings
set foldmethod=indent

" Vim FZF
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Let fzf use vim colorscheme
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }

" SpellCheck FZF
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>

" Vimwiki Settings
let g:vimwiki_list = [{'path': '/var/www/l-o-o-s-e-d/html/knowledge-base/markdown/',
\ 'syntax': 'markdown',
\ 'template_path': '/var/www/l-o-o-s-e-d/html/knowledge-base/loosed-template/',
\ 'template_default': 'default',
\ 'ext': '.md',
\ 'path_html': '/var/www/l-o-o-s-e-d/html/knowledge-base/',
\ 'custom_wiki2html': 'vimwiki_markdown',
\ 'template_ext': '.tpl'}]

" Tmuxline and Airline Settings
set ttimeoutlen=50
let g:tmuxline_powerline_separators=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#default#section_use_groupitems=0
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#coc#enabled=1
let g:airline#extensions#coc#error_symbol=''
let g:airline#extensions#coc#warning_symbol=''
let g:airline_section_c = '%<%F%m %{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
hi airline_c ctermbg=NONE guibg=NONE
hi airline_tabfill ctermbg=NONE guibg=NONE

" Indentline Settings
autocmd VimEnter,WinEnter,BufNewFile,BufRead,BufEnter,TabEnter * IndentLinesReset
"set list
"set listchars=tab:\│\ ,trail:\ 
let g:indentLine_setColors=1
let g:indentLine_enabled=1
let g:indentLine_concealcursor=""
let g:indentLine_char_list=['│', '-']
let g:indentLine_conceallevel=2

" Markdown - Table of Contents
let g:vmt_auto_update_on_save=1
let g:vmt_fence_text='TOC'
let g:vmt_fence_closing_text='/TOC'
let g:vmt_cycle_list_item_markers=1

" Sexy Split
set fillchars+=vert:█

" Minimap Settings
" let g:minimap_left = 1
" noremap <silent> <Leader>mm :Minimap<CR>
" noremap <silent> <Leader>mc :MinimapClose<CR>

" PHPDOC
let g:pdv_template_dir = $HOME . "/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" ToDo List
let g:VimTodoListsDatesEnabled = 1
let g:VimTodoListsDatesFormat = "%A, %B %-d"

" ALE
" -----------------------
" Read required prerequisites on linter project pages
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'jsx': ['eslint'],
\ 'python': ['flake8', 'pylint', 'black']
\}
let g:ale_fixers = {
\ 'javascript': ['eslint', 'prettier'],
\ 'jsx': ['eslint'],
\ 'python': ['autopep8', 'yapf']
\}
" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 0
let g:ale_python_flake8_options = '--config=$HOME/.config/flake8'
let g:ale_python_pylint_options = '--load-plugins pylint_django --generated-members=objects --rcfile ~/.pylintrc'
let g:ale_python_pylint = '~/.local/bin/pylint'
let g:ale_disable_lsp = 1
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_float_preview = 1
highlight ALEErrorSign guifg=red guibg=NONE
highlight ALEWarningSign guifg=yellow guibg=NONE
" ---------------------------------------
nmap <silent> <C-)> <Plug>(ale_previous_wrap)
nmap <silent> <C-(> <Plug>(ale_next_wrap)
" ---------------------------------------
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END


" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"highlight SyntasticErrorSign guifg=red guibg=NONE
"highlight SyntasticWarningSign guifg=yellow guibg=NONE
"highlight SyntasticStyleErrorSign guifg=red guibg=NONE
"highlight SyntasticStyleWarningSign guifg=yellow guibg=NONE
"let g:syntastic_error_symbol = ''
"let g:syntastic_warning_symbol = ''
"let g:syntastic_style_error_symbol = ''
"let g:syntastic_style_warning_symbol = ''
"let g:syntastic_quiet_messages = { 'regex' : 'order-alphabetical\|bulletproof-font-face\|important\|ids\|qualified-headings' }
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_loc_list_height = 4
"let g:syntastic_auto_loc_list=1
"let g:syntastic_check_on_open=1
"let g:syntastic_check_on_wq=1
"let g:syntastic_javascript_checkers=['eslint']
" Global ESLint setup:
" ---------------------------------------
" Put .eslintrc into root directory of project folder, i.e.: /var/www
"{
"  "extends": "airbnb",
"    "rules": {
"      "semi": ["error", "never"],
"      "comma-dangle": ["error", "never"]
"    }
"}

" Vimspector
" let g:vimspector_enable_mappings='HUMAN'

" CTags
" set tags=tags

" vim-signify
" =========================================================
highlight clear SignColumn
set signcolumn=yes
let g:signify_line_highlight         = 0
let g:signify_sign_show_count        = 1
let g:signify_sign_add               = ''
let g:signify_sign_delete            = ''
let g:signify_sign_delete_first_line = '=='
let g:signify_sign_change            = '⚫'
" ---------------------------------------------------------
nmap <C-Down> <plug>(signify-next-hunk)
nmap <C-Up> <plug>(signify-prev-hunk)
" ---------------------------------------------------------
highlight SignifySignAdd             ctermfg=048 ctermbg=none guifg=#1FED86 guibg=none
highlight SignifySignChange          ctermfg=147 ctermbg=none guifg=#8239F3 guibg=none
highlight SignifySignDelete          ctermfg=202 ctermbg=none guifg=#FF1E23 guibg=none
highlight SignifySignDeleteFirstLine ctermfg=red ctermbg=none guifg=red     guibg=none
" Waiting for Coc-git PR for proper highlighting
" ---------------------------------------------------------
highlight DiffAdd                    ctermfg=048 ctermbg=none guifg=#1FED86 guibg=none
highlight DiffChange                 ctermfg=147 ctermbg=none guifg=#8239F3 guibg=none
highlight DiffDelete                 ctermfg=202 ctermbg=none guifg=#FF1E23 guibg=none
highlight DiffDelete                 ctermfg=red ctermbg=none guifg=red     guibg=none

" Floatterm
let g:floaterm_borderchars=["═", "║", "═", "║", "╔", "╗", "╝", "╚"]
let g:floaterm_borderchars=["─", "│", "─", "│", "╭", "╮", "╯", "╰"]
hi FloatermBorder guibg=NONE guifg=#8239F3
nnoremap <silent> <C-f> :FloatermNew --autoclose=2<CR>

" Remove all trailing whitespace by pressing F1
nnoremap <F1> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Replace grep with ripgrep in vim
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Startify, show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ { 'type': function('s:gitModified'),  'header': ['   git modified']},
\ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]

let g:python3_host_prog = '/home/dan/miniconda3/bin/python3'

" Sort CSS and SCSS
:command! SortCSS :g#\({\n\)\@<=#.,/}/sort
:command! SortSCSS :g#\({\n\)\@<=#.,/\.*[{}]\@=/-1 sort
:command! SortVue :/<style>/,/<\/style>/:g#\({\n\)\@<=#.,/}/sort

" Vim & Jupyter
let g:jupytext_enable = 1
let g:jupytext_fmt="py"
"autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
"autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
"autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
au BufReadPost,BufNewFile,BufEnter *.ipynb :!exec tmux split-window "jupyter-console"

" CSS Syntax Highlighting fix:
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" PHP Syntax Highlighting
function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
  syn match phpParentOnly "[()]" contained containedin=phpParent
  hi phpParentOnly guifg=#f08080 guibg=NONE gui=NONE
  hi phpUseNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
  hi phpClassNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" Python docstring generator
let g:pydocstring_doq_path='/home/dan/.local/bin/doq'

" JS/JSX/TS Syntax Highlighting
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" HTML boilerplate
autocmd BufNewFile *.html 0r ~/.vim/skeletons/page.html
" JSON highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" djangohtml
au BufNewFile,BufRead *.html set filetype=htmldjango

" Begin CoC =============================================================
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

" Check back space
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Coc Pmenu
hi CocErrorSign ctermfg=red  ctermbg=NONE guifg=#FF0000 guibg=#000000
hi CocInfoSign ctermfg=yellow ctermbg=NONE guifg=#FFFF00 guibg=#000000
hi Pmenu ctermbg=NONE guibg=NONE
let g:coc_node_path='/home/dan/.nvm/versions/node/v16.15.0/bin/node'

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <M-]> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-]>"
nnoremap <silent><nowait><expr> <M-[> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-[>"
inoremap <silent><nowait><expr> <M-]> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <M-[> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <M-]> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-]>"
vnoremap <silent><nowait><expr> <M-[> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-[>"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Autoclose linter buffer when closing file with existing errors
autocmd QuitPre * if empty(&bt) | lclose | endif

" Disable tab for ultisnips
let g:UltiSnipsExpandTrigger = "<nop>"

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" End CoC ===============================================================

" l00sed ToC
" ---------------------------
let g:vct_auto_update_on_save=0

" Gutentags
" ---------------------------
let g:gutentags_file_list_command = 'rg --files'

call plug#begin('~/.vim/plugged')
" Plug 'vim-scripts/AutoComplPop'
" Plug 'rakr/vim-one'
" Plug 'vim-vdebug/vdebug'
" Plug 'psliwka/vim-smoothie'
" Plug 'segeljakt/vim-silicon'
" Plug 'preservim/nerdcommenter'
" Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'
" --------------------------
" Replaced by polyglot
" --------------------------
  " Plug 'chrisbra/csv.vim'
  " Plug 'othree/html5.vim'
  " Plug 'elzr/vim-json'
  " Plug 'kevinoid/vim-jsonc'
  " Plug 'tomlion/vim-solidity'
  " Plug 'StanAngeloff/php.vim'
  " Plug 'cakebaker/scss-syntax.vim'
" ----------------------------------
" Waiting for approval:
" Plug 'github/copilot.vim'
" Need to use CoCInstall to install LSP, i.e.: CocInstall coc-python
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
  \ '@yaegassy/coc-intelephense',
  \ 'coc-css',
  \ 'coc-deno',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-java-debug',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-phpls',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'java-decompiler',
  \ ]
  Plug 'yaegassy/coc-intelephense', {'do': 'yarn install --frozen-lockfile'}
  Plug 'vimwiki/vimwiki'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf',{'do':{->fzf#install()}}
  Plug 'Yggdroot/indentLine'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'inkarkat/vim-SpellCheck'
  Plug 'inkarkat/vim-ingo-library'
  Plug 'ryanoasis/vim-devicons'
  Plug 'SirVer/ultisnips'
  Plug 'etdev/vim-hexcolor'
  Plug 'chrisbra/Colorizer'
  Plug 'mzlogin/vim-markdown-toc'
  " If you have nodejs and yarn
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'l00sed/vim-css-toc'
  Plug 'honza/vim-snippets'
  Plug 'tobyS/vmustache'
  Plug 'tobyS/pdv'
  Plug 'goerz/jupytext.vim'
  Plug 'jupyter-vim/jupyter-vim'
  Plug 'aserebryakov/vim-todo-lists'
  Plug 'mhinz/vim-startify'
  Plug 'voldikss/vim-floaterm'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'andymass/vim-matchup'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-surround'
  Plug 'maksimr/vim-jsbeautify'
  Plug 'lambdalisue/suda.vim'
  Plug 'dense-analysis/ale'
  Plug 'psf/black', { 'branch': 'stable' }
  Plug 'sheerun/vim-polyglot'
  Plug 'wellle/context.vim'
  Plug 'othree/yajs.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'jparise/vim-graphql'
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'shawncplus/phpcomplete.vim'
  Plug 'captbaritone/better-indent-support-for-php-with-html'
  Plug 'tyru/open-browser.vim'
  Plug 'godlygeek/tabular'
  Plug 'tweekmonster/django-plus.vim'
  Plug 'dgileadi/vscode-java-decompiler'
  Plug 'sophacles/vim-processing'
  Plug 'rust-lang/rust.vim'
  Plug 'joukevandermaas/vim-ember-hbs'
  " Send characters to another Tmux pane from Vim
  Plug 'brauner/vimtux'
  " Cursor beam for accessibility
  Plug 'danilamihailov/beacon.nvim'
  if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
  else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
  endif
call plug#end()
