" TODO: http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/225852#225852

" vim: set foldmarker={,} foldlevel=0 spell:

" General {
set nocompatible " disable vi compatibility.
filetype off
if has('win32') || has('win64')
	let $VIMFILES = $VIM.'/vimfiles'
	let $VIMTEMP = $VIMFILES.'/tmp'
	let $V = $VIM.'/.vimrc'
	let $DROPBOX = "E:/Dropbox"
	" Add vundle to the runtime path
	set rtp+=$VIMFILES/bundle/vundle/
	" Call Vundle
	call vundle#rc('$VIMFILES/bundle/')
else
	let $VIMFILES = $HOME.'/.vim'
	let $VIMTEMP = $VIMFILES.'/tmp'
	let $V = $HOME.'/.vimrc'
	let $DROPBOX = "~/Dropbox"
	" Add vundle to the runtime path
	set rtp+=$VIMFILES/bundle/vundle/
	" Call Vundle
	call vundle#rc()
endif
filetype plugin indent on " Automatically detect file types.
set noexrc " don't use local version of .(g)vimrc, .exrc
set history=500 " Number of things to remember in history.
set autowrite " Writes on make/shell commands
set autoread
set timeoutlen=250 " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed " Yanks go on clipboard instead.
set pastetoggle=<F8> " toggle between paste and normal: for 'safer' pasting from keyboard
set tags=./tags;$HOME " walk directory tree upto $HOME looking for tags
" Modeline
set modeline
set modelines=5 " default numbers of lines to read for modeline instructions
" Backup
set nowritebackup
set nobackup
set directory=$VIMTEMP// " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" Buffers
set nohidden " The current buffer can be put to the background without writing to disk
" Match and search
set hlsearch " highlight search
set ignorecase " Do case in sensitive matching with
set smartcase " be sensitive when there's a capital letter
set incsearch "
set magic " Set magic on, for regular expressions
set nowrapscan  "禁止在搜索到文件两端时重新搜索
set infercase " case inferred by default
set cpoptions=aABceFsmq
"             |||||||||
"             ||||||||+-- When joining lines, leave the cursor
"             |||||||      between joined lines
"             |||||||+-- When a new match is created (showmatch)
"             ||||||      pause for .5
"             ||||||+-- Set buffer options when entering the
"             |||||      buffer
"             |||||+-- :write command updates current file name
"             ||||+-- Automatically add <CR> to the last line
"             |||      when using :@r
"             |||+-- Searching continues at the end of the match
"             ||      at the cursor position
"             ||+-- A backslash has no special meaning in mappings
"             |+-- :write updates alternative file name
"             +-- :read updates alternative file name
set autochdir " always switch to the current file directory
let mapleader = ","
let g:mapleader = ","
" Multi-encoding setting {
if has("multi_byte")
	"set bomb
	" 打开文件编码猜测
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,iso-8859-1,big5,euc-jp,euc-kr,latin1
	" CJK environment detection and corresponding setting
	if v:lang =~ "^zh_CN"
		" Use cp936 to support GBK, euc-cn == gb2312
		set encoding=cp936
		set termencoding=cp936
		set fileencoding=cp936
	elseif v:lang =~ "^zh_TW"
		" cp950, big5 or euc-tw
		set encoding=big5
		set termencoding=big5
		set fileencoding=big5
	elseif v:lang =~ "^ko"
		" Copied from someone's dotfile, untested
		set encoding=euc-kr
		set termencoding=euc-kr
		set fileencoding=euc-kr
	elseif v:lang =~ "^ja_JP"
		" Copied from someone's dotfile, untested
		set encoding=euc-jp
		set termencoding=euc-jp
		set fileencoding=euc-jp
	endif
	" Detect UTF-8 locale, and replace CJK setting if needed
	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
		set encoding=utf-8
		set termencoding=utf-8
		" 文件保存编码
		set fileencoding=utf-8
	endif

	if v:version > 601
		if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
			set ambiwidth=double
		endif
	endif
else
	echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif
" }
" }

" Formatting {
set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0 " Don't wrap lines by default

set wildmenu " turn on command line completion wild style
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
set wildmode=longest,list " At command line, complete longest common string, then list alternatives.

set backspace=indent,eol,start " more powerful backspacing

set tabstop=4 " Set the default tabstop
set softtabstop=4
set shiftwidth=4 " Set the default shift width for indents
set noexpandtab " Make tabs into spaces (set by tabstop)
set smarttab " Smarter tab levels


set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

syntax on " enable syntax
set fileformats=unix,dos,mac " support all three, in this order
set iskeyword+=_,$,@,%,# " none of these are word dividers

