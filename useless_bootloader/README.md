# useless bootloader

Just having fun with BIOS interrupt calls

## Run

Assemble op codes to raw 512 Bytes hex file

```bash
./build.sh
```


Run using qemu i386

```bash
qemu-system-i386 -fda floppy/main.flp
```

## Todo

Make a simple shell that list devices and a bonus game feature.
