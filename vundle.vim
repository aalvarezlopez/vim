set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'bling/vim-bufferline'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'majutsushi/tagbar'
Plugin 'freeo/vim-kalisi'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'paul-nechifor/vim-svn-blame'

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
