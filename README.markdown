unbundle.vim - Activates [bundles] found in Vim's runtimepath
=============================================================

Ubundle is a short alternative to [Pathogen]'s bundle isolation, registration,
and helptag facilities.  It also features **ftbundles**: Vim filetype specific
bundles that are automatically loaded on demand for improved Vim performance.

------------------------------------------------------------------------------
Background
------------------------------------------------------------------------------

Unbundle looks for directories called `bundle/` in Vim's runtimepath and then
adds all subdirectories therein back into Vim's runtimepath.  This lets you
keep your [bundles] isolated in their own directories, instead of having to
share your Vim runtime directory communally with your [bundles].

### ftbundles - filetype specific bundles

Unbundle also looks for directories called `ftbundle/` in Vim's runtimepath.
These directories contain subdirectories whose names reflect Vim filetypes.
These subdirectories contain bundles that are only loaded when Vim demands it.

For example, if you have 5 bundles that concern the `ruby` filetype, then you
would place those bundles in `ftbundle/ruby/` to only load them when you edit
a Ruby file.  This reduces Vim's startup time, especially if your I/O is slow.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

1. Clone this Git repository or [download its contents][download] into a new
   `bundle/vim-unbundle` subdirectory inside your Vim runtime directory.  For
   example, `~/.vim/bundle/vim-unbundle` would be the corect location in Unix.

2. Run the following command inside Vim to start using Unbundle immediately,
   or add it to your `vimrc` file to start Unbundle whenever you start Vim.

        runtime bundle/vim-unbundle/unbundle.vim

------------------------------------------------------------------------------
Invocation
------------------------------------------------------------------------------

When it is sourced, `unbundle.vim` automatically unbundles found bundles and
registers an auto-command to dynamically unbundle ftbundles as you need them.

You can *manually* invoke parts of this default behavior via these commands:

* `:Unbundle` loads newly found bundles (this does *not* process ftbundles!)

* `:Unftbundle <filetype>`
  unbundles all ftbundles associated with the given filetype, unless they
  have already been unbundled.  Multiple filetypes can be specified in the
  form of a glob.  For example, to unbundle 'html', 'css', and 'javascript'
  ftbundles, you would pass `{html,css,javascript}` to this command.

Alternatively, you can directly invoke their underlying Vim script functions:

* `:call Unbundle(glob)`
  unbundles the directories matched by the given glob,
  unless they have already been unbundled, and returns
  only those newly unbundled directories in path form.

* `:call Unftbundle(type)`
  unbundles all ftbundles associated with the given filetype, unless they
  have already been unbundled.  Multiple filetypes can be specified in the
  form of a glob.  For example, to unbundle 'html', 'css', and 'javascript'
  ftbundles, you would pass `'{html,css,javascript}'` to this function.

------------------------------------------------------------------------------
Credits
------------------------------------------------------------------------------

* [Colin Shea](https://github.com/evaryont) is the man behind [the ftbundles
  idea](https://github.com/sunaku/vim-unbundle/issues/2).

* [Peter Aronoff](http://ithaca.arpinum.org) gave feedback and ideas on how to
  best organize filetypes with dependent ftbundles, such as eRuby templates.

* An [anonymous Alexander suggested](
  http://snk.tuxfamily.org/log/vim-script-management-system.html#IDComment98711660)
  appending `/.` to directory globs for portability across operating systems.

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright 2010 Suraj N. Kurapati <sunaku@gmail.com>

Distributed under [the same terms as Vim itself][license].

[Pathogen]: https://github.com/tpope/vim-pathogen
[bundles]: http://www.vim.org/scripts/
[license]: http://vimdoc.sourceforge.net/htmldoc/uganda.html#license
[download]: https://github.com/sunaku/vim-unbundle/downloads
