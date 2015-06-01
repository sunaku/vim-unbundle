if exists('g:loaded_unbundle') && g:loaded_unbundle | finish | endif
let g:loaded_unbundle = 1

if !exists('g:unbundle_bundles_glob')
  let g:unbundle_bundles_glob = 'bundle/*'
endif

if !exists('g:unbundle_ftbundles_glob')
  let g:unbundle_ftbundles_glob = 'ftbundle/{filetype}/*'
endif

if v:version < 700
  echoerr 'Unbundle requires Vim 7 or newer.'
  finish
endif

" Unbundles directories matched by the given glob, unless they
" have already been unbundled, and returns them in path form.
"
" Any *.vim files that have the same basename as directories
" matched by the given glob will be sourced before their
" corresponding directories are unbundled.  This allows such
" *.vim files to configure bundles before they are unbundled.
function Unbundle(glob)
  " register new bundles from the given glob
  let existing = {} | call map(split(&runtimepath, ','), 'extend(existing, {v:val : 1})')
  let bundles = join(filter(split(globpath(&runtimepath, a:glob . '/.'), "\n"), '!has_key(existing, v:val)'), ',')
  if !empty(bundles)
    let afters = join(filter(split(globpath(bundles, 'after/.'), "\n"), '!has_key(existing, v:val)'), ',')
    let &runtimepath = join(filter([bundles, &runtimepath, afters], '!empty(v:val)'), ',')

    " create missing helptags for documentation inside bundles
    for folder in split(globpath(bundles, 'doc/.'), "\n")
      if filewritable(folder) == 2 && empty(glob(folder . '/tags*'))
        execute 'helptags' fnameescape(folder)
      endif
    endfor

    " configure bundles by loading {bundle_name}.vim files and
    " then emulate Vim's unpacking of the newly loaded bundles
    let configs = map(split(bundles, ','), 'substitute(v:val, "/.$", ".vim", "")')
    let plugins = split(globpath(bundles . ',' . afters, 'plugin/**/*.vim'), "\n")
    for file in filter(configs + plugins, 'filereadable(v:val)')
      execute 'source' fnameescape(file)
    endfor

    " apply newly loaded bundles to all currently open buffers
    doautoall BufRead
  endif

  " newly unbundled directories in path form
  return bundles
endfunction

" Unbundles directories associated with the given filetype, unless they have
" already been unbundled, and returns them in path form.  Multiple filetypes
" can be specified as a glob.  For example, to unbundle 'html', 'css', and
" 'javascript' ftbundles, pass '{html,css,javascript}' into this function.
function Unftbundle(type)
  return Unbundle(substitute(g:unbundle_ftbundles_glob, '{filetype}', a:type, 'g'))
endfunction

" only Unftbundle on the very first FileType trigger for any given filetype
let s:filetypes = {}
function s:FileType(type)
  if !has_key(s:filetypes, a:type)
    let s:filetypes[a:type] = 1
    call Unftbundle(a:type)
  endif
endfunction

" commands for manual invocation
command Unbundle call Unbundle(g:unbundle_bundles_glob)
execute 'command -nargs=1' (v:version >= 703 ? '-complete=filetype' : '') 'Unftbundle call Unftbundle(<f-args>)'

" unbundle bundles up front
Unbundle

" unbundle ftbundles on demand
filetype plugin indent off
augroup unbundle | autocmd FileType * call s:FileType(expand('<amatch>')) | augroup END
execute 'runtime!' substitute(g:unbundle_ftbundles_glob, '{filetype}', '*', 'g') . '/ftdetect/*.vim'
filetype plugin indent on
