" vundle 安装 git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
":PluginInstall
set nocompatible
filetype off
set runtimepath+=~/.vim/vim_runtime/
set rtp+=~/.vim/bundle/Vundle.vim/
hi clear
syntax off
syntax reset
syntax on
retab                                           " 以前的tab也用4空格代替
set nu
set expandtab                                   " 空格替换tab
set exrc
set secure
set cindent
set ruler
set magic
set showmatch
set hlsearch
set cursorline                                  " 光标行
set cursorcolumn                                " 光标列
set autoread
set autowrite
set noswapfile                                  " 禁止生成临时文件
set ignorecase
set autoindent
set cindent
set foldenable                                  " 允许折叠
"set mouse=a                                    " 使用鼠标
set tabstop=4	                                " 4空格替换一个tab
set shiftwidth=4	                            " 自动缩进4
set softtabstop=4	                            " 自动缩进4
set laststatus=2
set encoding=utf-8
set langmenu=zn_CN.UTF-8                        " 语言设置
set helplang=cn                                 " 语言设置
set fdm=indent
set foldmethod=syntax                           " 按语法折叠
set foldcolumn=2                                " 折叠区域宽度
set foldlevel=1                                 " 设置折叠层数
set backspace=indent,eol,start                  " 设置退格删除
set guifont=Courier_New:h9:cANSI
set clipboard+=unnamed                          " 共享粘贴板

let g:go_version_warning = 0                    " 去除版本信息警告

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'                   " vim 插件管理
Plugin 'vim-airline/vim-airline'                " 底栏信息
Plugin 'tpope/vim-markdown.git'                 " markdown 编辑器
Plugin 'scrooloose/syntastic'                   " 语法高亮与错误检查
Plugin 'terryma/vim-multiple-cursors'           " 多行编辑
Plugin 'tpope/vim-fugitive'                     " github 操作
Plugin 'scrooloose/nerdtree'                    " 侧边栏文件
Plugin 'szw/vim-tags'                           " ctags 生成
Plugin 'c.vim'                                  " c 语言插件
call vundle#end()
nnoremap <C-c> :call multiple_cursors#quit()<CR>
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
filetype plugin indent on

" c 语言插件
let g:C_UseTool_cmake = 'no'
let g:C_UseTool_doxygen = 'no'

" ctags 生成
set tags=tags
let g:vim_tags_auto_generate = 1                " 保存时自动生成 ctags 文件
let g:vim_tags_use_language_field = 1           " 自动补全
let g:vim_tags_cache_dir = '/tmp'               " ctag 缓存目录
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore']                   " 忽略文件
let g:vim_tags_directories = ['/tmp', '.git', '.hg', '.svn', '.bzr', '_darcs', 'CVS']      " tag要创建的目录

" 侧边栏文件
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" 多行编辑
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
let g:multi_cursor_start_word_key      = '<C-n>'    " 选中后按 ctrl + n 竖直编辑
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" airline 漂亮的底栏
let g:airline#extensions#tabline#enabled = 1                " 路径
let g:airline#extensions#tabline#formatter = 'unique_tail'  " 路径展示

" markdown 编辑
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 1
let g:markdown_minlines = 100


" 设置文件头信息
autocmd BufNewFile *.* exec ":call SetFileTitle()"
func SetFileTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'md'
        call setline(1, "")
    else
        call setline(1,"/*************************************************************************")
        call append(line("."),      "> FileName: ".expand("%"))
        call append(line(".")+1,    "> Author  : Yue Shuai")
        call append(line(".")+2,    "> Mail    : datyuesh@163.com")
        call append(line(".")+3,    "> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc
autocmd BufNewFile * normal G
" 设置文件头--结束
" 记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

