Nim
===

[Nim](https://nim-lang.org/) is a systems and applications programming language. Statically typed and compiled, it provides unparalleled performance in an elegant package.

```nim
# Compute average line length
var
  sum = 0
  count = 0

for line in stdin.lines:
  sum += line.len
  count += 1

echo("Average line length: ",
     if count > 0: sum / count else: 0)
```

# Documentation

* Official [documentation](https://nim-lang.org/documentation.html)
* [Tutorial](https://nim-lang.org/docs/tut1.html)
* Library [reference](https://nim-lang.org/docs/lib.html)
* Package manager: [nimble](https://github.com/nim-lang/nimble)


# Installation

On Archlinux:

```
sudo pacman -Sy nim nimble
```

# Getting started

Maybe the best way is to go through [nim-basics](https://narimiran.github.io/nim-basics/).