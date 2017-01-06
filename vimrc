set nocompatible
set background=dark
set t_Co=256
syntax on
set encoding=utf-8
set nowrap

set hlsearch "highligh search patern
set nrformats=octal,hex,alpha "autoincrement numbers

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
autocmd Filetype c setlocal      expandtab tabstop=4 shiftwidth=4

au BufRead,BufNewFile *.sco setfiletype python
au BufRead,BufNewFile *.dox setfiletype Doxygen

"******************************************************************************
"IDENTATION
"******************************************************************************

set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set copyindent
set smartindent


" General design
colorscheme trusty
"
set list
set listchars=eol:↲,tab:›—,trail:␣,extends:▶,precedes:◀
set colorcolumn=80

set number " display line numbers
set autoindent
set copyindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set fillchars+=stl:\ ,stlnc:\

"******************************************************************************
"C CODE
""*****************************************************************************
set cinkeys=0{,0},0),o,O,!^F
set cino=g0,Ls,N-s,(s,U1,m1,j1,J1,#1,l1

" *****************************************************************************
" FOLDING AND NERDTREE
set foldmethod=marker
let NERDTreeIgnore=['\.o$', '\~$']


"******************************************************************************
" AIRLINE
" *****************************************************************************
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
 "unicode symbols
 let g:airline_left_sep = '»'
 let g:airline_left_sep = '▶'
 let g:airline_right_sep = '«'
 let g:airline_right_sep = '◀'
 let g:airline_symbols.linenr = '␊'
 let g:airline_symbols.linenr = '␤'
 let g:airline_symbols.linenr = '¶'
 let g:airline_symbols.branch = '⎇'
 let g:airline_symbols.paste = 'ρ'
 let g:airline_symbols.paste = 'Þ'
 let g:airline_symbols.paste = '∥'
 let g:airline_symbols.whitespace = 'Ξ'
 let g:airline_symbols.readonly = 'Ξ'
 let g:airline_symbols.crypt = 'Ξ'

" *****************************************************************************
" Set the cmd file that will be execute with the maps
" ctrl+b+t ctrl+b+d
"let build_file = "Build_spc560_multi516.cmd"
let build_file = "Build_rh850_multi614.cmd"
map <C-b>d :exe "!start cmd /k ".build_file."  debug"<RETURN>
map <C-b>t :exe "!start cmd /k ".build_file."  target"<RETURN>
map <C-b>c :exe "!start cmd /k ".build_file."  clean"<RETURN>
map <C-b>l :e .\_makelog.log<RETURN>

nnoremap <F10> <C-w><C-o>
" *****************************************************************************
"bufferline"
let g:bufferline_modified = '*0'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled=1

" Show just the filename
let g:airline#extensions#tabline#fnamemod=':t'

" enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tagbar#enabled = 1

set laststatus=2

" *****************************************************************************
" Remap key for quick navigation
map <F5> <ESC>:NERDTreeToggle<RETURN>
map <F8> <ESC>:TagbarToggle<RETURN>
map <F12> :bd<RETURN>
map <F2> :bp<RETURN>
map <F3> :bn<RETURN>
map <F6> [m
map <F7> ]m
:noremap <F4> :set hlsearch! hlsearch?<CR>
nmap ,w :exec FixWhitespaces()<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" ****************************************************************************
" TAGS
" ****************************************************************************
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" *****************************************************************************
function! CountDiffs()
    let winview = winsaveview() 
    let num_diffs = 0
    if &diff
        let pos = getpos(".")
        keepj sil exe 'normal! G'
        let lnum = 1
        let moved = 1
        while moved
            let startl = line(".")
            keepj sil exe 'normal! [c'
            let moved = line(".") - startl
            if moved
                let num_diffs+=1
            endif
        endwhile
        call winrestview(winview)
        call setpos(".",pos)
    endif
    return num_diffs
endfunction

" *****************************************************************************
" Show new window with the differences with the HEAD version of this file
nnoremap <C-F11> <C-w><C-o>:exec DiffWithSvn()<CR>
function DiffWithSvn()
    :vnew | r !svn cat #
    :setlocal nomodified readonly buftype=nofile nowrap winwidth=1
    :windo diffthis
endfunction

" *****************************************************************************
" Show information of the last commit done (SVN)
nnoremap <C-b>b :Blame<CR>
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap <F11> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

" *****************************************************************************
" Show new window with the pclint errors
nnoremap <C-P>l <C-w><C-o>:exec Pclint()<CR>
function Pclint()
    :new | r !..\tools\lint\lint-nt.exe +v -u +e900 -i..\tools\lint std/au-misra.lnt generic.lnt std/rh850_multi614.lnt -DTGT_RH850_MULTI614 -DLEAR_OS_USED -DAUTOSAR_OS_NOT_USED -DFBL_VERSION -DADC_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -DCAN_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -DGPT_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -DLIN_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -DPWM_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -DSPI_INTERRUPT_TYPE=MCAL_ISR_TYPE_NONE -Dbsw/comms/generated out\includes.lnt #
    :set syntax=pclint
    :setlocal nomodified readonly buftype=nofile nowrap winwidth=1
    :setlocal noswapfile
    :setlocal bufhidden=hide
    :setlocal nobuflisted
endfunction

" *****************************************************************************
" ASTYLE options
nnoremap <C-a>s <C-w><C-o>:exec AstyleFile()<CR>
function AstyleFile()
    :!astyle %  --style=otbs -s4 -p -k3 -W3 -xe -j -Oo -xC80
    :e
    :vnew | e #.orig
    :windo diffthis
endfunction

nnoremap <C-a>p <C-w><C-o>:exec AstylePreview()<CR>
function AstylePreview()
    :silent !cp % .temp_astyle.c
    :silent !astyle .temp_astyle.c  --style=otbs -s4 -p -k3 -W3 -xe -j -Oo -xC80 -n
    :e
    :vnew | e .temp_astyle.c
    :setlocal nomodified readonly buftype=nofile nowrap winwidth=1
    :setlocal noswapfile
    :setlocal bufhidden=hide
    :setlocal nobuflisted
    :windo diffthis
endfunction

"" *****************************************************************************
function! FixWhitespaces()
  let l:search = @/
  let l:l = line('.')
  let l:c = col('.')

  %s/\s\+$//e

  let @/ = l:search
  call cursor(l:l, l:c)
endfunction

" Add external source files
source ~/.vim/cscope_maps.vim
source ~/.vim/vundle.vim

