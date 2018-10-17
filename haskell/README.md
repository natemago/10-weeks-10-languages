Haskell
=======


# Installation

On Archlinux:

```bash
pacman -Sy ghc
```

Then configure cabal - in ~/.cabal/config:

```
library-vanilla: False
shared: True
executable-dynamic: True
```