gitignore.plugin.zsh
====================

Zsh plugin for creating .gitignore files.

Installation
------------

Antigen:
    
        antigen bundle voronkovich/gitignore.plugin.zsh

Or clone this repo and add this into your .zshrc:

        source path/to/cloned/repo/gitignore.plugin.zsh

Usage
-----

        gi TEMPLATE (will write rules to the standard output)

Or:
        
        gii TEMPLATE (will write output to the local .gitignore file)

Example:

        gi vim eclipse symfony

Demo
----

![gif](http://i.imgur.com/NiaFzeh.gif)

License
-------

Copyright (c) Voronkovich Oleg. Distributed under the MIT.
