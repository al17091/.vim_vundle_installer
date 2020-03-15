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

"Ctags config----------------------------------
set fileformats=unix,dos,mac
set fileencodings=utf-8
set tags=.tags;$HOME
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
    " `:p:h`の部分は、:h filename-modifiersで確認
    let tags_dirpath = fnamemodify(tags_path,':p:h')

    "見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
    execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction

augroup ctags
    autocmd!
    autocmd BufWritePost * call s:execute_ctags()
    augroup END
"End Ctags config

"NeoBundle Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/dapt/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/home/dapt/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \ },
    \ }

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'w0rp/ale'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'maximbaz/lightline-ale'
NeoBundle 'Yggdroot/indentLine'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"Unite.vim config------------------------------
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"End Unite.vim config--------------------------

"syntastic config------------------------------
let g:syntastic_mode_map = {
    \   'mode': 'active',
    \   'active_filetypes': ['php', 'coffeescript', 'sh', 'vim'],
    \   'passive_filetypes': ['html','python']
  \}
"End syntastic config--------------------------

"Error and Warning format----------------------
set laststatus=2

if !has('gui_running')
    set t_Co=256
endif

let g:lightline = {
    \   'colorscheme': 'wombat',
    \   'active': {
    \       'left': [
    \           ['mode', 'paste'],
    \           ['readonly', 'filename', 'modified', 'ale'],
    \           ['linter_checking','linter_errors','linter_warnings','linter_infos','linter_ok'],
    \       ]
    \   }, 
    \   'component_expand': {
    \       'linter_checking': 'lightline#ale#checking',
    \       'linter_infos': 'lightline#ale#infos',
    \       'linter_warnings': 'lightline#ale#warnings',
    \       'linter_errors': 'lightline#ale#errors',
    \       'linter_ok': 'lightline#ale#ok',
    \   },
    \   'component_type': {
    \       'linter_checking': 'right',
    \       'linter_infos': 'right',
    \       'linter_warnings': 'warning',
    \       'linter_errors': 'error',
    \       'linter_ok': 'right',
    \   },
    \   'component_function': {
    \   'ale': 'ALEGetStatusLine'
    \   }
  \}

let g:ale_echo_msg_error_str = 'error'
let g:ale_echo_msg_warning_str = 'warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"End Error and Warning format------------------

"color config----------------------------------
hi Comment ctermfg=DarkGray
hi LineNr ctermfg=DarkGray

"key mapping
noremap <C-L> :NERDTree<CR>
