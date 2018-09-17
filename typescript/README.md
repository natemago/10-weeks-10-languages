Typescript
==========

> Typescript is a typed superset of JavaScript that compiles to plain Javascript.

Check out the [homepage](https://www.typescriptlang.org/).

# Set up

## Install it

To install Typescript you basically install its transpiler. This seems to be an ```npm``` package, so you can do:

```bash
npm install -g typescript
```

To confirm that it was properly installed:

```bash
tsc --version
```

**Note:** This requires you to have [nodejs](https://nodejs.org/en/) with [npm](https://www.npmjs.com/) installed.
On Arch Linux you can install the latest (or nearly the latest) version with ```pacman```:
```bash
pacman -Sy nodejs
```

On other distributions, use [nvm](https://github.com/creationix/nvm#installation), or install it by following the directions for you distribution/OS on the [nodejs site itself](https://nodejs.org/en/download/package-manager/).

**Note:** To install packages globally wit npm and **without** ```sudo```, I usually follow this [procedure](https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md).

# Documentation

* Official [docs](https://www.typescriptlang.org/docs/home.html)
* [% minute tutorial](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html)
* [Handbok](https://www.typescriptlang.org/docs/handbook/basic-types.html)

# Tutorials and books

As a quick reference I went through [this one on tutorialspoint.com](https://www.tutorialspoint.com/typescript/index.htm).

However there is a nice in-depth book - [TypeScript Deep Dive](https://basarat.gitbooks.io/typescript/content/).