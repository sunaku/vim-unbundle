if get(g:, 'loaded_unpack') | finish | endif | let g:loaded_unpack = 1
if v:version < 800 | echoerr 'Unpack needs Vim >= 8.' | finish | endif

command -nargs=1 -complete=packadd Unpack
      \ call unpack#UnpackGlob('pack/*/opt/'.<q-args>)

command -nargs=1 -complete=filetype UnpackFiletype
      \ call unpack#UnpackGlob('pack/*/opt/'.<q-args>.'=*')

command -nargs=1 -complete=packadd UnpackHelptags
      \ call unpack#FixHelptags('pack/*/*/'.<q-args>)

" generate missing helptags for all available packages, where possible
autocmd VimEnter * UnpackHelptags *

" dynamically load filetype-specific packages: pack/*/opt/{filetype}=*
filetype plugin indent off
autocmd FileType * execute 'UnpackFiletype' expand('<amatch>')
runtime! pack/*/opt/*=*/ftdetect/*.vim
filetype plugin indent on

" load package-specific configurations for packages Vim loads on start
runtime! pack/*/start/*.vim
