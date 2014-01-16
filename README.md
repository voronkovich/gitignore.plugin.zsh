gitignore.plugin.zsh
====================

Zsh plugin for creating .gitignore files.

Installation
------------

Antigen:
    
        antigen bundle voronkovich/gitignore.plugin.zsh

Or clone this repo and add this into your .zshrc:

        fpath=(path/to/cloned/repo $fpath)

Usage
-----

        gi TEMPLATE (will write rules to the standard output)

Or:
        
        gii TEMPLATE (will write output to the local .gitignore file)

License
-------

Copyright (c) Voronkovich Oleg. Distributed under the MIT.
