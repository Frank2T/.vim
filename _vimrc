set nocompatible                                      "禁用 Vi 兼容模式
if has("win32")
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif
" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
" =============================================================================
"                          << 插件管理 >>
" =============================================================================
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料

filetype off                                          "禁用文件类型侦测

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 使用Vundle来管理Vundle，这个必须要有。
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'
Plugin 'fholgado/minibufexpl.vim'
"Plugin 'file:///C:/Users/frank/vimfiles1/bundle/molokai'
call vundle#end()
syntax on
syntax enable
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件

"indent set
filetype indent on                                    "启用缩进
set autoindent
set smartindent                                       "启用智能对齐方式
set cindent

"tab set 
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set softtabstop=4
set expandtab                                         "将Tab键转换为空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
"set foldmethod=indent                                "indent 折叠方式
set foldmethod=syntax                                 "syntax 折叠s1方式
set wildmenu                                          "vim 自身命令行模式智能补全
set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
set mouse=a
set writebackup
" 文件修改之后自动载入
set autoread
set hidden
set hlsearch
set incsearch
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数 
set scrolloff=7 
"========================================== 
" others 其它设置 
"========================================== 
" vimrc文件修改之后自动加载, windows 
autocmd! bufwritepost _vimrc source % 
" vimrc文件修改之后自动加载, linux 
autocmd! bufwritepost .vimrc source % 

" =============================================================================
"                          << 编码设置 >>
" =============================================================================
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set termencoding=utf-8
set fileencoding=utf-8                                "设置当前文件编码
"设置支持打开的文件的编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

" 如遇Unicode值大于255的文本，不必等到空格再折行 
set formatoptions+=m 
" 合并两行中文时，不在中间加空格 
set formatoptions+=B 
if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
" language messages zh_CN.utf-8
    language messages en
endif
" =============================================================================
"        << 界面&主题配置 >>
" =============================================================================
" 设置代码配色方案
if g:isGUI
     "colorscheme solarized
     colorscheme molokai 
   set background=dark
else
     "colorscheme molokai
     colorscheme gruvbox
     set background=dark
endif
" 隐藏菜单栏、工具栏、滚动条
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set t_Co=256
    set guitablabel=%M\ %t
endif
set guifont=YaHei\ Consolas\ Hybrid:h10               "设置 gvim 显示字体
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set ruler                                             "显示光标当前位置
set cursorline                                        "高亮显示当前行/列
"set cursorcolumn
set nofoldenable                                      "不启用折叠
set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
set gcr=a:block-blinkon0                             "禁止光标闪烁


" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转 
set relativenumber number 
au FocusLost * :set norelativenumber number 
au FocusGained * :set relativenumber 
" 插入模式下用绝对行号, 普通模式下用相对 
autocmd InsertEnter * :set norelativenumber number 
autocmd InsertLeave * :set relativenumber 
function! NumberToggle() 
  if(&relativenumber == 1) 
    set norelativenumber number 
  else 
    set relativenumber 
  endif 
endfunc 
nnoremap <C-n> :call NumberToggle()<cr> 
" =============================================================================
"                            << 设置快捷键映射 >>
" =============================================================================
let mapleader=";"                                     " 定义快捷键的前缀，即<Leader>
vnoremap <Leader>y "+y                                " 设置快捷键将选中文本块复制至系统剪贴板
nmap <Leader>p "+p                                    " 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>Y "*y                                    " 设置快捷键将选中文本复制到系统缓冲区
nmap <Leader>P "*p                                    " 设置快捷键将系统缓冲区内容粘贴至 vim
nnoremap <Leader>q :q<CR>" 定义快捷键关闭当前分割窗口
nnoremap <Leader>w :w<CR>" 定义快捷键保存当前窗口内容
nmap <Leader>WQ :wa<CR>:q<CR>                        " 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>Q :qa!<CR>                               " 不做任何保存，直接退出 vim
nnoremap wn <C-W><C-W>                                " 依次遍历子窗口
nnoremap wp <C-w>p                                    " 逆向遍历窗口
nnoremap <Leader>lw <C-W>l                            " 跳转至右方的窗口
nnoremap <Leader>hw <C-W>h                            " 跳转至左方的窗口
nnoremap <Leader>kw <C-W>k                            " 跳转至上方的子窗口
nnoremap <Leader>jw <C-W>j                            " 跳转至下方的子窗口
nnoremap <Leader>Lw <C-W>L                            " 跳转至最右方的窗口
nnoremap <Leader>Hw <C-W>H                            " 跳转至最左方的窗口
nnoremap <Leader>Kw <C-W>K                            " 跳转至最上方的子窗口
nnoremap <Leader>Jw <C-W>J                            " 跳转至最下方的子窗口
" Go to home and end using capitalized directions 
noremap H ^ 
noremap L $ 

" 去掉搜索高亮 
noremap <silent><leader>/ :nohls<CR> 
" tab/buffer相关 


" 切换前后buffer 
nnoremap [b :bprevious<cr> 
nnoremap ]b :bnext<cr> 
" 使用方向键切换buffer 
noremap <left> :bp<CR> 
noremap <right> :bn<CR> 




" tab 操作 
" http://vim.wikia.com/wiki/Alternative_tab_navigation 
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim 


" tab切换 
map <leader>th :tabfirst<cr> 
map <leader>tl :tablast<cr> 


map <leader>tj :tabnext<cr> 
map <leader>tk :tabprev<cr> 
map <leader>tn :tabnext<cr> 
map <leader>tp :tabprev<cr> 


map <leader>te :tabedit<cr> 
map <leader>td :tabclose<cr> 
map <leader>tm :tabm<cr> 


" normal模式下切换到确切的tab 
noremap <leader>1 1gt 
noremap <leader>2 2gt 
noremap <leader>3 3gt 
noremap <leader>4 4gt 
noremap <leader>5 5gt 
noremap <leader>6 6gt 
noremap <leader>7 7gt 
noremap <leader>8 8gt 
noremap <leader>9 9gt 
noremap <leader>0 :tablast<cr> 


" Toggles between the active and last active tab " 
" The first tab is always 1 " 
let g:last_active_tab = 1 
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr> 
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr> 
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr> 
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr> 
autocmd TabLeave * let g:last_active_tab = tabpagenr() 


" 新建tab  Ctrl+t 
"nnoremap <C-t>     :tabnew<CR> 
"inoremap <C-t>     <Esc>:tabnew<CR> 
" Quickly edit/reload the vimrc file 
nmap <silent> <leader>ev :e $MYVIMRC<CR> 
nmap <silent> <leader>sv :so $MYVIMRC<CR> 

" =============================================================================
"                          << 插件配置 >>
" =============================================================================
"------------------------------------------------------------------------
" < nerdtree >
"------------------------------------------------------------------------
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=28
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=0
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
"------------------------------------------------------------------------
" < minibufexpl >
"------------------------------------------------------------------------
" 显示/隐藏 MiniBufExplorer 窗口
let g:miniBufExplMapCTabSwitchBufs=1
map <Leader>bt :MBEToggle<cr>
map <Leader>bo :MBEOpen<cr>
map <Leader>bc :MBEClose<cr>

" buffer 切换快捷键
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>
map <Leader><Leader>d :MBEbd<cr>
map <Leader><Leader>b :call BufferOpen()<cr>
" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
