# musl-extra
Extra tools for the musl libc.

## Who's the responsible?
All kudos for the C language source code goes to the NetBSD and Alpine Linux
team — read the copyright header of each file for more information. 

The "pure shell" ELF parser was created first as a P.O.C. at
[``takusuman/duende``](https://github.com/takusuman/duende).

## Licence

``getconf`` and ``getent`` are directly derived from the NetBSD source-tree,
covered by the [BSD 2-Clause licence](./LICENCE/LICENCE.BSD-2-Clause.txt).  
``iconv`` was written by Rich Felker, and it's covered by the [GNU General
Public Licence version 2](./LICENCE/LICENCE.GPL-2.0.txt).  
``ldconfig`` was originally written by Samuel Holland (``smaeul``), but it
received modifications to not depend on PaX Utils' ``scanelf`` by
Luiz Antônio Rangel (``takusuman``); it's still covered by the
[BSD 0-Clause licence](./LICENCE/LICENCE.0BSD.txt), though.
