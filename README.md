## Usage
To generate debian package under folder deobj/
```bash
# preparation
sudo apt-get install debhelper dh-make debmake devscripts fakeroot
sudo apt-get install u-boot-tools

# packaging
# using git tree lastest files
./tools/packaging_deb.sh
```
