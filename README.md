# supermechbros

Super Mechanical Bros main game repository.

## Repository Structure

The `all` script will setup the repositories as modeled below:

```
smb
├── gamecode                   # quakec
├── gmqcc                      # gitlab.com/xonotic/gmqcc
└── supermechbros              # You are HERE
    ├── darkplaces             # TODO (use Mario/smb in darkplaces)
    └── data
        ├── smb-data.pk3dir
        ├── smb-maps.pk3dir
        └── xonotic-sxb.pk3dir # github.com/z/xonotic-sxb.pk3dir

```

## Setup

### Code

Checkout this repository:

*The parent directory MUST be named `smb` as a safety check*

```
mkdir smb && cd smb
git clone git@github.com:SuperMechBros/supermechbros.git
cd supermechbros
```

### Dependencies

#### Linux

###### Debian/Ubuntu

```
sudo apt-get install build-essential xserver-xorg-dev x11proto-xf86dri-dev x11proto-xf86dga-dev x11proto-xf86vidmode-dev libxxf86dga-dev libxcb-xf86dri0-dev libxpm-dev libxxf86vm-dev libsdl1.2-dev libsdl2-dev libsdl2-image-dev libclalsadrv-dev libasound2-dev libxext-dev libjpeg-turbo8-dev git-core unzip wget zlib1g-dev
```

###### Fedora/Red Hat

```
sud yum install x11-proto-devel libalsa2-static-devel libjpeg62-devel libjpeg62-static-devel libSDL2-devel
```

###### Arch

```
sudo pacman -S alsa-lib curl libjpeg-turbo libmodplug libpng libvorbis libxpm libxxf86dga libxxf86vm sdl2 unzip
```

#### Windows

[msys2](http://www.msys2.org/)

#### OSX

Xcode + git, if your version of Xcode doesn't come with git, try [git-osx-installer](https://sourceforge.net/projects/git-osx-installer/files/).

### Building and Running

Build all gamecode (checkout all required repositories, and build dependencies):

```
./all build
```

Run the game:

```
./all run
```
## Commands

```
build [all|game|maps]       builds the game, maps, or both. implies update. defaults game.
run                         runs Super Mechanical Bros.
update                      update all repositories, and dependencies
```

## Examples

```bash
# update dependencies, builds everything
./all build

# update dependencies, builds maps
./all build_maps

# runs the game
./all run

# Override the path to Super Mechnical Bros.
# (normally assumed from relative location of this script)
SMB_DIR=$HOME/some/other/dir; ./all --version
```
