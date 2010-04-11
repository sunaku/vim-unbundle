" append bundle/* subdirectories in the runtimepath to the runtimepath
let &rtp = join([&rtp] + split(globpath(&rtp, 'bundle/*/'), "\n"), ',')
