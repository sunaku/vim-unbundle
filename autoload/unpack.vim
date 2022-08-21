" Unpacks the given package (relative to &runtimepath) if it's new.
"
" Any *.vim file that shares the same rootname as the given package
" will be `:source`d first BEFORE the given package is `:packadd`ed.
" This gives *.vim file a chance to pre-configure the given package.
"
" For example, if "pack/A/opt/B" is passed to this function then any
" corresponding "pack/A/opt/B.vim" file will be `:source`d before it.
"
function! unpack#Unpack(package) abort
  let s:unpacked[a:package] = 1
  execute 'runtime' a:package.'.vim'
  execute 'packadd' fnamemodify(a:package, ':t')
  return a:package
endfunction
let s:unpacked = {}

" Unpacks new packages from the given list and returns the new ones.
function! unpack#UnpackList(packages) abort
  return map(filter(a:packages,
        \ '!has_key(s:unpacked, v:val)'),
        \ 'unpack#Unpack(v:val)')
endfunction

" Unpacks packages matching the given glob and returns them in a list.
function! unpack#UnpackGlob(glob) abort
  return unpack#UnpackList(unpack#Globpath(a:glob))
endfunction

" Searches the given glob and returns paths relative to &runtimepath.
function! unpack#Globpath(glob) abort
  return map(split(globpath(&runtimepath, a:glob.'/'), "\n"),
        \ 'substitute(v:val, ".*/\\zepack/\\|/*$", "", "g")')
endfunction

" Generates missing helptags in WRITABLE packages matching the given glob.
function! unpack#FixHelptags(glob) abort
  for folder in split(globpath(a:glob, 'doc/'), "\n")
    if filewritable(folder) == 2 && empty(glob(folder.'/tags*'))
      execute 'helptags' fnameescape(folder)
    endif
  endfor
endfunction

function! unpack#CommandUnpack(glob) abort
  call unpack#UnpackGlob('pack/*/opt/'.a:glob)
endfunction

function! unpack#CommandFiletype(glob) abort
  call unpack#UnpackGlob('pack/*/opt/'.a:glob.'=*')
endfunction

function! unpack#CommandHelptags(glob) abort
  call unpack#FixHelptags('pack/*/*/'.a:glob)
endfunction
