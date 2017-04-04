"vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %
"设置backspace行为
set backspace=indent,eol,start 
"显示行号
set nu
"显示标尺
set ruler
"不自动备份
set nobackup
"语法高亮
syntax enable 
syntax on
"关闭兼容模式
set nocompatible
"设置命令行模式下的历史记录
set history=200
"设置以unix的格式保存文件
set fileformat=unix    
"高亮当前行
set cursorline
"高亮当前列
"set cursorcolumn
"始终显示状态栏
set laststatus=2
"设置tab键空4格
set tabstop=4
"将Tab自动转化成空格(需要输入真正的Tab键时，使用<C-V>+Tab)
set expandtab
"退格键一次删掉4个空格
set smarttab
"实时搜索
set incsearch
"高亮搜索结果
set hlsearch
"忽略大小写
set ignorecase
"有一个或以上大写字母时仍大小写敏感
set smartcase
"打开正则表达式
set magic
"显示匹配的括号
set showmatch
"显示当前所处模式
set showmode
"设置右下角显示当前光标位置
set showcmd
"设置主题为desertEx
colorscheme desertEx
set t_Co=256
set background=dark
"禁止自动折行
set nowrap
"设置当文件被改动时自动载入
set autoread
"设置退出插入模式后自动保存
set autowrite
"允许插件  
filetype plugin on
"共享剪贴板  
set clipboard+=unnamed
"去掉输入错误的提示声音
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"禁止光标闪烁
"set gcr=a:block-blinkon0
"在处理未保存或只读文件的时候，弹出确认
set confirm
"上下移动光标时光标上方和下方至少保留两行
set scrolloff=2
"自动缩进
set autoindent
set cindent
set smartindent
set shiftwidth=4
"为特定文件类型载入相关缩进文件
filetype indent on
"设置文件编码为utf-8
set fenc=utf-8
"设置字体为Monaco
set guifont=Monaco\ 10
"自动判断编码时，依次尝试以下编码
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
"设置默认窗口大小
set lines=36 columns=84
"自动检测文件类型
filetype plugin indent on
"设置显示消息的列数
set cmdheight=2
"隐藏工具栏
set guioptions-=T
"Ctrl+T新建标签页
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
"修改分屏移动快捷键
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"修改leader键
let mapleader = "\<space>"
let g:mapleader = "\<space>"
"设置插入模式和可视模式下的退出键
inoremap jj <Esc>
vnoremap jj <Esc>
"全选
map <Leader>a ggVG
"全选并复制到系统剪贴板
nmap <leader>aw <esc>ggVG"+y<esc>
"选中块
nnoremap <leader>v V`}
"设置快捷键关闭buffer
nnoremap <leader>q :bd<CR> 
"设置<C-s>保存文件
inoremap <C-s> <esc>:w<cr>A
"一键替换全部Tab为空格
nmap <leader>ct <esc>:retab<cr>
"设置状态栏显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
"F2显示可打印字符开关
nnoremap <F2> :set list! list?<CR>
"F4行号显示开关
nmap <F4> :set number! number?<CR>
"C，C++,python,java,shell按F9编译运行
map <F9> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
	elseif &filetype == 'go'
		exec "!time go run %"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"F8进行C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
"自动插入文件头
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py exec ":call SetTitle()" 
func SetTitle() 
    if expand("%:e") == 'sh'
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif expand("%:e") == 'py'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 
    elseif expand("%:e") == 'cpp'
        call setline(1,"#include <iostream>") 
        call append(line("."), "") 
    elseif expand("%:e") == 'cc'
        call setline(1,"#include <iostream>") 
        call append(line("."), "") 
    elseif expand("%:e") == 'c'
        call setline(1,"#include <stdio.h>") 
        call append(line("."), "") 
    elseif expand("%:e") == 'h'
        call setline(1, "#pragma once")
    elseif expand("%:e") == 'hpp'
        call setline(1, "#pragma once")
    endif
endfunc 
autocmd BufNewFile * normal G


"airline
"安装字体后必须设置
let g:airline_powerline_fonts = 1  
"关闭tabline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = ''

"auto-format
noremap <F6> :Autoformat<CR>
let g:autoformat_verbosemode=1
let g:formatter_yapf_style = 'pep8'
au BufWrite *.py :Autoformat

"The NERD tree
"F3触发，设置宽度为30,显示书签
map <F3> :NERDTreeToggle<CR>
let NERDTreeWinSize=30
let NERDTreeShowBookmarks=1
"高亮当前行
let NERDTreeHighlightCursorline=1
"从NERDTree打开文件后自动关闭NERDTree
let NERDTreeQuitOnOpen=1
"显示行号
"let NERDTreeShowLineNumbers=1
"let NERDTreeAutoCenter=1
"自动打开NERDTree
"autocmd vimenter * NERDTree

"tagbar
"F10触发，设置宽度为30
let g:tagbar_width = 30
nmap <F10> :TagbarToggle<CR>
"开启自动预览(随着光标在标签上的移动，顶部会出现一个实时的预览窗口)
let g:tagbar_autopreview = 1  
"关闭排序,即按标签本身在文件中的位置排序
let g:tagbar_sort = 0                                        

"instant-markdown
"#aptitude install nodejs npm xdg-utils,# npm -g install instant-markdown-d

"indentLine
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

"vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_persist_undo_history = 1 
let g:workspace_undodir='.undodir'
let g:workspace_autosave_always = 1
let g:workspace_autosave_ignore = ['gitcommit']

"cpp-enhanced-highlight
"cpp-enhanced-highlight
"高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1


"ale
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '➤'
let g:ale_statusline_format = ['✗ %d', '➤ %d', '❋ ok']

"ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=10
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"YouCompleteMe
"$ cp third_party/ycmd/examples/.ycm_extra_conf.py ~/
"'-isystem',
"'/usr/include/c++/6.2.1'
"配置默认文件路径
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
"自动开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释中也开启补全
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关闭预览窗口
let g:ycm_autoclose_preview_window_after_completion=1
"禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
"字符串中也开启补全
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1	
"提示UltiSnips
let g:ycm_use_ultisnips_completer = 1 
"跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
"nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>

"UltiSnips
"插入模式下直接通过<c-z>键来触发UltiSnips的代码块补全
let g:UltiSnipsExpandTrigger="<c-z>"
"iI弹出UltiSnips的可用列表,不常用的, 所以这里设置成了特殊的<c-l>映射
let g:UltiSnipsListSnippets="<c-l>"
"<c-f>跳转的到下一个代码块可编辑区
let g:UltiSnipsJumpForwardTrigger="<c-f>"
"<c-b>跳转到上一个代码块可编辑区
let g:UltiSnipsJumpBackwardTrigger="<c-b>"






"syntastic
"自动打开并跳转到第一个错误的地方
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='➤'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 1
let g:syntastic_enable_highlighting=1
"关闭syntastic语法检查, 鼠标复制代码时用到, 防止把错误标志给复制了
nnoremap <silent> <Leader>ec :SyntasticToggleMode<CR>
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

"gundo
nnoremap <leader>h :GundoToggle<CR>
"nnoremap <F6> :GundoToggle<CR>
let g:gundo_width = 30

"open-browser
nmap oo <Plug>(openbrowser-open)
nmap oo <Plug>(openbrowser-smart-search)

"quickrun
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
map <F11> :QuickRun<CR>

"easy-align（vipga，gaip进行操作）
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"NERDCommenter
let g:NERDSpaceDelims=1
"Usage
"<leader>cc   加注释
"<leader>cu   解开注释
"<leader>c<space>  加上/解开注释, 智能判断
"<leader>cy   先复制, 再注解(p可以进行黏贴)

"python-mode
let g:pymode_rope = 1
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"supertab
"let g:SuperTabContextDefaultCompletionType = "<c-n>"  

"indent guides
"自动打开并设置从第二级开始显示，设置宽度为1
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1 
"自定义颜色
"let g:indent_guides_auto_colors = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"空格键打开折叠代码
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
"设置Ctrl+U补全关键字和函数名
"imap <c-u> <c-x><c-o>
"设置快捷键将选中文本块复制至系统剪贴板
"vnoremap <Leader>w "+y
"设置快捷键将系统剪贴板内容粘贴至vim
"nnoremap <Leader>y "+gP
"按下Q不进入Ex模式，而是保存并退出
"nmap Q :x<cr>
"F12放大字体，Shift+F12缩小字体
if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif
if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif

