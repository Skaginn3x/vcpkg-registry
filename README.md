# Skaginn 3X vcpkg registry


## When changing

Run the following command after each changed commit:
```bash
$ mkdir scripts
$ cp /opt/vcpkg/scripts/vcpkgTools.xml scripts/
$ /opt/vcpkg/vcpkg x-add-version --all --vcpkg-root=$(pwd) --overwrite-version
```
