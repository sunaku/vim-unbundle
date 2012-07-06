" Unbundles the directories matched by the given glob,
" unless they have already been unbundled, and returns
" only those newly unbundled directories in path form.
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

  " newly unbundled directories in path form
  return l:bundles
endfunction

" Unbundles all ftbundles associated with the given filetype, unless they
" have already been unbundled.  Multiple filetypes can be specified in the
" form of a glob.  For example, to unbundle 'html', 'css', and 'javascript'
" ftbundles, you would pass '{html,css,javascript}' into this function.
function! Unftbundle(type)
  let l:bundles = Unbundle('ftbundle/' . a:type . '/*')
  if !empty(l:bundles)
    " load ftbundles that were newly added to the runtimepath
    for l:plugin in filter(split(globpath(l:bundles, 'plugin/**/*.vim'), "\n"), '!isdirectory(v:val)')
      execute 'source' fnameescape(l:plugin)
    endfor

    " apply newly loaded ftbundles to currently open buffers
    doautoall BufRead
  endif
endfunction

" commands for manual invocation
command! Unbundle call Unbundle('bundle/*')
command! -nargs=1 -complete=filetype Unftbundle call Unftbundle(<f-args>)

" unbundle bundles up front
Unbundle

" unbundle ftbundles on demand
augroup Unftbundle
  autocmd!
  autocmd FileType * call Unftbundle(expand('<amatch>'))
augroup END
runtime! ftbundle/*/*/ftdetect/*.vim
filetype plugin indent on
