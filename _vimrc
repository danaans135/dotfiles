" NeoBundle {{{

set nocompatible

if has("vim_starting")
  set runtimepath+=$HOME/vimfiles/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/vimfiles/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/vimwiki.git'
NeoBundle 'tyru/restart.vim'

" �J���[�X�L�[��
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'vim-scripts/newspaper.vim'

filetype plugin indent on 

NeoBundleCheck

"}}}

" Setting {{{

set autoindent                "�V�����s�̃C���f���g�����ݍs�Ɠ����ɂ���
set backupdir=$HOME/vimbackup "�o�b�N�A�b�v�t�@�C�������f�B���N�g��
set browsedir=buffer          "�t�@�C���ۑ��_�C�A���O�̏����f�B���N�g�����o�b�t�@�t�@�C���ʒu�ɐݒ�
set clipboard=unnamed         "�N���b�v�{�[�h��Windows�ƘA�g
set directory=$HOME/vimbackup "�X���b�v�t�@�C���p�̃f�B���N�g��
set expandtab                 "�^�u�̑���ɋ󔒕�����}������
set hidden                    "�ύX���̃t�@�C���ł��A�ۑ����Ȃ��ő��̃t�@�C����\��
set incsearch                 "�C���N�������^���T�[�`���s��
set list
set listchars=tab:^\ ,trail:~
set number                    "�s�ԍ���\������
"set shiftwidth=4             "�V�t�g�ړ���
set showmatch                 "�����ʂ����͂��ꂽ�Ƃ��A�Ή����銇�ʂ�\������
set smartcase                 "�������ɑ啶�����܂�ł������/�������
set smartindent               "�V�����s��������Ƃ��ɍ��x�Ȏ����C���f���g���s��
set smarttab                  "�s���̗]������ Tab ��ł����ނƁA'shiftwidth' �̐������C���f���g����B
"set tabstop=4                "�t�@�C������ <Tab> ���Ή�����󔒂̐�
set whichwrap=b,s,h,l,<,>,[,] "�J�[�\�����s���A�s���Ŏ~�܂�Ȃ��悤�ɂ���
set nowrapscan                "�������t�@�C���̐擪�փ��[�v���Ȃ�
set visualbell                "�r�W���A���x�����g�p����
set cmdheight=1               "�R�}���h�s��1�s�ɂ���
"set encoding=utf-8
"scriptencoding cp932

nnoremap <silent> ,v :e $HOME/_vimrc<CR>
nnoremap <silent> ,s :e $HOME/scratch.txt<CR>
nnoremap <silent> ,fe :exe "e ".expand("%:h")<CR>
nnoremap <silent> ,fl :<C-u>e $HOME/launch/<CR>
nnoremap <silent> <Leader>fl :<C-u>VimFiler file:$HOME/launch/<CR>
noremap <silent> <ESC><ESC> :<C-u>noh<CR>
nmap <silent> ,x "jyy:@j<CR>
map <F2> a<C-R>=strftime("%c")<CR><Esc>

" netrw�ݒ�
autocmd FileType netrw call s:netrw_settings()
function! s:netrw_settings()
  nnoremap <silent><buffer> ~ :<C-u>e $HOME<CR>
endfunction

"�}�����[�h���A�X�e�[�^�X���C���̐F��ύX{{{
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
"}}}

"IME��Ԃɂ��J�[�\���F��ύX����{{{
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Red
endif
"}}}

