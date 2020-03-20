"setting
set number 
set title
set encoding=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set tabstop=4
set expandtab
set shiftwidth=4
set incsearch
set smartindent

function! s:execute_ctags() abort

    " 探すタグファイル名
    let tag_name = '.tags'
    " ディレクトリを遡り、タグファイルを探し、パス取得
    let tags_path = findfile(tag_name, '.;')
    " タグファイルパスが見つからなかった場合

    if tags_path ==# ''
        return
    endif
    " タグファイルのディレクトリパスを取得
    " `:p:h`の部分は、:h  filename-modifiersで確認
    let tags_dirpath =  fnamemodify(tags_path,':p:h')
    "見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
    execute 'silent !cd' tags_dirpath '&&  ctags -R -f' tag_name '2> /dev/null &'
endfunction

augroup ctags
    autocmd!
    autocmd BufWritePost * call s:execute_ctags()
augroup END
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just:PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` toauto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
hi LineNr ctermfg=DarkGray
hi Comment ctermfg=DarkGray
noremap <C-L> :NERDTree<CR>
