# Fonts for using `plt.xkcd`

The following resources contains the fonts necessary to use `plt.xkcd`
([this](https://stackoverflow.com/a/22812176) answer helped me to find them). For my
convenience I have gathered all of them in the `fonts` directory -- please let me know
if this contradicts a license I am not aware of.

+ `xkcd` and `xkcd-script` are taken from [here](https://github.com/ipython/xkcd-font)
+ `humor` is taken from [here](https://github.com/shreyankg/xkcd-desktop/blob/master/Humor-Sans.ttf)
+ `comic-sans-ms` is taken from [here](https://www.wfonts.com/font/comic-sans-ms)
+ `comic-neue` is taken from [here](https://fonts.google.com/specimen/Comic+Neue)

## Install

### Fedora 39

+ `make f39-install-fonts`
  + copies the contents of the `fonts` directory in `~/.local/share/fonts`
  + runs `fc-cache -v` (then `fc-list | grep xkcd` to check installation)
  + clears matplotlib's cache

### Macos 13.1

+ drag and drop the `fonts` folder in the `Font Book` application (no need to replace
  already existing fonts)
+ you might have to clears matplotlib's cache (`~/.matplotlib/fontlist-v330.json`)

## Create test plot

+ `make test-plot`
