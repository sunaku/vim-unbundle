" Unbundles the directories matched by the given glob,
" unless they have already been unbundled, and returns
" only those newly unbundled directories in path form.
function Unbundle(glob)
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

" Unbundles all ftbundles associated with the given
" filetype, unless they have already been unbundled.
function Unftbundle(type)
  let l:bundles = Unbundle('ftbundle/' . a:type . '/*')
  for l:plugin in split(globpath(l:bundles, 'plugin/**/*.vim'), "\n")
    execute 'source' fnameescape(l:plugin)
  endfor
endfunction

" unbundle bundles up front
call Unbundle('bundle/*')

" unbundle ftbundles on demand
autocmd FileType * :call Unftbundle(expand('<amatch>'))
runtime! ftbundle/*/*/ftdetect/*.vim
filetype plugin indent on
