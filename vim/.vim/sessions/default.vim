let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <expr> <Plug>(coc-snippets-expand-jump) coc#_insert_key('request', 'snippets-expand-jump', 1)
inoremap <silent> <expr> <Plug>(coc-snippets-expand) coc#_insert_key('request', 'snippets-expand', 1)
imap <C-G>c <Plug>CapsLockToggle
inoremap <silent> <Plug>CocRefresh =coc#_complete()
inoremap <silent> <Plug>(peekaboo) :call peekaboo#aboo()
inoremap <silent> <expr> <Plug>delimitMateS-BS delimitMate#WithinEmptyPair() ? "\<Del>" : "\<S-BS>"
inoremap <silent> <Plug>delimitMateBS =delimitMate#BS()
imap <C-G>S <Plug>ISurround
imap <C-G>s <Plug>Isurround
inoremap <silent> <Plug>(fzf-maps-i) :call fzf#vim#maps('i', 0)
inoremap <expr> <Plug>(fzf-complete-buffer-line) fzf#vim#complete#buffer_line()
inoremap <expr> <Plug>(fzf-complete-line) fzf#vim#complete#line()
inoremap <expr> <Plug>(fzf-complete-file-ag) fzf#vim#complete#path('ag -l -g ""')
inoremap <expr> <Plug>(fzf-complete-file) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed 's:^..::'")
inoremap <expr> <Plug>(fzf-complete-path) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -print | sed '1d;s:^..::'")
inoremap <expr> <Plug>(fzf-complete-word) fzf#vim#complete#word()
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
inoremap <silent> <C-E> =UltiSnips#ExpandSnippet()
inoremap <silent> <Plug>NERDCommenterInsert  <BS>:call NERDComment('i', 'insert')
inoremap <C-S> eas
inoremap <C-H> <Left>
inoremap <C-L> <Right>
inoremap <C-K> <Up>
inoremap <C-J> <Down>
imap <C-O> <Plug>CapsLockToggle
inoremap <expr> <C-X><C-L> fzf#vim#complete(fzf#wrap({    'prefix': '^.*$',    'source': 'rg -n ^ --color always',    'options': '--ansi --delimiter : --nth 3..',    'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
imap <C-X><C-J> <Plug>(fzf-complete-file-ag)
imap <C-X><C-F> <Plug>(fzf-complete-path)
inoremap <expr> <C-X><C-K> fzf#vim#complete('cat /usr/share/dict/words')
cnoremap <C-P> =expand("%:p:h") . "/" 
inoremap <silent> <expr> <C-Space> coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\" : "\"
xnoremap <silent>  :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent>  :call UltiSnips#ExpandSnippet()
nnoremap <silent>  :FZF -m
snoremap <silent>  "_c
nnoremap  h
nnoremap 	 gt
nnoremap <NL> j
nnoremap  k
nnoremap  l
map  <Plug>(wildfire-fuel)
snoremap  "_c
noremap  eas
nnoremap <silent>  p :CocListResume
nnoremap <silent>  k :CocPrev
nnoremap <silent>  j :CocNext
nnoremap <silent>  s :CocList -I symbols
nnoremap <silent>  co :CocList outline
nnoremap <silent>  c :CocList commands
nnoremap <silent>  e :CocList extensions
nnoremap <silent>  a :CocList diagnostics
map # <Plug>(incsearch-nohl-#)
map * <Plug>(incsearch-nohl-*)
map ,, <Plug>(easymotion-prefix)
nmap ,ca <Plug>NERDCommenterAltDelims
xmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
xmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
xmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cA <Plug>NERDCommenterAppend
xmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
xmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
xmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
nmap ,c$ <Plug>NERDCommenterToEOL
xmap ,cn <Plug>NERDCommenterNested
nmap ,cn <Plug>NERDCommenterNested
xmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
xmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
xmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
nnoremap ,/ :term
nnoremap <silent> ,\ 1
nnoremap <silent> ,ql l:q
nnoremap <silent> ,qh h:q
nnoremap <silent> ,qk k:q
nnoremap <silent> ,qj j:q
noremap ,bc :bd
noremap ,x :bn
noremap ,z :bp
noremap ,pp "+gP
nnoremap ,go :.Gbrowse
noremap ,gr :Gremove
noremap ,gd :Gvdiff
noremap ,gb :Gblame
noremap ,gs :Gstatus
noremap ,gll :Gpull
noremap ,gsh :Gpush
noremap ,gc :Gcommit
noremap ,ga :Gwrite
noremap ,te :tabe =expand("%:p:h") . "/" 
nnoremap ,e :e =expand("%:p:h") . "/" 
nnoremap ,. :lcd %:p:h
nnoremap ,sx :CloseSession 
nnoremap ,sd :DeleteSession 
nnoremap ,ss :SaveSession 
nnoremap ,so :OpenSession 
nnoremap ,o ok
nnoremap ,4 :set filetype=c
nnoremap ,3 :set filetype=python
nnoremap ,2 :set filetype=go
nnoremap ,1 :set filetype=rust
nnoremap ,hh :help 
nnoremap ,fg! :r !figlet
nnoremap ,rc :e $MYVIMRC
nnoremap ,dp /\(\<\w\+\>\)\_s*\1
nnoremap ,rs :r !
nnoremap ,sr :%s//g<Left><Left>
nnoremap ,sz tK
nnoremap ,sv tH
nnoremap ,sk :set nosplitbelow:split:set splitbelow
nnoremap ,sj :split
nnoremap ,sl :vsplit
nnoremap <silent> ,  :nohlsearch
nnoremap ,N [s
nnoremap ,n ]s
map ,sc :set spell!
nnoremap ,sh :set nosplitright:vsplit:set splitright
nnoremap ,ra :Ranger
nnoremap ,q! :Quickfix!
omap ,	 <Plug>(fzf-maps-o)
xmap ,	 <Plug>(fzf-maps-x)
nmap ,	 <Plug>(fzf-maps-n)
nnoremap <silent> ,fgs :GFiles?
nnoremap <silent> ,fgl :GFiles
nnoremap <silent> ,fgc :Commits
nnoremap <silent> ,fa :Filetypes
nnoremap <silent> ,fp :Helptags
nnoremap <silent> ,fm :Maps
nnoremap <silent> ,fc :Commands
nnoremap <silent> ,fs :Snippets
nnoremap <silent> ,fh :MRU
nnoremap <silent> ,fw :Windows
nnoremap <silent> ,fk :Marks
nnoremap <silent> ,ft :BTags
nnoremap <silent> ,fl :LinesWithPreview
nnoremap <silent> ,ff :Rg
nnoremap <silent> ,fb :Buffers
nnoremap ,qf :Quickfix
nmap ,ac <Plug>(coc-codeaction)
nmap ,a <Plug>(coc-codeaction-selected)
xmap ,a <Plug>(coc-codeaction-selected)
nmap ,sf <Plug>(coc-format-selected)
xmap ,sf <Plug>(coc-format-selected)
nmap ,rn <Plug>(coc-rename)
noremap ,m :SignatureToggleSigns
nnoremap ,g= :GitGutterNextHunk
nnoremap ,g- :GitGutterPrevHunk
nnoremap ,gf :GitGutterFold
nnoremap <silent> ,vfc :Vista finder fzf:coc
nnoremap <silent> ,vff :Vista finder fzf
nnoremap <silent> ,vc :Vista coc
nnoremap <silent> ,vf :Vista focus
nnoremap <silent> ,vt :Vista toc
nnoremap <silent> ,vs :Vista show
nnoremap <silent> ,vv :Vista!!
nnoremap <silent> ,st :Startify
nnoremap ,ch :ColorToggle
map / <Plug>(incsearch-forward)
nnoremap ; :
vmap < <gv
vmap > >gv
map ? <Plug>(incsearch-backward)
nnoremap B 5B
nnoremap H :GitGutterPreviewHunk
vnoremap J :m '>+1gv=gv
nnoremap J 5j
vnoremap K :m '<-2gv=gv
nnoremap K 5k
map N <Plug>(incsaerch-nohl-N)zzzv
nnoremap Q :q
nnoremap R :source $MYVIMRC
xmap S <Plug>VSurround
nnoremap S :w
nnoremap <silent> T :tabnew
nnoremap U :UndotreeToggle
nnoremap W 5w
noremap XX "+x
vnoremap Y "+y
nnoremap Y y$
nnoremap <silent> [= :call signature#marker#Goto("prev", "any",  v:count)
nnoremap <silent> [- :call signature#marker#Goto("prev", "same", v:count)
nnoremap <silent> [sp :call signature#mark#Goto("prev", "spot", "pos")
nnoremap <silent> [lp :call signature#mark#Goto("prev", "line", "pos")
nnoremap <silent> [sa :call signature#mark#Goto("prev", "spot", "alpha")
nnoremap <silent> [la :call signature#mark#Goto("prev", "line", "alpha")
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap \r :call AutoRun()
nnoremap \w :Calendar -view=week -position=here
nnoremap \d :Calendar -view=day -position=here
nnoremap \m :Calendar -view=month -position=here
nnoremap \y :Calendar -view=year -position=here
nnoremap \\ :Calendar -view=year -split=horizontal -position=below -height=12
nnoremap \c :Calendar -view=clock -position=here
nnoremap <silent> ]= :call signature#marker#Goto("next", "any",  v:count)
nnoremap <silent> ]- :call signature#marker#Goto("next", "same", v:count)
nnoremap <silent> ]sp :call signature#mark#Goto("next", "spot", "pos")
nnoremap <silent> ]lp :call signature#mark#Goto("next", "line", "pos")
nnoremap <silent> ]sa :call signature#mark#Goto("next", "spot", "alpha")
nnoremap <silent> ]la :call signature#mark#Goto("next", "line", "alpha")
nmap <silent> ]g <Plug>(coc-diagnostic-next)
omap af <Plug>(coc-funcobj-a)
xmap af <Plug>(coc-funcobj-a)
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nnoremap <silent> dm :call signature#utils#Remove(v:count)
nmap ds <Plug>Dsurround
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
nmap gC <Plug>CapsLockToggle
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gd <Plug>(coc-definition)
map g# <Plug>(incsearch-nohl-g#)
map g* <Plug>(incsearch-nohl-g*)
map g/ <Plug>(incsearch-stay)
nnoremap ga <Plug>(EasyAlign)
xnoremap ga <Plug>(EasyAlign)
nnoremap <silent> m? :call signature#marker#List(v:count, 0)
nnoremap <silent> m/ :call signature#mark#List(0, 0)
nnoremap <silent> m<BS> :call signature#marker#Purge()
nnoremap <silent> m  :call signature#mark#Purge("all")
nnoremap <silent> m- :call signature#mark#Purge("line")
nnoremap <silent> m. :call signature#mark#ToggleAtLine()
nnoremap <silent> m, :call signature#mark#Toggle("next")
nnoremap <silent> m :call signature#utils#Input()
map n <Plug>(incsearch-nohl-n)zzzv
nnoremap q; q:
nnoremap s <Nop>
nnoremap <silent> tt :CocCommand explorer
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nmap zuz <Plug>(FastFoldUpdate)
map zg/ <Plug>(incsearch-easymotion-stay)
map z? <Plug>(incsearch-easymotion-?)
map z/ <Plug>(incsearch-easymotion-/)
vnoremap <silent> <Plug>(coc-explorer-action-v->>) :call coc#rpc#request('doKeymap', ['explorer-action-v->>'])
nnoremap <silent> <Plug>(coc-explorer-action-n->>) :call coc#rpc#request('doKeymap', ['explorer-action-n->>'])
vnoremap <silent> <Plug>(coc-explorer-action-v-<<) :call coc#rpc#request('doKeymap', ['explorer-action-v-<<'])
nnoremap <silent> <Plug>(coc-explorer-action-n-<<) :call coc#rpc#request('doKeymap', ['explorer-action-n-<<'])
vnoremap <silent> <Plug>(coc-explorer-action-v-]c) :call coc#rpc#request('doKeymap', ['explorer-action-v-]c'])
nnoremap <silent> <Plug>(coc-explorer-action-n-]c) :call coc#rpc#request('doKeymap', ['explorer-action-n-]c'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[c) :call coc#rpc#request('doKeymap', ['explorer-action-v-[c'])
nnoremap <silent> <Plug>(coc-explorer-action-n-[c) :call coc#rpc#request('doKeymap', ['explorer-action-n-[c'])
vnoremap <silent> <Plug>(coc-explorer-action-v-]d) :call coc#rpc#request('doKeymap', ['explorer-action-v-]d'])
nnoremap <silent> <Plug>(coc-explorer-action-n-]d) :call coc#rpc#request('doKeymap', ['explorer-action-n-]d'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[d) :call coc#rpc#request('doKeymap', ['explorer-action-v-[d'])
nnoremap <silent> <Plug>(coc-explorer-action-n-[d) :call coc#rpc#request('doKeymap', ['explorer-action-n-[d'])
vnoremap <silent> <Plug>(coc-explorer-action-v-]]) :call coc#rpc#request('doKeymap', ['explorer-action-v-]]'])
nnoremap <silent> <Plug>(coc-explorer-action-n-]]) :call coc#rpc#request('doKeymap', ['explorer-action-n-]]'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[[) :call coc#rpc#request('doKeymap', ['explorer-action-v-[['])
nnoremap <silent> <Plug>(coc-explorer-action-n-[[) :call coc#rpc#request('doKeymap', ['explorer-action-n-[['])
vnoremap <silent> <Plug>(coc-explorer-action-v-gb) :call coc#rpc#request('doKeymap', ['explorer-action-v-gb'])
nnoremap <silent> <Plug>(coc-explorer-action-n-gb) :call coc#rpc#request('doKeymap', ['explorer-action-n-gb'])
vnoremap <silent> <Plug>(coc-explorer-action-v-gf) :call coc#rpc#request('doKeymap', ['explorer-action-v-gf'])
nnoremap <silent> <Plug>(coc-explorer-action-n-gf) :call coc#rpc#request('doKeymap', ['explorer-action-n-gf'])
vnoremap <silent> <Plug>(coc-explorer-action-v-F) :call coc#rpc#request('doKeymap', ['explorer-action-v-F'])
nnoremap <silent> <Plug>(coc-explorer-action-n-F) :call coc#rpc#request('doKeymap', ['explorer-action-n-F'])
vnoremap <silent> <Plug>(coc-explorer-action-v-f) :call coc#rpc#request('doKeymap', ['explorer-action-v-f'])
nnoremap <silent> <Plug>(coc-explorer-action-n-f) :call coc#rpc#request('doKeymap', ['explorer-action-n-f'])
vnoremap <silent> <Plug>(coc-explorer-action-v-gd) :call coc#rpc#request('doKeymap', ['explorer-action-v-gd'])
nnoremap <silent> <Plug>(coc-explorer-action-n-gd) :call coc#rpc#request('doKeymap', ['explorer-action-n-gd'])
vnoremap <silent> <Plug>(coc-explorer-action-v-X) :call coc#rpc#request('doKeymap', ['explorer-action-v-X'])
nnoremap <silent> <Plug>(coc-explorer-action-n-X) :call coc#rpc#request('doKeymap', ['explorer-action-n-X'])
vnoremap <silent> <Plug>(coc-explorer-action-v-q) :call coc#rpc#request('doKeymap', ['explorer-action-v-q'])
nnoremap <silent> <Plug>(coc-explorer-action-n-q) :call coc#rpc#request('doKeymap', ['explorer-action-n-q'])
vnoremap <silent> <Plug>(coc-explorer-action-v-?) :call coc#rpc#request('doKeymap', ['explorer-action-v-?'])
nnoremap <silent> <Plug>(coc-explorer-action-n-?) :call coc#rpc#request('doKeymap', ['explorer-action-n-?'])
vnoremap <silent> <Plug>(coc-explorer-action-v-R) :call coc#rpc#request('doKeymap', ['explorer-action-v-R'])
nnoremap <silent> <Plug>(coc-explorer-action-n-R) :call coc#rpc#request('doKeymap', ['explorer-action-n-R'])
vnoremap <silent> <Plug>(coc-explorer-action-v-.) :call coc#rpc#request('doKeymap', ['explorer-action-v-.'])
nnoremap <silent> <Plug>(coc-explorer-action-n-.) :call coc#rpc#request('doKeymap', ['explorer-action-n-.'])
vnoremap <silent> <Plug>(coc-explorer-action-v-r) :call coc#rpc#request('doKeymap', ['explorer-action-v-r'])
nnoremap <silent> <Plug>(coc-explorer-action-n-r) :call coc#rpc#request('doKeymap', ['explorer-action-n-r'])
vnoremap <silent> <Plug>(coc-explorer-action-v-A) :call coc#rpc#request('doKeymap', ['explorer-action-v-A'])
nnoremap <silent> <Plug>(coc-explorer-action-n-A) :call coc#rpc#request('doKeymap', ['explorer-action-n-A'])
vnoremap <silent> <Plug>(coc-explorer-action-v-a) :call coc#rpc#request('doKeymap', ['explorer-action-v-a'])
nnoremap <silent> <Plug>(coc-explorer-action-n-a) :call coc#rpc#request('doKeymap', ['explorer-action-n-a'])
vnoremap <silent> <Plug>(coc-explorer-action-v-D) :call coc#rpc#request('doKeymap', ['explorer-action-v-D'])
nnoremap <silent> <Plug>(coc-explorer-action-n-D) :call coc#rpc#request('doKeymap', ['explorer-action-n-D'])
vnoremap <silent> <Plug>(coc-explorer-action-v-d) :call coc#rpc#request('doKeymap', ['explorer-action-v-d'])
nnoremap <silent> <Plug>(coc-explorer-action-n-d) :call coc#rpc#request('doKeymap', ['explorer-action-n-d'])
vnoremap <silent> <Plug>(coc-explorer-action-v-p) :call coc#rpc#request('doKeymap', ['explorer-action-v-p'])
nnoremap <silent> <Plug>(coc-explorer-action-n-p) :call coc#rpc#request('doKeymap', ['explorer-action-n-p'])
vnoremap <silent> <Plug>(coc-explorer-action-v-x) :call coc#rpc#request('doKeymap', ['explorer-action-v-x'])
nnoremap <silent> <Plug>(coc-explorer-action-n-x) :call coc#rpc#request('doKeymap', ['explorer-action-n-x'])
vnoremap <silent> <Plug>(coc-explorer-action-v-c) :call coc#rpc#request('doKeymap', ['explorer-action-v-c'])
nnoremap <silent> <Plug>(coc-explorer-action-n-c) :call coc#rpc#request('doKeymap', ['explorer-action-n-c'])
vnoremap <silent> <Plug>(coc-explorer-action-v-Y) :call coc#rpc#request('doKeymap', ['explorer-action-v-Y'])
nnoremap <silent> <Plug>(coc-explorer-action-n-Y) :call coc#rpc#request('doKeymap', ['explorer-action-n-Y'])
vnoremap <silent> <Plug>(coc-explorer-action-v-y) :call coc#rpc#request('doKeymap', ['explorer-action-v-y'])
nnoremap <silent> <Plug>(coc-explorer-action-n-y) :call coc#rpc#request('doKeymap', ['explorer-action-n-y'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[bs]) :call coc#rpc#request('doKeymap', ['explorer-action-v-[bs]'])
nnoremap <silent> <Plug>(coc-explorer-action-n-[bs]) :call coc#rpc#request('doKeymap', ['explorer-action-n-[bs]'])
vnoremap <silent> <Plug>(coc-explorer-action-v-t) :call coc#rpc#request('doKeymap', ['explorer-action-v-t'])
nnoremap <silent> <Plug>(coc-explorer-action-n-t) :call coc#rpc#request('doKeymap', ['explorer-action-n-t'])
vnoremap <silent> <Plug>(coc-explorer-action-v-E) :call coc#rpc#request('doKeymap', ['explorer-action-v-E'])
nnoremap <silent> <Plug>(coc-explorer-action-n-E) :call coc#rpc#request('doKeymap', ['explorer-action-n-E'])
vnoremap <silent> <Plug>(coc-explorer-action-v-e) :call coc#rpc#request('doKeymap', ['explorer-action-v-e'])
nnoremap <silent> <Plug>(coc-explorer-action-n-e) :call coc#rpc#request('doKeymap', ['explorer-action-n-e'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[cr]) :call coc#rpc#request('doKeymap', ['explorer-action-v-[cr]'])
nnoremap <silent> <Plug>(coc-explorer-action-n-[cr]) :call coc#rpc#request('doKeymap', ['explorer-action-n-[cr]'])
nnoremap <silent> <Plug>(coc-explorer-action-n-o) :call coc#rpc#request('doKeymap', ['explorer-action-n-o'])
vnoremap <silent> <Plug>(coc-explorer-action-v-gh) :call coc#rpc#request('doKeymap', ['explorer-action-v-gh'])
nnoremap <silent> <Plug>(coc-explorer-action-n-gh) :call coc#rpc#request('doKeymap', ['explorer-action-n-gh'])
vnoremap <silent> <Plug>(coc-explorer-action-v-gl) :call coc#rpc#request('doKeymap', ['explorer-action-v-gl'])
nnoremap <silent> <Plug>(coc-explorer-action-n-gl) :call coc#rpc#request('doKeymap', ['explorer-action-n-gl'])
vnoremap <silent> <Plug>(coc-explorer-action-v-K) :call coc#rpc#request('doKeymap', ['explorer-action-v-K'])
nnoremap <silent> <Plug>(coc-explorer-action-n-K) :call coc#rpc#request('doKeymap', ['explorer-action-n-K'])
vnoremap <silent> <Plug>(coc-explorer-action-v-J) :call coc#rpc#request('doKeymap', ['explorer-action-v-J'])
nnoremap <silent> <Plug>(coc-explorer-action-n-J) :call coc#rpc#request('doKeymap', ['explorer-action-n-J'])
vnoremap <silent> <Plug>(coc-explorer-action-v-l) :call coc#rpc#request('doKeymap', ['explorer-action-v-l'])
nnoremap <silent> <Plug>(coc-explorer-action-n-l) :call coc#rpc#request('doKeymap', ['explorer-action-n-l'])
vnoremap <silent> <Plug>(coc-explorer-action-v-h) :call coc#rpc#request('doKeymap', ['explorer-action-v-h'])
nnoremap <silent> <Plug>(coc-explorer-action-n-h) :call coc#rpc#request('doKeymap', ['explorer-action-n-h'])
vnoremap <silent> <Plug>(coc-explorer-action-v-[tab]) :call coc#rpc#request('doKeymap', ['explorer-action-v-[tab]'])
nnoremap <silent> <Plug>(coc-explorer-action-n-[tab]) :call coc#rpc#request('doKeymap', ['explorer-action-n-[tab]'])
vnoremap <silent> <Plug>(coc-explorer-action-v-*) :call coc#rpc#request('doKeymap', ['explorer-action-v-*'])
nnoremap <silent> <Plug>(coc-explorer-action-n-*) :call coc#rpc#request('doKeymap', ['explorer-action-n-*'])
nnoremap <silent> <Plug>(coc-explorer-action-n-j) :call coc#rpc#request('doKeymap', ['explorer-action-n-j'])
nnoremap <silent> <Plug>(coc-explorer-action-n-k) :call coc#rpc#request('doKeymap', ['explorer-action-n-k'])
vnoremap <silent> <Plug>(coc-snippets-select) :call coc#rpc#notify('doKeymap', ['snippets-select'])
nnoremap <SNR>181_: :=v:count ? v:count : ''
snoremap <silent> <BS> "_c
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
nnoremap <silent> <Plug>(vimshell_create) :VimShellCreate
nnoremap <silent> <Plug>(vimshell_switch) :VimShell
xnoremap <Plug>ColorFgBg :ColorSwapFgBg
nnoremap <Plug>ColorFgBg :ColorSwapFgBg
xnoremap <Plug>ColorContrast :ColorContrast
nnoremap <Plug>ColorContrast :ColorContrast
xnoremap <Plug>Colorizer :ColorHighlight
nnoremap <Plug>Colorizer :ColorToggle
onoremap <silent> <Plug>(coc-funcobj-a) :call coc#rpc#request('selectFunction', [v:false, ''])
onoremap <silent> <Plug>(coc-funcobj-i) :call coc#rpc#request('selectFunction', [v:true, ''])
vnoremap <silent> <Plug>(coc-funcobj-a) :call coc#rpc#request('selectFunction', [v:false, visualmode()])
vnoremap <silent> <Plug>(coc-funcobj-i) :call coc#rpc#request('selectFunction', [v:true, visualmode()])
nnoremap <silent> <Plug>(coc-cursors-position) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'position', 'n'])
nnoremap <silent> <Plug>(coc-cursors-word) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'word', 'n'])
vnoremap <silent> <Plug>(coc-cursors-range) :call coc#rpc#request('cursorsSelect', [bufnr('%'), 'range', visualmode()])
nnoremap <Plug>(coc-refactor) :call       CocActionAsync('refactor')
nnoremap <Plug>(coc-command-repeat) :call       CocAction('repeatCommand')
nnoremap <Plug>(coc-float-jump) :call       coc#util#float_jump()
nnoremap <Plug>(coc-float-hide) :call       coc#util#float_hide()
nnoremap <Plug>(coc-fix-current) :call       CocActionAsync('doQuickfix')
nnoremap <Plug>(coc-openlink) :call       CocActionAsync('openLink')
nnoremap <Plug>(coc-references) :call       CocAction('jumpReferences')
nnoremap <Plug>(coc-type-definition) :call       CocAction('jumpTypeDefinition')
nnoremap <Plug>(coc-implementation) :call       CocAction('jumpImplementation')
nnoremap <Plug>(coc-declaration) :call       CocAction('jumpDeclaration')
nnoremap <Plug>(coc-definition) :call       CocAction('jumpDefinition')
nnoremap <Plug>(coc-diagnostic-prev-error) :call       CocActionAsync('diagnosticPrevious', 'error')
nnoremap <Plug>(coc-diagnostic-next-error) :call       CocActionAsync('diagnosticNext',     'error')
nnoremap <Plug>(coc-diagnostic-prev) :call       CocActionAsync('diagnosticPrevious')
nnoremap <Plug>(coc-diagnostic-next) :call       CocActionAsync('diagnosticNext')
nnoremap <Plug>(coc-diagnostic-info) :call       CocActionAsync('diagnosticInfo')
nnoremap <Plug>(coc-format) :call       CocActionAsync('format')
nnoremap <Plug>(coc-rename) :call       CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction) :call       CocActionAsync('codeAction',         '')
vnoremap <Plug>(coc-codeaction-selected) :call       CocActionAsync('codeAction',         visualmode())
vnoremap <Plug>(coc-format-selected) :call       CocActionAsync('formatSelected',     visualmode())
nnoremap <Plug>(coc-codelens-action) :call       CocActionAsync('codeLensAction')
nnoremap <Plug>(coc-range-select) :call       CocAction('rangeSelect',     '', v:true)
vnoremap <Plug>(coc-range-select-backward) :call       CocAction('rangeSelect',     visualmode(), v:false)
vnoremap <Plug>(coc-range-select) :call       CocAction('rangeSelect',     visualmode(), v:true)
xnoremap <silent> <Plug>(peekaboo) :call peekaboo#aboo()
nnoremap <silent> <Plug>(peekaboo) :call peekaboo#aboo()
nnoremap <silent> <Plug>(FastFoldUpdate) :FastFoldUpdate!
onoremap <silent> <Plug>(wildfire-quick-select) :call wildfire#QuickSelect(['ip', 'i)', 'i]', 'i}', 'i''', 'i"', 'it'])
nnoremap <silent> <Plug>(wildfire-quick-select) :call wildfire#QuickSelect(['ip', 'i)', 'i]', 'i}', 'i''', 'i"', 'it'])
vnoremap <silent> <Plug>(wildfire-fuel) :call wildfire#Fuel(v:count1)
onoremap <silent> <Plug>(wildfire-fuel) :call wildfire#Start(v:count1, ['ip', 'i)', 'i]', 'i}', 'i''', 'i"', 'it'])
nnoremap <silent> <Plug>(wildfire-fuel) :call wildfire#Start(v:count1, ['ip', 'i)', 'i]', 'i}', 'i''', 'i"', 'it'])
vnoremap <silent> <Plug>(wildfire-water) :call wildfire#Water(v:count1)
nnoremap <silent> <Plug>SurroundRepeat .
nnoremap <silent> <Plug>(anzu-mode) :call anzu#mode#start(@/, "", "", "")
nnoremap <silent> <Plug>(anzu-mode-N) :call anzu#mode#start(@/, "N", "", "")
nnoremap <silent> <Plug>(anzu-mode-n) :call anzu#mode#start(@/, "n", "", "")
noremap <silent> <expr> <Plug>(anzu-echohl_search_status) (mode() =~ '[iR]' ? "\" : "") . ":call anzu#echohl_search_status()\"
nnoremap <silent> <Plug>(anzu-smart-sign-matchline) :AnzuSignMatchLine
nnoremap <silent> <Plug>(anzu-clear-sign-matchline) :AnzuClearSignMatchLine
nnoremap <silent> <Plug>(anzu-sign-matchline) :AnzuSignMatchLine!
nnoremap <silent> <expr> <Plug>(anzu-jump-sharp) ":normal! *N\" . anzu#mapexpr_jump(v:count, '\<Plug>(anzu-sharp)')
nnoremap <silent> <expr> <Plug>(anzu-jump-star) ":normal! *N\" . anzu#mapexpr_jump(v:count, '\<Plug>(anzu-star)')
nnoremap <silent> <expr> <Plug>(anzu-jump-N) anzu#mapexpr_jump(v:count, '\<Plug>(anzu-N)')
nnoremap <silent> <expr> <Plug>(anzu-jump-n) anzu#mapexpr_jump(v:count, '\<Plug>(anzu-n)')
nnoremap <silent> <expr> <Plug>(anzu-jump) anzu#mapexpr_jump(v:count, '')
nmap <silent> <Plug>(anzu-N-with-echo) <Plug>(anzu-N)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-n-with-echo) <Plug>(anzu-n)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-sharp-with-echo) <Plug>(anzu-sharp)<Plug>(anzu-echo-search-status)
nmap <silent> <Plug>(anzu-star-with-echo) <Plug>(anzu-star)<Plug>(anzu-echo-search-status)
nnoremap <silent> <Plug>(anzu-clear-search-cache) :AnzuClearSearchCache
nnoremap <silent> <Plug>(anzu-clear-search-status) :AnzuClearSearchStatus
nmap <silent> <Plug>(anzu-update-search-status-with-echo) <Plug>(anzu-update-search-status)<Plug>(anzu-echo-search-status)
nnoremap <silent> <Plug>(anzu-update-search-status) :AnzuUpdateSearchStatus
nnoremap <silent> <Plug>(anzu-echo-search-status) :call anzu#echohl_search_status()
noremap <Plug>(_incsearch-g#) g#
noremap <Plug>(_incsearch-g*) g*
noremap <Plug>(_incsearch-#) #
noremap <Plug>(_incsearch-*) *
noremap <expr> <Plug>(_incsearch-N) g:incsearch#consistent_n_direction && !v:searchforward ? 'n' : 'N'
noremap <expr> <Plug>(_incsearch-n) g:incsearch#consistent_n_direction && !v:searchforward ? 'N' : 'n'
map <Plug>(incsearch-nohl-g#) <Plug>(incsearch-nohl)<Plug>(_incsearch-g#)
map <Plug>(incsearch-nohl-g*) <Plug>(incsearch-nohl)<Plug>(_incsearch-g*)
map <Plug>(incsearch-nohl-#) <Plug>(incsearch-nohl)<Plug>(_incsearch-#)
map <Plug>(incsearch-nohl-*) <Plug>(incsearch-nohl)<Plug>(_incsearch-*)
map <Plug>(incsearch-nohl-N) <Plug>(incsearch-nohl)<Plug>(_incsearch-N)
map <Plug>(incsearch-nohl-n) <Plug>(incsearch-nohl)<Plug>(_incsearch-n)
noremap <expr> <Plug>(incsearch-nohl2) incsearch#autocmd#auto_nohlsearch(2)
noremap <expr> <Plug>(incsearch-nohl0) incsearch#autocmd#auto_nohlsearch(0)
noremap <expr> <Plug>(incsearch-nohl) incsearch#autocmd#auto_nohlsearch(1)
noremap <silent> <expr> <Plug>(incsearch-stay) incsearch#go({'command': '/', 'is_stay': 1})
noremap <silent> <expr> <Plug>(incsearch-backward) incsearch#go({'command': '?'})
noremap <silent> <expr> <Plug>(incsearch-forward) incsearch#go({'command': '/'})
map <silent> <Plug>(easymotion-prefix)N <Plug>(easymotion-N)
map <silent> <Plug>(easymotion-prefix)n <Plug>(easymotion-n)
map <silent> <Plug>(easymotion-prefix)k <Plug>(easymotion-k)
map <silent> <Plug>(easymotion-prefix)j <Plug>(easymotion-j)
map <silent> <Plug>(easymotion-prefix)gE <Plug>(easymotion-gE)
map <silent> <Plug>(easymotion-prefix)ge <Plug>(easymotion-ge)
map <silent> <Plug>(easymotion-prefix)E <Plug>(easymotion-E)
map <silent> <Plug>(easymotion-prefix)e <Plug>(easymotion-e)
map <silent> <Plug>(easymotion-prefix)B <Plug>(easymotion-B)
map <silent> <Plug>(easymotion-prefix)b <Plug>(easymotion-b)
map <silent> <Plug>(easymotion-prefix)W <Plug>(easymotion-W)
map <silent> <Plug>(easymotion-prefix)w <Plug>(easymotion-w)
map <silent> <Plug>(easymotion-prefix)T <Plug>(easymotion-T)
map <silent> <Plug>(easymotion-prefix)t <Plug>(easymotion-t)
map <silent> <Plug>(easymotion-prefix)s <Plug>(easymotion-s)
map <silent> <Plug>(easymotion-prefix)F <Plug>(easymotion-F)
map <silent> <Plug>(easymotion-prefix)f <Plug>(easymotion-f)
xnoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(1)
nnoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
snoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
onoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
noremap <silent> <Plug>(easymotion-dotrepeat) :call EasyMotion#DotRepeat()
xnoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(1)
nnoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
snoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
onoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
xnoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(1,1)
nnoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
snoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
onoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
xnoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(1,0)
nnoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
snoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
onoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
xnoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(1,0)
nnoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
snoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
onoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
xnoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(1,0)
nnoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
snoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
onoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
xnoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(1,2)
nnoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
snoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
onoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
xnoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(1,2)
nnoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
snoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
onoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
xnoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(1,1)
nnoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
snoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
onoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
xnoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(1,1)
nnoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
snoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
onoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
xnoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(1,0)
nnoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
snoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
onoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
xnoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(1,1)
nnoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
snoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
onoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
xnoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(1,2)
nnoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
snoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
onoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
xnoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(1,2)
nnoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
snoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
onoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
xnoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(1,0,1)
nnoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
snoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
onoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
xnoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(1,0,0)
nnoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
snoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
onoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
xnoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(1,2,0)
nnoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
snoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
onoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
xnoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(1,1,1)
nnoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
snoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
onoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
xnoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(1,1,0)
nnoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
snoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
onoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
xnoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(1,0)
nnoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
snoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
onoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
xnoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(1,1)
nnoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
snoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
onoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
xnoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(1,0)
nnoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
snoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
onoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
xnoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(1,1)
nnoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
snoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
onoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
xnoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(1,0)
nnoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
snoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
onoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
xnoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(1,2)
nnoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
snoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
onoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
xnoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(1,2)
nnoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
snoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
onoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
xnoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(1,2)
nnoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
snoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
onoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
xnoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(1,1)
nnoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
snoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
onoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(1,1)
nnoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
snoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
onoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
xnoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(1,0)
nnoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
snoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
onoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
xnoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(1,2)
nnoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
snoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
onoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(1,0)
nnoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
snoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
onoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
xnoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(1,1)
nnoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
snoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
onoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
xnoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(1,0)
nnoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
snoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
onoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
xnoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(1,2)
nnoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
snoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
onoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(1,0)
nnoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
snoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
onoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
xnoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(1,1)
nnoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
snoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
onoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(1,1)
nnoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
snoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
onoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(1,2)
nnoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
snoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
onoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
xnoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(1,0)
nnoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
snoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
onoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
xnoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(1,2)
nnoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
snoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
onoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(1,2)
nnoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
snoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
onoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
xnoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(1,1)
nnoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
snoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
onoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
xnoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(1,0)
nnoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
snoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
onoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
xnoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(1,2)
nnoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
snoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
onoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
xnoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(1,1)
nnoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
snoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
onoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
nnoremap <silent> <Plug>(easymotion-overwin-w) :call EasyMotion#overwin#w()
nnoremap <silent> <Plug>(easymotion-overwin-line) :call EasyMotion#overwin#line()
nnoremap <silent> <Plug>(easymotion-overwin-f2) :call EasyMotion#OverwinF(2)
nnoremap <silent> <Plug>(easymotion-overwin-f) :call EasyMotion#OverwinF(1)
xnoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
snoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
onoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
xnoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,1,0)
nnoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
snoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
onoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
xnoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,1,0)
nnoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
snoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
onoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
xnoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,1,2)
nnoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
snoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
onoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
xnoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,1,0)
nnoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
snoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
onoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
xnoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,1,0)
nnoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
snoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
onoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
xnoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,1,0)
nnoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
snoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
onoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
xnoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,1,0)
nnoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
snoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
onoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
xnoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
xnoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,1,0)
nnoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
snoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
onoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
xnoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,1,1)
nnoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
snoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
onoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
xnoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,1,0)
nnoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
snoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
onoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
xnoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,1,0)
nnoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
snoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
onoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
xnoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
snoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
onoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
xnoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
snoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
onoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,1,0)
nnoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
snoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
onoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
xnoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,1,0)
nnoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
snoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
onoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
xnoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
xnoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,1,1)
nnoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
snoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
onoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
xnoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,1,1)
nnoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
snoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
onoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
xnoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
xnoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
snoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
onoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
xnoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,1,2)
nnoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
snoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
onoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
xnoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,1,1)
nnoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
snoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
onoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
xnoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,1,2)
nnoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
snoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
onoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
xnoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
snoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
onoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
xnoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,1,2)
nnoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
snoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
onoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
xnoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,1,1)
nnoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
snoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
onoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
xnoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,1,2)
nnoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
snoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
onoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
xnoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,1,1)
nnoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
snoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
onoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
xnoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
xnoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,1,1)
nnoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
snoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
onoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
xnoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
xnoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,1,1)
nnoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
snoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
onoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
xnoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,1,0)
nnoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
snoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
onoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
onoremap <silent> <Plug>(fzf-maps-o) :call fzf#vim#maps('o', 0)
xnoremap <silent> <Plug>(fzf-maps-x) :call fzf#vim#maps('x', 0)
nnoremap <silent> <Plug>(fzf-maps-n) :call fzf#vim#maps('n', 0)
nnoremap <silent> <Plug>(startify-open-buffers) :call startify#open_buffers()
snoremap <C-R> "_c
snoremap <silent> <C-H> "_c
snoremap <silent> <Del> "_c
xmap <BS> <Plug>(wildfire-water)
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
xnoremap <silent> <C-E> :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent> <C-E> :call UltiSnips#ExpandSnippet()
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nnoremap <silent> <Plug>GitGutterPreviewHunk :call gitgutter#utility#warn('please change your map <Plug>GitGutterPreviewHunk to <Plug>(GitGutterPreviewHunk)')
nnoremap <silent> <Plug>(GitGutterPreviewHunk) :GitGutterPreviewHunk
nnoremap <silent> <Plug>GitGutterUndoHunk :call gitgutter#utility#warn('please change your map <Plug>GitGutterUndoHunk to <Plug>(GitGutterUndoHunk)')
nnoremap <silent> <Plug>(GitGutterUndoHunk) :GitGutterUndoHunk
nnoremap <silent> <Plug>GitGutterStageHunk :call gitgutter#utility#warn('please change your map <Plug>GitGutterStageHunk to <Plug>(GitGutterStageHunk)')
nnoremap <silent> <Plug>(GitGutterStageHunk) :GitGutterStageHunk
xnoremap <silent> <Plug>GitGutterStageHunk :call gitgutter#utility#warn('please change your map <Plug>GitGutterStageHunk to <Plug>(GitGutterStageHunk)')
xnoremap <silent> <Plug>(GitGutterStageHunk) :GitGutterStageHunk
nnoremap <silent> <expr> <Plug>GitGutterPrevHunk &diff ? '[c' : ":\call gitgutter#utility#warn('please change your map \<Plug>GitGutterPrevHunk to \<Plug>(GitGutterPrevHunk)')\"
nnoremap <silent> <expr> <Plug>(GitGutterPrevHunk) &diff ? '[c' : ":\execute v:count1 . 'GitGutterPrevHunk'\"
nnoremap <silent> <expr> <Plug>GitGutterNextHunk &diff ? ']c' : ":\call gitgutter#utility#warn('please change your map \<Plug>GitGutterNextHunk to \<Plug>(GitGutterNextHunk)')\"
nnoremap <silent> <expr> <Plug>(GitGutterNextHunk) &diff ? ']c' : ":\execute v:count1 . 'GitGutterNextHunk'\"
xnoremap <silent> <Plug>(GitGutterTextObjectOuterVisual) :call gitgutter#hunk#text_object(0)
xnoremap <silent> <Plug>(GitGutterTextObjectInnerVisual) :call gitgutter#hunk#text_object(1)
onoremap <silent> <Plug>(GitGutterTextObjectOuterPending) :call gitgutter#hunk#text_object(0)
onoremap <silent> <Plug>(GitGutterTextObjectInnerPending) :call gitgutter#hunk#text_object(1)
nnoremap <S-Tab> gT
nnoremap <Right> :vertical resize +5
nnoremap <Left> :vertical resize -5
nnoremap <Down> :res -5
nnoremap <Up> :res +5
nnoremap <C-L> l
nnoremap <C-H> h
nnoremap <C-K> k
nnoremap <C-J> j
noremap <C-S> eas
nnoremap <silent> <C-F> :FZF -m
inoremap <silent>  =UltiSnips#ExpandSnippet()
imap c <Plug>CapsLockToggle
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap  <Left>
inoremap <NL> <Down>
inoremap  <Up>
inoremap  <Right>
inoremap <expr>  pumvisible() ? "\" : "\u\"
imap  <Plug>CapsLockToggle
cnoremap  =expand("%:p:h") . "/" 
inoremap  eas
inoremap <expr>  fzf#vim#complete(fzf#wrap({    'prefix': '^.*$',    'source': 'rg -n ^ --color always',    'options': '--ansi --delimiter : --nth 3..',    'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
imap <NL> <Plug>(fzf-complete-file-ag)
imap  <Plug>(fzf-complete-path)
inoremap <expr>  fzf#vim#complete('cat /usr/share/dict/words')
cabbr mans ManS
cabbr man Man
cnoreabbr Qall qall
cnoreabbr Q q
cnoreabbr W w
cnoreabbr WQ wq
cnoreabbr wQ wq
cnoreabbr Wa wa
cnoreabbr Wq wq
cnoreabbr Qall! qall!
cnoreabbr Q! q!
cnoreabbr W! w!
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set autoread
set background=dark
set backspace=indent,eol,start
set backupcopy=yes
set backupdir=~/.cache/vim/backup//
set binary
set cmdheight=2
set directory=~/.cache/vim/swap//
set expandtab
set fileencodings=utf-8
set fileformats=unix,dos,mac
set foldclose=all
set formatoptions=q
set grepprg=rg\ --vimgrep
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=en
set hidden
set hlsearch
set ignorecase
set incsearch
set keywordprg=:CheatPager!
set laststatus=2
set lazyredraw
set listchars=tab:⇄\ ,trail:␣
set modelines=10
set mousemodel=popup
set pyxversion=3
set regexpengine=1
set ruler
set runtimepath=~/.config/coc/extensions/node_modules/coc-explorer,~/.vim,~/.vim/plugged/ranger.vim,~/.vim/plugged/vim-airline,~/.vim/plugged/vim-airline-themes,~/.vim/plugged/vim-misc,~/.vim/plugged/vim-session,~/.vim/plugged/vim-gitgutter,~/.vim/plugged/vim-fugitive,~/.vim/plugged/vim-gitignore,~/.vim/plugged/nerdcommenter,~/.vim/plugged/ultisnips,~/.vim/plugged/vim-snippets,~/.vim/plugged/vista.vim,~/.vim/plugged/vim-gutentags,~/.vim/plugged/vim-devicons,~/.vim/plugged/vim-startify,~/.vim/plugged/CSApprox,~/.vim/plugged/oceanic-next,~/.vim/plugged/vim-material,~/.vim/plugged/fzf.vim,~/.vim/plugged/vim-easymotion,~/.vim/plugged/incsearch.vim,~/.vim/plugged/incsearch-fuzzy.vim,~/.vim/plugged/incsearch-easymotion.vim,~/.vim/plugged/vim-anzu,~/.vim/plugged/vim-repeat,~/.vim/plugged/vim-surround,~/.vim/plugged/delimitMate,~/.vim/plugged/vim-better-whitespace,~/.vim/plugged/indentLine,~/.vim/plugged/rainbow,~/.vim/plugged/vim-easy-align,~/.vim/plugged/vim-barbaric,~/.vim/plugged/wildfire.vim,~/.vim/plugged/tabular,~/.vim/plugged/FastFold,~/.vim/plugged/undotree,~/.vim/plugged/vim-peekaboo,~/.vim/plugged/syntastic,~/.vim/plugged/vim-polyglot,~/.vim/plugged/neoformat,~/.vim/plugged/coc.nvim,~/.vim/plugged/vim-json,~/.vim/plugged/vim-python-pep8-indent,~/.vim/plugged/vim-cpp-enhanced-highlight,~/.vim/plugged/splitjoin.vim,~/.vim/plugged/vim-racer,~/.vim/plugged/vim-javascript,~/.vim/plugged/javascript-libraries-syntax.vim,~/.vim/plugged/Colorizer,~/.vim/plugged/vim-css3-syntax,~/.vim/plugged/vim-eunuch,~/.vim/plugged/vim-signature,~/.vim/plugged/split-manpage.vim,~/.vim/plugged/vim-capslock,~/.vim/plugged/vim-wakatime,~/.vim/plugged/cheat.sh-vim,~/.vim/plugged/vimproc.vim,~/.vim/plugged/vimshell.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim82,/usr/share/vim/vimfiles/after,~/.vim/plugged/ultisnips/after,~/.vim/plugged/CSApprox/after,~/.vim/plugged/oceanic-next/after,~/.vim/plugged/indentLine/after,~/.vim/plugged/tabular/after,~/.vim/plugged/vim-polyglot/after,~/.vim/plugged/vim-cpp-enhanced-highlight/after,~/.vim/plugged/vim-javascript/after,~/.vim/plugged/javascript-libraries-syntax.vim/after,~/.vim/plugged/vim-css3-syntax/after,~/.vim/plugged/vim-signature/after,~/.vim/after
set scrolloff=5
set shiftwidth=4
set shortmess=filnxtToOScI
set showcmd
set noshowmode
set showtabline=2
set smartcase
set smartindent
set softtabstop=4
set splitbelow
set splitright
set statusline=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%{coc#status()}%{get(b:,'coc_current_function','')}%{anzu#search_status()}%{NearestMethodOrFunction()}%#warningmsg#%{SyntasticStatuslineFlag()}%*%{gutentags#statusline()}
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set noswapfile
set tabline=%!airline#extensions#tabline#get()
set tabstop=4
set termguicolors
set notimeout
set title
set titlestring=%F
set ttimeoutlen=0
set undodir=~/.config/vim/.undodir
set undofile
set updatetime=100
set viewoptions=cursor,folds,slash,unix
set wildignore=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmenu
set wildmode=list:longest,list:full
set nowritebackup
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd .gitignore
edit ~/dotfiles/.gitignore
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
imap <buffer> <expr> <C-R> peekaboo#peek(1, "\",  0)
imap <buffer> <silent> <C-G>g <Plug>delimitMateJumpMany
imap <buffer> <S-BS> <Plug>delimitMateS-BS
imap <buffer> <BS> <Plug>delimitMateBS
xmap <buffer> <expr> " peekaboo#peek(v:count1, '"',  1)
nmap <buffer> <expr> " peekaboo#peek(v:count1, '"',  0)
nmap <buffer> <expr> @ peekaboo#peek(v:count1, '@', 0)
imap <buffer> <silent> g <Plug>delimitMateJumpMany
imap <buffer> <expr>  peekaboo#peek(1, "\",  0)
imap <buffer> " <Plug>delimitMate"
imap <buffer> ' <Plug>delimitMate'
imap <buffer> ( <Plug>delimitMate(
imap <buffer> ) <Plug>delimitMate)
imap <buffer> [ <Plug>delimitMate[
imap <buffer> ] <Plug>delimitMate]
imap <buffer> ` <Plug>delimitMate`
imap <buffer> { <Plug>delimitMate{
imap <buffer> } <Plug>delimitMate}
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal binary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=#%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
set conceallevel=1
setlocal conceallevel=2
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
set cursorcolumn
setlocal cursorcolumn
set cursorline
setlocal cursorline
set cursorlineopt=screenline,number
setlocal cursorlineopt=screenline,number
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'gitignore'
setlocal filetype=gitignore
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=99
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=q
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetGitignoreIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
set list
setlocal list
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=4
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
set signcolumn=yes
setlocal signcolumn=yes
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'gitignore'
setlocal syntax=gitignore
endif
setlocal tabstop=4
setlocal tagcase=
setlocal tagfunc=
setlocal tags=~/dotfiles/tags,./tags,./TAGS,tags,TAGS
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 4 - ((3 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 011|
tabnext 1
badd +0 ~/dotfiles/.gitignore
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOScI
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
