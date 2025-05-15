# hw11translate2Ascii

##  Assignment Overview
Produce a 32-bit x86 NASM program that

1. **Reads** eight bytes from `inputBuf`
db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A

2. **Translates** each byte to its two-character **ASCII hexadecimal** form.
3. **Stores** the result (with spaces between bytes) in outputBuf resb 80


4. **Prints** the contents of `outputBuf` and advances to a new line.

**NOTE:** Must assemble and link for **32-bit** (`elf_i386`).  

## Example 
```bash
$ ./hw11translate2Ascii
83 6A 88 DE 9A C3 54 9A
$

# Assemble, link, run:
nasm -f elf32 -o hw11translate2Ascii.o hw11translate2Ascii.asm
ld   -m elf_i386 -o hw11translate2Ascii   hw11translate2Ascii.o
./hw11translate2Ascii




