" register bundles found in the runtimepath
let s:bundles = tr(globpath(&runtimepath, 'bundle/*/.'), "\n", ',')
let s:afters = tr(globpath(s:bundles, 'after/.'), "\n", ',')
let &runtimepath = join([s:bundles, &runtimepath, s:afters], ',')
