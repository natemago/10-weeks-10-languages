Julia
=====

From wikipedia:
> Julia is a high-level general-purpose dynamic programming language that was originally designed to address the needs of high-performance numerical analysis and computational science, without the typical need of separate compilation to be fast, also usable for client and server web use, low-level systems programming or as a specification language.

The [language main page](https://julialang.org/) with some fancy visualizations.

The official documentation is available [here](https://docs.julialang.org/en/v1/).

# Setup

Download and installation guide is available on the [language web site](https://julialang.org/downloads/).

On [Archlinux](https://wiki.archlinux.org/index.php/Julia) it can be installed with ```pacman```:

```bash
sudo pacman -Sy julia
```

# Run with Docker

There is a ```library``` image available on Docker Hub, called ```julia```.

To run the REPL in the current dir, run:

```
docker run -it --rm -v $(pwd):/usr/myapp -w /usr/myadd julia
```

To run a Julia script in the current dir:

```
docker run -it --rm -v $(pwd):/usr/myapp -w /usr/myadd julia julia script.jl <arg> <arg>
```
