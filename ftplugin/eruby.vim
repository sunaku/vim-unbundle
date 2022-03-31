" load dependent filetype bundles
if !exists('b:did_unftbundle_eruby')
  let b:did_unftbundle_eruby = 1

  " input language of eRuby template
  UnpackFiletype ruby

  " output language of eRuby template
  if exists('b:eruby_subtype')
    execute 'UnpackFiletype' b:eruby_subtype
  endif
endif
