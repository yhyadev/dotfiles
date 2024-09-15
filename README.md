# Yhya's Linux Dotfiles

## Installation

1. Clone the repo

```
git clone https://github.com/yhyadev/dotfiles
cd dotfiles
```

2. Join the `stow` directory

```
cd stow
```

3. Make symbolic links using `stow`

```
stow * -t ~
```

4. Build suckless configurations using `make` (replace `dwm` with the intended app)

```
cd ~/.config/dwm
make install clean
```
