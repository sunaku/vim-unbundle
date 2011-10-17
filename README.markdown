unbundle.vim - Registers [bundles] found in Vim's runtimepath
=============================================================

Ubundle is a 4-line replacement for [Pathogen]'s bundle registration logic,
plus a 2-line convenience for activation of ftplugins inside your [bundles].

------------------------------------------------------------------------------
Background
------------------------------------------------------------------------------

Unbundle looks for directories called `bundle/` in Vim's runtimepath and then
adds all subdirectories therein back into Vim's runtimepath.  This lets you
keep your [bundles] isolated in their own directories, instead of having to
share your configuration directory (`~/.vim`) communally with your [bundles].

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

To install, place `unbundle.vim` somewhere on your system and then source it:

    source SOMEWHERE_ON_YOUR_SYSTEM/unbundle.vim

Add the line above to your vimrc file to use Unbundle every time you run Vim.

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Released under the WTFPL license.  See the LICENSE file for details.

[Pathogen]: https://github.com/tpope/vim-pathogen
[bundles]: http://www.vim.org/scripts/
