" append all bundles in the runtimepath to the runtimepath
let s:bundles = tr(globpath(&rtp, 'bundle/*/'), "\n", ',')
let s:afters = tr(globpath(s:bundles, 'after/'), "\n", ',')
let &runtimepath = join([&runtimepath, s:bundles, s:afters], ',')