" \w ���ݍsURL���u���E�U�ŊJ��{{{
let $PATH = $PATH . ';c:\Program Files (x86)\Mozilla Firefox'
"=== evoke a web browser
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
  let line = matchstr (line0, "ftp[^ ]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
  :if line==""
  let line = "\"" . (expand("%:p")) . "\""
  :endif
  exec ':silent !firefox.exe ' . line
endfunction
map \w :call Browser ()<CR>
"}}}

" �ҏWESC����IME���I�t�ɂ���B {{{
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" }}}

" F11 fullscreen {{{
nnoremap <F11> :call ToggleFullScreen()<CR>
function! ToggleFullScreen()
  if &guioptions =~# 'C'
    set guioptions-=C
    if exists('s:go_temp')
      if s:go_temp =~# 'm'
        set guioptions+=m
      endif
      if s:go_temp =~# 'T'
        set guioptions+=T
      endif
    endif
    simalt ~r
  else
    let s:go_temp = &guioptions
    set guioptions+=C
    set guioptions-=m
    set guioptions-=T
    simalt ~x
  endif
endfunction
"}}}

" augroup {{{

augroup mygroup
  "au FileType scratch.txt call s:ScratchLoad()
  "au BufReadPost scratch.txt call s:ScratchLoad()
  au BufReadPost scratch.txt call s:ScratchLoad()
  function! s:ScratchLoad()
    if strftime("%m/%d", getftime(@%)) != strftime("%m/%d")
      call s:AppendTime()
    endif
  endfunction
  function! s:AppendTime()
    exe "normal mmGo\<CR>}}}\<CR>".strftime("%m/%d")."\<ESC>20a=\<ESC>a{{{\<ESC>o\<ESC>'m"
  endfunction
augroup END

"}}}
"

let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s',
      \ 'outputter': 'browser',
      \ 'hook/output_encode/enable': 1,
      \ 'hook/output_encode/encoding': 'utf-8:utf-8'
      \ }

"}}}

"unite {{{

"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

"�C���T�[�g���[�h�ŊJ�n���Ȃ�
let g:unite_enable_start_insert = 0

"" For ack.
"if executable('ack-grep')
"  let g:unite_source_grep_command = 'ack-grep'
"  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
"  let g:unite_source_grep_recursive_opt = ''
"endif

"file_mru�̕\���t�H�[�}�b�g���w��B��ɂ���ƕ\���X�s�[�h�������������
let g:unite_source_file_mru_filename_format = ''

""data_directory ��ramdisk���w��
"if has('win32')
"  let g:unite_data_directory = 'R:\.unite'
"elseif  has('macunix')
"  let g:unite_data_directory = '/Volumes/RamDisk/.unite'
"else
"  let g:unite_data_directory = '/mnt/ramdisk/.unite'
"endif

"bookmark�����z�[���f�B���N�g���ɕۑ�
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'

"���݊J���Ă���t�@�C���̃f�B���N�g�����̃t�@�C���ꗗ�B
"�J���Ă��Ȃ��ꍇ�̓J�����g�f�B���N�g��
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"�o�b�t�@�ꗗ
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"���W�X�^�ꗗ
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"�ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"�u�b�N�}�[�N�ꗗ
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"�u�b�N�}�[�N�ɒǉ�
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"unite���J���Ă���Ԃ̃L�[�}�b�s���O
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESC��unite���I��
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "���̓��[�h�̂Ƃ�jj�Ńm�[�}�����[�h�Ɉړ�
  imap <buffer> jj <Plug>(unite_insert_leave)
  "���̓��[�h�̂Ƃ�ctrl+w�Ńo�b�N�X���b�V�����폜
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "s��split
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  "v��vsplit
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  "f��vimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction

"}}}

"vimfiler {{{

""data_directory ��ramdisk���w��
"if has('win32')
"  let g:vimfiler_data_directory = 'R:\.vimfiler'
"elseif  has('macunix')
"  let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
"else
"  let g:vimfiler_data_directory = '/mnt/ramdisk/.vimfiler'
"endif

"vim�f�t�H���g�̃G�N�X�v���[����vimfiler�Œu��������
"let g:vimfiler_as_default_explorer = 1
"�Z�[�t���[�h�𖳌��ɂ�����ԂŋN������
let g:vimfiler_safe_mode_by_default = 0
"���݊J���Ă���o�b�t�@�̃f�B���N�g�����J��
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"���݊J���Ă���o�b�t�@��IDE���ɊJ��
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"�f�t�H���g�̃L�[�}�b�s���O��ύX
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

"}}}

" vim:fdm=marker:ts=2:sts=2:sw=2:
