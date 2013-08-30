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
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/batch.vim'
NeoBundle 'danaans135/vim-plugin-commarepeat'

" カラースキーム
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
NeoBundle 'danaans135/vim-colors-swandive'

filetype plugin indent on 

NeoBundleCheck

"}}}

" Setting {{{

set autoindent                "新しい行のインデントを現在行と同じにする
set backupdir=$HOME/vimbackup "バックアップファイルを作るディレクトリ
set browsedir=buffer          "ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set clipboard=unnamed         "クリップボードをWindowsと連携
set directory=$HOME/vimbackup "スワップファイル用のディレクトリ
set expandtab                 "タブの代わりに空白文字を挿入する
set hidden                    "変更中のファイルでも、保存しないで他のファイルを表示
set incsearch                 "インクリメンタルサーチを行う
set list
set listchars=tab:^\ ,trail:~
set number                    "行番号を表示する
"set shiftwidth=4             "シフト移動幅
set showmatch                 "閉じ括弧が入力されたとき、対応する括弧を表示する
set smartcase                 "検索時に大文字を含んでいたら大/小を区別
set smartindent               "新しい行を作ったときに高度な自動インデントを行う
set smarttab                  "行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
"set tabstop=4                "ファイル内の <Tab> が対応する空白の数
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
set nowrapscan                "検索をファイルの先頭へループしない
set visualbell                "ビジュアルベルを使用する
set cmdheight=1               "コマンド行を1行にする
"set encoding=utf-8
"scriptencoding cp932
set viewdir=$HOME/vimfiles/view
set nowrap
set cursorline

nnoremap <silent> ,v         :e $HOME/dotfiles/_vimrc<CR>
nnoremap <silent> ,vg        :e $HOME/dotfiles/_gvimrc<CR>
nnoremap <silent> ,s         :e $HOME/scratch.txt<CR>
nnoremap <silent> ,vs        :e $HOME/Documents/GitHub/vim-colors-swandive/colors/swandive.vim<CR>
nnoremap <silent> ,fe        :exe "e ".expand("%:h")<CR>
nnoremap <silent> ,fl        :<C-u>e $HOME/launch/<CR>
nnoremap <silent> <Leader>fl :<C-u>VimFiler file:$HOME/launch/<CR>
noremap  <silent> <ESC><ESC> :<C-u>noh<CR>
nmap     <silent> ,x         "jyy:@j<CR>
map               <F2>       a<C-R>=strftime("%c")<CR><Esc>
nmap              ,oo        <plug>(openbrowser-open)
nmap              ,os        <plug>(openbrowser-search)
xnoremap          al         :Alignta<Space>

vnoremap <silent> ,ta        :s/^\(\s*\)\(.*\)$/\1" \2" \& _/<CR>
vnoremap <silent> ,tb        :s/^\(\s*\)" \(.*\)" \+& _$/\1\2/<CR>

" netrw設定
autocmd FileType netrw call s:netrw_settings()
function! s:netrw_settings()
  nnoremap <silent><buffer> ~ :<C-u>e $HOME<CR>
endfunction

" スニペットファイルの配置場所
let g:NeoComplCache_SnippetsDir = '~/vimfiles/snippets'
 
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"挿入モード時、ステータスラインの色を変更{{{
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

"IME状態によりカーソル色を変更する{{{
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Red
endif
"}}}

" \w 現在行URLをブラウザで開く{{{
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

" 編集ESC時にIMEをオフにする。 {{{
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

" asp
au BufNewFile,BufRead *.aspx setf aspx

"*.sqlファイルを編集するときにビューを自動的に保存、復元する
au BufWinLeave *.sql mkview
au BufWinEnter *.sql silent loadview

"}}}

let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s',
      \ 'outputter': 'browser',
      \ 'hook/output_encode/enable': 1,
      \ 'hook/output_encode/encoding': 'utf-8:utf-8'
      \ }

"'<,'>s/	\+/ /g
"'<,'>s/\s\+$//
"'<,'>s/^\(\S\+\) \(\S\+\)$/\\       ["\1","\2"],/
"'<,'>Align ,/1 ]

"\       ["出荷実績データ"     , "MZ_SyukaJisseki" ] ,
"\       ["出荷実績ＩＤ"       , "ID"              ] ,
"\       ["代表保管場所コード" , "InvLocNo"        ] ,
"\       ["出荷予定日"         , "SyukaDueDate"    ] ,
"\       ["方面別コード"       , "AreaCode"        ] ,
"\       ["級品"               , "Kyuuhin"         ] ,
"\       ["商品コード"         , "SyouhinCode"     ] ,
"\       ["実績数"             , "JissekiQty"      ] ,
"\       ["実績入力日"         , "JissekiDate"     ] ,
"\       ["出荷区分"           , "SyukaType"       ] ,
"\       ["ロットNO"           , "LotNo"           ] ,
"\       ["連携フラグ"         , "RenkeiFlag"      ] ,
"
"\       ["出荷先数量ワーク" , "MZ_W_AreaQty"      ],
"\       ["代表保管場所コード" , "InvLocNo"      ],
"\       ["商品CD"        , "SyouhinCode"      ] ,
"\       ["級品"          , "Kyuuhin"          ] ,
"\       ["出荷予定日"     , "SyukaDueDate"     ],
"\       ["方面別コード"  , "AreaCode"         ] ,
"\       ["方面名"        , "AreaName"         ] ,
"\       ["実数量"        , "InputQty"         ] ,
"\       ["モード"        , "JissekiInputMode" ] ,
"\       ["実績"          , "JissekiQty"       ] ,
"\       ["出荷区分"      , "SyukaType"        ] ,
"\       ["HHT出荷指示数" , "HhtSyukaShijiQty" ] ,
"
"\       ["商品棚出数量ワーク","MZ_W_SyouhinTana"],
"\       ["商品CD"         , "SyouhinCode"      ],
"\       ["級品"           , "Kyuuhin"          ],
"\       ["出荷予定日"     , "SyukaDueDate"     ],
"\       ["棚番"           , "TanaNo"           ],
"\       ["商品名"         , "Description"      ],
"\       ["実数量"         , "InputQty"         ],
"\       ["実績入力モード" , "JissekiInputMode" ],
"\       ["ロットNO"       , "LotNo"            ],
"
"\       ["処理順"         , "SeqNo"        ],
"\       ["削除フラグ"     , "DeleteFlag"   ],
"\       ["作成ユーザーID" , "CreateUserID" ],
"\       ["作成日付"       , "CreateDate"   ],
"\       ["更新ユーザーID" , "ModifyUserID" ],
"\       ["更新日付"       , "ModifyDate"   ]]
"\       ["運送会社マスタ"       , "MM_TransCom"       ],
"\       ["会社番号"             , "I_COM_CODE"        ],
"\       ["運送会社コード"       , "I_TRANS_COM_CD"    ],
"\       ["ＴＣコード"           , "I_TC_CD"           ],
"\       ["運送会社名"           , "I_TRANS_COM_DESC"  ],
"\       ["ＴＣ名"               , "I_TC_DESC"         ],
"\       ["コイズミ拠点コード"   , "I_KOIZUMI_BASE_CD" ],
"\       ["グループコード"       , "I_GRP_CD"          ],
"\       ["優先順位"             , "I_PRIORITY"        ],
"\       ["方面別コード"         , "I_DISTRICT_CD"     ],
"\       ["出荷便"               , "I_SHIP_SERVICE"    ],
"\       ["ＨＨＴ表示名（略称）" , "I_HHT_DSP_DESC"    ],
"\       ["照会項目"             , "I_INQ_ITEM"        ],
"
"\       ["出荷指示データ"     , "MZ_SyukaShiji" ],
"\       ["出荷区分"           , "SyukaType"     ],
"\       ["代表保管場所コード" , "InvLocNo"      ],
"\       ["出荷予定日"         , "SyukaDueDate"  ],
"\       ["積込日"             , "PickupDate"    ],
"\       ["出荷指示数"         , "SyukaShijiQty" ],
"\       ["在庫引当数"         , "HikiateQty"    ],
"\       ["入荷待ち数"         , "WaitQty"       ],
"\       ["方面別コード"       , "AreaCode"      ],
"\       ["商品コード"         , "SyouhinCode"   ],
"
"\       ["棚番マスタ"         , "MM_Tana"    ],
"\       ["棚番"               , "TanaNo"     ],
"\       ["代表保管場所コード" , "InvLocNo"   ],
"\       ["代表保管場所名"     , "InvLocName" ],
"\       ["棚番グループ"       , "TanaGrp"    ],
"
"\       ["センター在庫データビュー" , "MZ_V_LocationInventories" ],
"\       ["代表保管場所コード"       , "InvLocNo"                 ],
"\       ["商品コード"               , "SyouhinCode"              ],
"\       ["級品"                     , "Kyuuhin"                  ],
"\       ["棚番"                     , "TanaNo"                   ],
"\       ["在庫数"                   , "InvQty"                   ],

