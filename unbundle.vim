" Unbundles the directories matched by the given
" glob, unless they have already been unbundled.
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
endfunction

" unbundle bundles up front
call Unbundle('bundle/*')

" unbundle ftbundles on demand
autocmd FileType * :call Unbundle('ftbundle/' . expand('<amatch>') . '/*')
for s:path in split(globpath(&runtimepath, 'ftbundle/*/*/ftdetect/*.vim'), "\n")
  execute 'source' fnameescape(s:path)
endfor
filetype plugin indent on
