" notify user that this file has moved into plugin/
" https://github.com/sunaku/vim-unbundle/issues/10
let s:new_location = expand('<sfile>:h') . '/plugin/' . expand('<sfile>:t')
echomsg 'Unbundle: ' expand('<sfile>') 'is deprecated;'
echomsg 'please use' s:new_location 'instead.'
execute 'source' s:new_location