set noerrorbells " don't make noise
set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
"             | | | | | | | | |
"             | | | | | | | | +-- "]" Insert and Replace
"             | | | | | | | +-- "[" Insert and Replace
"             | | | | | | +-- "~" Normal
"             | | | | | +-- <Right> Normal and Visual
"             | | | | +-- <Left> Normal and Visual
"             | | | +-- "l" Normal and Visual (not recommended)
"             | | +-- "h" Normal and Visual (not recommended)
"             | +-- <Space> Normal and Visual
"             +-- <BS> Normal and Visual
" no end \n
"set noendofline
"set binary
let b:match_ignorecase = 1 " case is stupid
let perl_extended_vars=1 " highlight advanced perl vars inside string


" }

" Visual {
set nonumber " Line numbers off
set showmatch " Show matching brackets.
set matchtime=5 " Bracket blinking.
set novisualbell " No blinking
set noerrorbells " No noise.
set laststatus=2 " Always show status line.
set t_vb= " disable any beeps or flashes on error
set ruler " Show ruler
set showcmd " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI " Shortens messages

set lazyredraw " do not redraw while running macros
set linespace=0 " don't insert any extra pixel lines betweens rows
set nolist " Display unprintable characters f12 - switches
set nostartofline " leave my cursor where it was
if ! (has('win32') || has('win64'))
	set listchars=tab:·\ ,eol:¶,trail:·,extends:»,precedes:« " Unprintable chars mapping
else
	set listchars=tab:>-,trail:_ " show tabs and trailing
endif

" Folding {
set foldenable " Turn on folding
set foldmarker={,} " Fold C style code (only use this as default
" if you use a high foldlevel)
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still
" fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
function SimpleFoldText()
	return getline(v:foldstart).' '
endfunction
set foldtext=SimpleFoldText() " Custom fold text function
" }

set mouse=a " Disable mouse
set mousehide " Hide mouse after chars typed

set splitbelow
set splitright
set keywordprg=man\ -a " Set manpages

set numberwidth=5 " We are good up to 99999 lines
set report=0 " tell us when anything is changed via :...

set sidescrolloff=10 " Keep 5 lines at the size
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]%{HasPaste()}
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer
"set statusline=[%F]%y%r%m%*%=[Format=%{&ff}][Line:%l/%L,Column:%c][%p%%]

"for vim73
if v:version >= 703
	" hi colorcolumn guibg=lightgreen
	" set colorcolumn=81
endif
colorscheme ron
" }

" Plugins {
Bundle 'gmarik/vundle'
Bundle 'YankRing.vim'
Bundle 'Mark--Karkat'
"Bundle 'ShowMarks7'
Bundle 'FencView.vim'
Bundle 'nelstrom/vim-mac-classic-theme.git'

" Programming
Bundle 'DoxygenToolkit.vim'
Bundle 'OmniCppComplete'

" Snippets
Bundle 'drmingdrmer/xptemplate'

" Syntax highlight
" Bundle 'tpope/vim-cucumber'
Bundle 'hallison/vim-markdown'

" Git integration
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'

" (HT|X)ml tool
Bundle 'tpope/vim-ragtag'

" Utility
Bundle 'DrawIt'
Bundle 'calendar.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'bogado/file-line'
Bundle 'scrooloose/nerdtree'
Bundle 'Align'
Bundle 'vimwiki'
Bundle 'bufexplorer.zip'

" FuzzyFinder
Bundle 'L9'
Bundle 'FuzzyFinder'

" tComment
" Bundle 'tComment'
" nnoremap // :TComment<CR>
" vnoremap // :TComment<CR>

Bundle 'The-NERD-Commenter'


" }

" Plugin Settings {
" TagBar {
let g:tagbar_autofocus = 1
let g:tagbar_left = 1
let g:tagbar_sort = 'sort'
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
" }
" SuperTab Settings {
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" }
" VimWiki Settings {
"     是否在词条文件保存时就输出html  这个会让保存大词条比较慢
"所以我默认没有启用  有需要的话就把这一行复制到下面去
"     \ 'auto_export': 1,
" 多个维基项目的配置
let wiki1 = {}
let wiki1.path = $DROPBOX.'/Note/vimwiki/'
let wiki1.path_html = $DROPBOX.'/Note/vimwiki/html/'
let wiki1.html_header = $DROPBOX.'/Note/vimwiki/template/header.htm'
let wiki1.html_footer = $DROPBOX.'/Note/vimwiki/template/footer.htm'
let wiki1.diary_link_count = 5
let wiki1.nested_syntaxes = {'c': 'c', 'c++': 'cpp'}

let wiki2 = {}
let wiki2.path = $HOME.'/Desktop/worknote/'
let wiki2.diary_link_count = 7

let g:vimwiki_list = [wiki1,wiki2]

" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_menu = ''
" 是否开启按语法折叠  会让文件比较慢
"let g:vimwiki_folding = 1
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 指定允许写在 wiki 中的HTML标签
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
let g:vimwiki_use_mouse = 1
" ctags for vimwiki, play with ~/.ctags
let tlist_vimwiki_settings = 'wiki;h:Headers'
" }
" DoxyGen Settings {
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="rongjiang"
let g:DoxygenToolkit_licenseTag="My own license, change this in .vimrc"
" }
" persistent undo Settings {
if v:version >= 703
	set undofile
	set undodir=$VIMTEMP
	set undolevels=1000 "maximum number of changes that can be undone
	set undoreload=10000 "maximum number lines to save for undo on a buffer
