# supermechbros

Super Mechanical Bros main game repository.

## Repository Structure

The build script will setup the repositories as modeled below:

```
.
├── gamecode
├── gmqcc                      # gitlab.com/xonotic/gmqcc
└── supermechbros              # You are HERE
    ├── darkplaces             # TODO (use Mario/smb in darkplaces)
    ├── data
    │   ├── smb-data.pk3dir
    │   ├── smb-maps.pk3dir
    │   └── xonotic-sxb.pk3dir
    └── xonotic-sxb.pk3dir     # github.com/z/xonotic-sxb.pk3dir
```

## Building and Running

Checkout this repository:

```
git clone git@github.com:SuperMechBros/supermechbros.git
cd supermechbros
```

Build all gamecode (checkout all required repositories, and build dependencies):

```
./all build
```

Run the game:

```
./all run
```

## Commands

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
