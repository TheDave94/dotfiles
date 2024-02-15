### Arch AUR Setup

### Install yay
```shell
git clone https://aur.archlinux.org/yay.git && cd yay

makepkg -si
```

### Package compress
```shell
sudo nano /etc/makepkg.conf
```
* Add `PKGEXT='.pkg.tar'` to "EXTENSION DEFAULTS"

The following skips compression of the package file, which will in turn have no need to be decompressed. It speeds up the installation progress.