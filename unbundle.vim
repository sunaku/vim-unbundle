" create helptags for bundled documentation
for s:docdir in split(globpath(&runtimepath, 'bundle/*/doc/.'), "\n")
  if filewritable(s:docdir) == 2 && empty(glob(s:docdir . '/tags*'))
    execute 'helptags' fnameescape(s:docdir)
  endif
endfor

" register bundles found in the runtimepath
let s:bundles = tr(globpath(&runtimepath, 'bundle/*/.'), "\n", ',')
let s:afters = tr(globpath(s:bundles, 'after/.'), "\n", ',')
let s:paths = filter([s:bundles, &runtimepath, s:afters], '!empty(v:val)')
let &runtimepath = join(s:paths, ',')

" activate ftplugin/ scripts inside bundles
filetype off
filetype plugin indent on
