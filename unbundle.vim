" register bundles found in the runtimepath
let s:bundles = tr(globpath(&runtimepath, 'bundle/*/.'), "\n", ',')
let s:afters = tr(globpath(s:bundles, 'after/.'), "\n", ',')
let s:paths = filter([s:bundles, &runtimepath, s:afters], '!empty(v:val)')
let &runtimepath = join(s:paths, ',')

" activate ftplugin/ scripts inside bundles
filetype off
filetype plugin indent on
