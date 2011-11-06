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
share your Vim user configuration directory communally with your [bundles].

### ftbundles - filetype specific bundles

Unbundle also looks for directories called `ftbundle/` in Vim's runtimepath.
These directories contain subdirectories whose names reflect Vim filetypes.
These subdirectories contain bundles that are only loaded when Vim demands it.

For example, if you have 5 bundles that concern the `ruby` filetype, then you
would place those bundles in `ftbundle/ruby/` to only load them when you edit
a Ruby file.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

To install, place `unbundle.vim` somewhere on your system and then source it:

    source SOMEWHERE_ON_YOUR_SYSTEM/unbundle.vim

Add the above line to your vimrc file to use Unbundle whenever you start Vim.

### Dynamic Bootstrapping Example

If you installed Unbundle to `YOUR_VIM_DIR/bundle/vim-unbundle/unbundle.vim`
(where `YOUR_VIM_DIR` is the path to your Vim user configuration directory),
then run the following command inside Vim to dynamically bootstrap Unbundle:

    execute 'source' fnameescape(globpath(&runtimepath, 'bundle/vim-unbundle/unbundle.vim'))

Add the above line to your vimrc file to dynamically bootstrap Unbundle
whenever you start Vim.

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Released under the WTFPL license.  See the LICENSE file for details.

[Pathogen]: https://github.com/tpope/vim-pathogen
[bundles]: http://www.vim.org/scripts/