function! DefConv() range
  let lnum = a:firstline
  while lnum <= a:lastline
    for [a, b] in [
\       ["出荷先数量ワーク" , "MZ_W_AreaQty"      ],
\       ["代表保管場所コード" , "InvLocNo"      ],
\       ["商品CD"        , "SyouhinCode"      ] ,
\       ["級品"          , "Kyuuhin"          ] ,
\       ["出荷予定日"     , "SyukaDueDate"     ],
\       ["方面別コード"  , "AreaCode"         ] ,
\       ["方面名"        , "AreaName"         ] ,
\       ["実数量"        , "InputQty"         ] ,
\       ["モード"        , "JissekiInputMode" ] ,
\       ["実績"          , "JissekiQty"       ] ,
\       ["出荷区分"      , "SyukaType"        ] ,
\       ["HHT出荷指示数" , "HhtSyukaShijiQty" ] ,
\       ["出荷実績データ"     , "MZ_SyukaJisseki" ] ,
\       ["出荷実績ＩＤ"       , "ID"              ] ,
\       ["代表保管場所コード" , "InvLocNo"        ] ,
\       ["出荷予定日"         , "SyukaDueDate"    ] ,
\       ["方面別コード"       , "AreaCode"        ] ,
\       ["級品"               , "Kyuuhin"         ] ,
\       ["商品コード"         , "SyouhinCode"     ] ,
\       ["実績数"             , "JissekiQty"      ] ,
\       ["実績入力日"         , "JissekiDate"     ] ,
\       ["出荷区分"           , "SyukaType"       ] ,
\       ["ロットNO"           , "LotNo"           ] ,
\       ["連携フラグ"         , "RenkeiFlag"      ] ,
\       ["商品棚出数量ワーク","MZ_W_SyouhinTana"],
\       ["商品CD"         , "SyouhinCode"      ],
\       ["級品"           , "Kyuuhin"          ],
\       ["出荷予定日"     , "SyukaDueDate"     ],
\       ["棚番"           , "TanaNo"           ],
\       ["商品名"         , "Description"      ],
\       ["実数量"         , "InputQty"         ],
\       ["実績入力モード" , "JissekiInputMode" ],
\       ["ロットNO"       , "LotNo"            ],
\       ["処理順"         , "SeqNo"        ],
\       ["削除フラグ"     , "DeleteFlag"   ],
\       ["作成ユーザーID" , "CreateUserID" ],
\       ["作成日付"       , "CreateDate"   ],
\       ["更新ユーザーID" , "ModifyUserID" ],
\       ["更新日付"       , "ModifyDate"   ]]
      "let repl = substitute(getline(lnum), "\\<".a."\\>", b, "g")
      let repl = substitute(getline(lnum), "\\<".b."\\>", a, "g")
      call setline(lnum, repl)
    endfor
    let lnum = lnum + 1
  endwhile
endfunction
command! -range DefConv :<line1>,<line2>call DefConv()

function! PropMaker() range
  let lnum = a:firstline
  while lnum <= a:lastline
    exe "normal aX"
    "let repl = substitute(getline(lnum), "\\<".a."\\>", b, "g")
    "call setline(lnum, repl)
    let lnum = lnum + 1
  endwhile
endfunction


au BufReadPost SqlDefinition.xml setlocal foldmethod=expr foldexpr=MyHelpFold(v:lnum)

function! MyHelpFold(lnum)
  let line = getline(a:lnum)
  let next = getline(a:lnum + 1)
  if line =~ '^.*<Sql .*$'
    return 1
"  elseif next =~ '^\s*<Sql.*$'
"    return '<1'
  elseif line =~ '^\s*</Sql>$'
    return '<1'
  elseif line =~ '^\s*<--\s*$'
    return '1'
  elseif line =~ '^\s*-->\s*$'
    return '<1'
  endif
  return '='
endfunction

"}}}

"unite {{{

"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

"インサートモードで開始しない
let g:unite_enable_start_insert = 0

"" For ack.
"if executable('ack-grep')
"  let g:unite_source_grep_command = 'ack-grep'
"  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
"  let g:unite_source_grep_recursive_opt = ''
"endif

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

""data_directory はramdiskを指定
"if has('win32')
"  let g:unite_data_directory = 'R:\.unite'
"elseif  has('macunix')
"  let g:unite_data_directory = '/Volumes/RamDisk/.unite'
"else
"  let g:unite_data_directory = '/mnt/ramdisk/.unite'
"endif

"bookmarkだけホームディレクトリに保存
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "sでsplit
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  "vでvsplit
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  "fでvimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction

"}}}

"vimfiler {{{

"vimデフォルトのエクスプローラをvimfilerで置き換える
"let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"デフォルトのキーマッピングを変更
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

"}}}

" vim:fdm=marker:ts=2:sts=2:sw=2:
