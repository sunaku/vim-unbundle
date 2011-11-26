" load dependent filetype bundles
if !exists('b:did_unftbundle_eruby')
  let b:did_unftbundle_eruby = 1

  " input language of eRuby template
  call Unftbundle('ruby')

  " output language of eRuby template
  if exists('b:eruby_subtype')
    call Unftbundle(b:eruby_subtype)
  endif
endif
