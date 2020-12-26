Update: This plugin may still work, but I have opted to use
[Neoformat](https://github.com/sbdchd/neoformat) instead. Thus, I have archived
this repository.

---

# vim-brittany

Integrates with [brittany](https://github.com/lspitzner/brittany) so every time
you save a Haskell source file it gets automatically prettified.

Simply using `:%!brittany` replaces your whole source file with an error message
from **brittany** when you happen to have a syntax error in your code. This
plugin manages that annoyance.

_Note:_ If you prefer _hindent_ use
[vim-hindent](https://github.com/alx741/vim-hindent) instead. _Note:_ If you
prefer _stylish-haskell_ use
[vim-stylishask](https://github.com/alx741/vim-stylishask) instead.

## Installation

Compatible with `Vundle`, `Pathogen`, `Vim-plug`.

## Usage

By default, _vim-brittany_ will format your code automatically when saving a
Haskell source file, but you can use the `:Brittany` command at any time to
format the current file.

To apply _brittany_ on a range, either write the range manually or visually
select the desired code and then invoke `:Brittany`.

Use `:BrittanyEnable`, `:BrittanyDisable`, `:BrittanyToggle` to enable, disable,
or toggle running `brittany` on save.

## Configuration

Trigger _brittany_ when saving (default = 1):

```vim
g:brittany_on_save = 1
```

Number of spaces per indentation (default = '', uses `brittany` default of 2):

```vim
g:brittany_indent = 2
```

Max line length (default = `''`, uses `brittany` default of 80):

```vim
g:brittany_columns = 100
```

Specify the path to the brittany executable (for example if you installed
brittany with `stack build --copy-compiler-tool brittany`)

```vim
g:brittany_command = "stack exec -- brittany"
```

## Credits

Credit for this goes to alx741, as this is essentially a search-and-replace of
[vim-hindent](https://github.com/alx741/vim-hindent).
