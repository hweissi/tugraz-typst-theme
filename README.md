# TU Graz Typst theme

This is a theme inspired by the TUGraz Metropolis LaTeX theme, with some added nice features.

The flake provides a Dev-Shell and includes required fonts.
The theme is not Nix-packaged yet, because in their great wisdom, Typst devs decided to look in `$XDG_DATA_HOME` for packages instead of `$XDG_DATA_DIRS`


## Installation as local package

Install with

```sh
git clone https://github.com/hweissi/tugraz-typst-theme.git ~/.local/share/typst/packages/local/tugraz-typst-theme/1.0.0
```

Init project with template

```sh
typst init @local/tugraz-typst-theme:1.0.0
```

To build package using Nix, simply type `nix build`. The presentation will appear in `result/`.
This repo can use Github Actions to automatically build and upload the finished PDF.
To do that, enable write access for Github Actions in the repository settings, and tag a commit.
The resulting PDF appears in the Releases page of the repo.
