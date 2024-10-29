# Vim Syntax File for ST (Structured Text for PLC Programming)

This syntax file is meant to be used for Codesys/TwinCAT ST files.
Anyone is free to fork this syntax to match their own needs.

## Installation

In order to use this file it needs to be
copied to the syntax directory,
`~/.config/nvim/syntax` for Linux,
or `%USERPROFILE%/AppData/Local/nvim/syntax` for Windows.

The syntax can be loaded with `:set syntax=stplc.vim`

To load the syntax automatically when opening ST files refer to the Neovim 
[Documentation](https://neovim.io/doc/user/syntax.html#_2.-syntax-files).

## Acknowledgement

This syntax file was based on the following 
[repo](https://github.com/tompinkas/st-syntax.vim/).
The highlighting has been changed massively from that base,
and some built-in Codesys functions have been included.
