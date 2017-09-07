set nocp  "设置vi兼容模式关闭
set nocompatible  "设置vi兼容模式关闭

"常规设置
set noswapfile
set history=50         " keep 50 lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set fileencodings=utf-8,bg18030,gbk,big5
set backspace=2         "退格键可用
set shiftround
set number              "显示行号
set numberwidth=5
set laststatus=2        "打开状态栏
set incsearch           "查找替换相关
set hlsearch
set undodir=~/.vim/.undodir "备份
set backupdir=~/.vim/.backup "备份
set backspace=indent,eol,start
set clipboard=unnamed   " 使用系统剪切板

"编程相关
syn on                  "打开语法高亮
set showmatch           "设置匹配模式
set smartindent         "智能对齐方式
set linebreak           "整词换行
set autochdir           "自动设置目录为正在编辑的文件所在的目录
set autoread            "当文件在外部被改变时，vim自动更新载入
set list listchars=tab:»·,trail:· "设置制表符与行尾空格显示
set tabstop=4           "设置tab宽度
set shiftwidth=4
set expandtab
" 去除 traling space
autocmd FileType c,cpp,java,php,py autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType py,php set fileformat=unix
autocmd FileType py set foldmethod=indent
autocmd FileType py set foldlevel=99

" pep8规范
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |


"快捷键设置
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
inoremap { {}
nnoremap <space> za

"插件管理器相关
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " 插件管理
Plugin 'Valloric/YouCompleteMe'             " 代码补全
Plugin 'kien/ctrlp.vim'                     " 快速定位到某个文件
Plugin 'scrooloose/nerdtree'                " 文件管理器
Plugin 'tomasr/molokai'                     " 配色
Plugin 'shawncplus/phpcomplete.vim'         " php代码补全
Plugin 'vim-scripts/taglist.vim'            " 显示tag列表，配合ctags使用
Plugin 'tmhedberg/SimpylFold'               " 代码折叠
Plugin 'vim-scripts/indentpython.vim'       " python自动缩进
Plugin 'scrooloose/syntastic'               " 代码检测
Plugin 'nvie/vim-flake8'                    " pep8风格检查
Plugin 'jnurmine/Zenburn'                   " 配色方案
Plugin 'altercation/vim-colors-solarized'   " 配色方案
Plugin 'tpope/vim-fugitive'                 " vim
Plugin 'dyng/ctrlsf.vim'                    " 全局搜索
call vundle#end()
filetype plugin indent on

" 配色相关
" molokai配色
let g:molokai_original = 1
" python配色
let python_highlight_all=1
syntax on

if has('gui_running')
  set background=dark
  colorscheme solarized
  call togglebg#map("<F5>")
else
  colorscheme Zenburn
endif

" flake8 插件设置
let g:flake8_max_line_length=120
" let g:flake8_ignore="E501,W293"
" let g:flake8_builtins="_,apply"

" ctrlsf 插件设置
let g:ctrlsf_default_root = 'project'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" tags相关
set tags+=~/webroot/aborad/tags
set tags+=~/webroot/gateway/tags
set tags+=~/webroot/newcps/tags

function UpdatePhpCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !phpctags -R *
    endif
    execute ":cd " . curdir
endfunction

function UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R *
    endif
    execute ":cd " . curdir
endfunction

