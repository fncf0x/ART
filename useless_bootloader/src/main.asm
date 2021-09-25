	BITS 16

start:
	mov ax, 0x7c0
	mov ds, ax
	mov ax, 0x7e0
	mov ss, ax
	mov sp, 0x2000


	call clear_scr
	mov si, hello
	call print_slow_str
	call sleep
	mov si, msg1
	call print_slow_str
	call sleep
	mov si, msg2
	call print_slow_str
	call sleep
	mov si, msg3
	call print_slow_str
	call sleep
	mov si, msg4
	call print_slow_str
.prompt:
	mov si, shell
	call print_str
.read:
	mov ah, 0x00
	int 0x16
	cmp al, 0x0d
	je .prompt
	cmp al, 0x61
	je .read
	mov ah, 0xe
	int 0x10
	jmp .read


	hlt
	hello db "Hello,", 0x0a, 0x0d, 0x00
	msg1 db "This program has been created for no reason, ", 0x00
	msg2 db "isn't this bautiful heh?", 0x0a, 0x0d, 0x00
	msg3 db "a program that exist by it self.", 0x0a, 0x00
	msg4 db "Black Rabbit", 0x0a, 0x0d, 0x00, 0x00
	shell db 0x0a, 0x0d, "RabbitOS> ", 0x0, 0x0

print_slow_str:
	mov ah, 0xe
.p_char:
	lodsb
	cmp al, 0x0
	je .eof
	int 0x10
	mov ah, 0x86
	mov bx, 0
	mov cx, 1
	int 0x15
	mov ah, 0xe
	jmp .p_char
.eof:
	ret

print_str:
	mov ah, 0xe
.p_char:
	lodsb
	cmp al, 0x0
	je .eof
	int 0x10
	mov ah, 0xe
	jmp .p_char
.eof:
	ret


clear_scr:
	mov ah, 0x2
	xor dl, dl
	xor dh, dh
	xor bh, bh
	int 0x10

	mov bx, 0
.loop:
	add bx, 1
	mov ah, 0xe
	mov al, 0x00
	int 0x10
	cmp bx, 1000
	jne .loop
	mov ah, 0x2
	xor dl, dl
	xor dh, dh
	xor bh, bh
	int 0x10
	ret

sleep:
	mov ah, 0x86
	mov cx, 20
	int 0x15
	ret


	times 510-($-$$) db 0
	dw 0xAA55

