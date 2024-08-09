<!-- @format -->

Simple bash scripts I have in `/usr/local/bin` that may be trivial to
recreate, but why reinvent the wheel.

## Does this make sense for Flatpaks?

```bash
tail -n +1 /var/lib/flatpak/exports/bin/*
```

## Snap?

`/usr/local/bin` is more likely to be in `$PATH` than the usual Snap vriants.
If they are in $PATH, note `sudo snap alias ORIGINAL NEW`

## File Access Control List

```
sudo setfacl --recursive --modify=u:root:rwX,o:rX /usr/local/bin/
getfacl /usr/local/bin
```
