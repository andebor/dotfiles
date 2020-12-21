dotfiles
========
**This script will set up your new OS X install with standard developer tools and everyday software that I use.**
![screenshot](http://i.imgur.com/cPvtSfb.png)

## Installation
Open a terminal window:

```
xcode-select --install
```
Choose install and agree to the terms.
Then:

```
git clone https://github.com/andebor/dotfiles.git 
```

```
cd dotfiles
```

```
cat install.sh | sh
```
Follow the instructions from the installer.

## Custom installation

To customize which applications to install, run the script with -c followed by the path to your config file.
See the example file, for more information.

```
chmod +x ~/dotfiles/install.sh

cd ~/dotfiles

./install.sh -c /path/to/custom_config
```
