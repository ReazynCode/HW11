section .data
inputBuf:   db  0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen:   equ 8          ; Number of bytes in inputBuf

section .bss
outputBuf:  resb 80

section .text
global _start

_start:
    mov esi, inputBuf      ; input pointer
    mov edi, outputBuf     ; output pointer
    mov ecx, inputLen      ; counter for bytes

translate_loop:
    cmp ecx, 0
    je  end_translation

    ; Load byte from inputBuf into AL
    lodsb                  ; AL = [ESI], ESI++

    ; Convert high nibble
    mov ah, al             ; Copy AL to AH to preserve full byte
    shr al, 4              ; Shift AL to get high nibble
    call nibble_to_ascii
    stosb                  ; store ASCII char

    ; Convert low nibble
    mov al, ah             ; restore original byte
    and al, 0x0F           ; get low nibble
    call nibble_to_ascii
    stosb                  ; store ASCII char

    ; Add space
    mov al, ' '
    stosb

    dec ecx
    jmp translate_loop

end_translation:
    ; Replace last space with newline
    dec edi
    mov byte [edi], 0x0A

    ; Print outputBuf
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf  ; length = edi - outputBuf
    int 0x80

    ; Exit
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80

; Subroutine: nibble_to_ascii
; Input: AL contains nibble (0–15)
; Output: AL contains ASCII character
nibble_to_ascii:
    cmp al, 9
    jbe .number
    add al, 0x37        ; 'A' - 10 = 0x41 - 10 = 0x37
    ret
.number:
    add al, 0x30        ; convert 0–9 to '0'–'9'
    ret
