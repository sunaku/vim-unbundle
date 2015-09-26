# unbundle.vim

[Unbundle] activates [Vim scripts] from isolated directories by adding them to
Vim's runtimepath and building missing helptags for documentation therein.
For the initiated, it's like [pathogen.vim] but with *ftbundles* and less code.

## Terminology

**bundles** are [Vim scripts] that are stored in isolated `bundle/*/`
directories found in the runtimepath.  For example, `~/.vim/bundle/*/` would
be your bundles by default in UNIX. However, you can specify an alternate
location by setting `g:unbundle_bundles_glob`.

**ftbundles** are filetype-specific bundles that are loaded lazily, only when
they are first used, to shorten Vim's startup time.  Similar to bundles, they
are stored in isolated `ftbundle/{filetype}/*/` directories found in the
runtimepath.  For example, `~/.vim/ftbundle/{filetype}/*/` would be your
ftbundles for `{filetype}` by default in UNIX.  However, you can specify an
alternate location by setting `g:unbundle_ftbundles_glob`.

## Requirements

* Vim 7 or newer.

## Installation

1. Clone this Git repository or [download its contents][downloads] into a new
   `vim-unbundle` subdirectory inside your Vim runtime directory.  For
   example, `~/.vim/vim-unbundle` would be the correct location in Unix.

        git clone https://github.com/sunaku/vim-unbundle.git ~/.vim/vim-unbundle

2. Run the following command inside Vim to start using Unbundle immediately,
   or add it to your *vimrc* file to start Unbundle whenever you start Vim.

        :runtime vim-unbundle/plugin/unbundle.vim

3. Run the following command inside Vim to learn more about using Unbundle.

        :help unbundle.vim

## Documentation

Run `:help unbundle` or see the `doc/unbundle.txt` file.

## Credits

* [Colin Shea](https://github.com/evaryont) came up with [the idea of
  *ftbundles*](https://github.com/sunaku/vim-unbundle/issues/2).

* [heavenshell](https://github.com/heavenshell) added [compatibility](
  https://github.com/sunaku/vim-unbundle/pull/7) with the Japanese
  [Vim-Kaoriya](http://www.kaoriya.net/software/vim) distribution.

* [Peter Aronoff](http://ithaca.arpinum.org) gave feedback and ideas on how to
  best organize filetypes with dependent ftbundles, such as eRuby templates.

* An [anonymous Alexander suggested](
  http://snk.tuxfamily.org/log/vim-script-management-system.html#IDComment98711660)
  appending `/.` to directory globs for portability across operating systems.

## License

Copyright 2010 Suraj N. Kurapati <https://github.com/sunaku>

Distributed under [the same terms as Vim itself][license].

[Unbundle]:     https://github.com/sunaku/vim-unbundle
[downloads]:    https://github.com/sunaku/vim-unbundle/archive/master.zip
[license]:      http://vimdoc.sourceforge.net/htmldoc/uganda.html#license
[pathogen.vim]: https://github.com/tpope/vim-pathogen#readme
[Vim scripts]:  http://www.vim.org/scripts/
