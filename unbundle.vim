if v:version < 700
  echoerr 'Unbundle requires Vim 7 or newer.'
  finish
endif

" Unbundles directories matched by the given glob, unless they
" have already been unbundled, and returns them in path form.
function! Unbundle(glob)
  " register new bundles from the given glob
  let l:existing = {} | for l:path in split(&runtimepath, ',') | let l:existing[l:path] = 1 | endfor
  let l:bundles = join(filter(split(globpath(&runtimepath, a:glob . '/.'), "\n"), '!has_key(l:existing, v:val)'), ',')
  let l:afters = join(filter(split(globpath(l:bundles, 'after/.'), "\n"), '!has_key(l:existing, v:val)'), ',')
  let &runtimepath = join(filter([l:bundles, &runtimepath, l:afters], '!empty(v:val)'), ',')

  " create missing helptags for documentation
  for l:path in split(globpath(l:bundles, 'doc/.'), "\n")
    if filewritable(l:path) == 2 && empty(glob(l:path . '/tags*'))
      execute 'helptags' fnameescape(l:path)
    endif
  endfor

  " If Vim already finished starting up, then it will *not* automatically
  " load any bundles registered thereafter.  So we must load them by hand!
  " This must also be done whenever we're unbundling newly found ftbundles.
  if !empty(l:bundles) && (!has('vim_starting') || expand('<sfile>') =~ '\<Unftbundle\.\.Unbundle$')
    " emulate Vim's unpacking of the newly loaded bundles
    for l:plugin in filter(split(globpath(l:bundles, 'plugin/**/*.vim'), "\n"), '!isdirectory(v:val)')
      execute 'source' fnameescape(l:plugin)
    endfor

    " apply newly loaded bundles to currently open buffers
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
  return Unbundle('ftbundle/' . a:type . '/*')
endfunction

" commands for manual invocation
command! Unbundle call Unbundle('bundle/*')
execute 'command! -nargs=1' (v:version >= 703 ? '-complete=filetype' : '') 'Unftbundle call Unftbundle(<f-args>)'

" unbundle bundles up front
Unbundle

" unbundle ftbundles on demand
filetype plugin indent off
augroup Unftbundle
  autocmd!
  autocmd FileType * call Unftbundle(expand('<amatch>'))
augroup END
runtime! ftbundle/*/*/ftdetect/*.vim
filetype plugin indent on
