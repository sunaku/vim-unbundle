if v:version < 700
  echoerr 'Unbundle requires Vim 7 or newer.'
  finish
endif

if exists('g:loaded_unbundle') && g:loaded_unbundle
  finish
endif
let g:loaded_unbundle = 1

if !exists('g:unbundle_bundles_glob')
  let g:unbundle_bundles_glob = 'bundle/*'
endif

if !exists('g:unbundle_ftbundles_glob')
  let g:unbundle_ftbundles_glob = 'ftbundle/{filetype}/*'
endif

" Unbundles directories matched by the given glob, unless they
" have already been unbundled, and returns them in path form.
"
" Any *.vim files that have the same basename as directories
" matched by the given glob will be sourced before their
" corresponding directories are unbundled.  This allows such
" *.vim files to configure bundles before they are unbundled.
function! Unbundle(glob)
  " register new bundles from the given glob
  let l:existing = {} | for l:folder in split(&runtimepath, ',') | let l:existing[l:folder] = 1 | endfor
  let l:bundles = join(filter(split(globpath(&runtimepath, a:glob . '/.'), "\n"), '!has_key(l:existing, v:val)'), ',')
  if !empty(l:bundles)
    let l:afters = join(filter(split(globpath(l:bundles, 'after/.'), "\n"), '!has_key(l:existing, v:val)'), ',')
    let &runtimepath = join(filter([l:bundles, &runtimepath, l:afters], '!empty(v:val)'), ',')

    " create missing helptags for documentation inside bundles
    for l:folder in split(globpath(l:bundles, 'doc/.'), "\n")
      if filewritable(l:folder) == 2 && empty(glob(l:folder . '/tags*'))
        execute 'helptags' fnameescape(l:folder)
      endif
    endfor

    " configure bundles by loading {bundle_name}.vim files and
    " then emulate Vim's unpacking of the newly loaded bundles
    let l:configs = map(split(l:bundles, ','), 'substitute(v:val, "/.$", ".vim", "")')
    let l:plugins = split(globpath(l:bundles . ',' . l:afters, 'plugin/**/*.vim'), "\n")
    for l:file in filter(l:configs + l:plugins, 'filereadable(v:val)')
      execute 'source' fnameescape(l:file)
    endfor

    " apply newly loaded bundles to all currently open buffers
    doautoall BufRead
  endif

  " newly unbundled directories in path form
  return l:bundles
endfunction

" Unbundles directories associated with the given filetype, unless they have
" already been unbundled, and returns them in path form.  Multiple filetypes
" can be specified as a glob.  For example, to unbundle 'html', 'css', and
" 'javascript' ftbundles, pass '{html,css,javascript}' into this function.
function! Unftbundle(type)
  return Unbundle(substitute(g:unbundle_ftbundles_glob, '{filetype}', a:type, 'g'))
endfunction

" commands for manual invocation
command! Unbundle call Unbundle(g:unbundle_bundles_glob)
execute 'command! -nargs=1' (v:version >= 703 ? '-complete=filetype' : '') 'Unftbundle call Unftbundle(<f-args>)'

" unbundle bundles up front
Unbundle

" unbundle ftbundles on demand
filetype plugin indent off
augroup Unftbundle
  autocmd!
  autocmd FileType * call Unftbundle(expand('<amatch>'))
augroup END
execute 'runtime!' substitute(g:unbundle_ftbundles_glob, '{filetype}', '*', 'g') . '/ftdetect/*.vim'
filetype plugin indent on