endif
" }
" Jervis Settings {
"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" }
" Nerd_tree Settings {
let g:NERDTreeWinPos = "right"
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
" }
" Yankring {
let g:yankring_history_dir = $VIMTEMP
" }
" XPtemplate {
let g:xptemplate_brace_complete = 0
" }
" Mark {
nmap <Leader>M <Plug>MarkToggle
nmap <Leader>N <Plug>MarkAllClear

nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
" }
" ShowMarks {
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Don't leave on by default, use :ShowMarksOn to enable
let g:showmarks_enable = 0
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
" }
" OmniComplete {
" Popup menu hightLight Group
hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSel guibg=#555555 guifg=#ffffff
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" and make sure that it doesn't break supertab
let g:SuperTabCrMapping = 0

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }
" Fuzzy Finder {
""" Fuzzy Find file, tree, buffer, line
nmap <leader>ff :FufFile **/<CR>
nmap <leader>ft :FufFile<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>fr :FufRenewCache<CR>
" }
" }

" Key mappings {

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" show/Hide hidden Chars
map <silent> <F12> :set invlist<CR>
" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR>

nnoremap <silent> <F3> :Grep<CR>

map <S-F4> :VimwikiAll2HTML<cr>
map <F4> :Vimwiki2HTML<cr>
" don't conflict with input method
map <leader>, <Plug>VimwikiToggleListItem

" load tags for user apps
nmap <silent> <Leader>tu :set tags+=tags,~/program/dev/include/tags<cr>
" load tags for kernel
nmap <silent> <Leader>tk :set tags+=~/program/dev/kernel/tags<cr>
" unload tags
nmap <silent> <Leader>tr :set tags=./tags,./TAGS,tags,TAGS<cr>

map <F12> :call Do_CsTag()<CR>

nmap <silent> <Leader>tr :%s,\s\+$,,g<CR> "删除所有行未尾空格
map <silent> <Leader>ms :call SetMouse()<cr>
map <silent> <Leader>nu :setlocal nu!<cr>
map <silent> <leader>np :setlocal paste!<cr>

" Make Arrow Keys Useful Again {
" map <silent> <left> <ESC>:Tlist<RETURN>
map <silent> <left> <ESC>:TagbarToggle<RETURN>
map <silent> <right> <ESC>:NERDTreeToggle<RETURN>
map <silent> <up> <ESC>:bp<RETURN>
map <silent> <down> <ESC>:bn<RETURN>
" }
if has("gui_running")
	map <silent> <Leader>gg :call SetGui()<cr>
endif
" Key mappings for QuickFix {
let g:jah_Quickfix_Win_Height=10
nmap <silent> <leader>qf :QFix<CR>
nmap <silent> <leader>qn :cn<CR>
nmap <silent> <leader>qp :cp<CR>
" }
" }

" Autocommands {
" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

"Auto commands
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file
" C++ 对没有后缀的c++头文件加入识别 {
au BufEnter /usr/include/c++/*    setf cpp " /usr/include/c++/下所有文件按c++对待
" }
" Ruby {
" ruby standard 2 spaces, always
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
" }
" Notes {
" I consider .notes files special, and handle them differently, I
" should probably put this in another file
au BufRead,BufNewFile *.notes set foldlevel=2
au BufRead,BufNewFile *.notes set foldmethod=indent
au BufRead,BufNewFile *.notes set foldtext=foldtext()
au BufRead,BufNewFile *.notes set listchars=tab:\ \
au BufRead,BufNewFile *.notes set noexpandtab
au BufRead,BufNewFile *.notes set shiftwidth=8
au BufRead,BufNewFile *.notes set softtabstop=8
au BufRead,BufNewFile *.notes set tabstop=8
au BufRead,BufNewFile *.notes set syntax=notes
au BufRead,BufNewFile *.notes set nocursorcolumn
au BufRead,BufNewFile *.notes set nocursorline
au BufRead,BufNewFile *.notes set guifont=Consolas:h12
au BufRead,BufNewFile *.notes set spell
" }
au BufNewFile,BufRead *.ahk setf ahk
" 对一切文件不做拼写检查
"au BufEnter * set nospell

" 移除末尾空格
au BufWritePre * call RemoveTrailingSpace()
" google's Protocol Buffer {
augroup filetype
	au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
"}

" Oracle proc {
augroup filetype
	au! BufRead,BufNewFile *.pc setfiletype proc
augroup end
"}
" Setting for files following the GNU coding standard
au BufEnter /usr/* call GnuIndent()
au FileType c,cpp  map <buffer> <leader><space> :w<cr>:make<cr>:cw 10<cr>
" }

" GUI Settings {
if has("gui_running")
	" Basics {
	colorscheme caravaggio " my color scheme (only works in GUI)
	set columns=180 " perfect size for me
	set guifont=YaHei\ Monaco\ 12 " My favorite font
	set guioptions=ce
	"              ||
	"              |+-- use simple dialogs rather than pop-ups
	"              +  use GUI tabs, not console style tabs
	set lines=55 " perfect size for me
	set mousehide " hide the mouse cursor when typing
	" }
	" Coding {
	"Highlight current
	set cursorline
	hi cursorline guibg=#333333
	hi CursorColumn guibg=#333333

	" }
endif
" }
