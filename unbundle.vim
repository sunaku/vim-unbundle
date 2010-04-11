" append all bundle/*/{,after/} subdirs in the runtimepath to the runtimepath
let &rtp = tr(join([&rtp, globpath(&rtp, 'bundle/*/'), globpath(&rtp, 'bundle/*/after/')], ','), "\n", ',')
