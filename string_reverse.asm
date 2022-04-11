section .data
msg : db 'give me string ',10
l1: equ $-msg

section .bss
string1: resb 100
string2: resb 100
temp_char: resb 1
str_len:resd 1
str_len_copy:resd 1

section .text
    global _start:
    _start:

    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,l1
    int 80h

    mov dword[str_len],0
    mov ebx,string1
    pusha

    reading_string:
        push ebx

        mov eax,3
        mov ebx,0
        mov ecx,temp_char
        mov edx,1
        int 80h

        pop ebx

        mov al,byte[temp_char]
        cmp al,10
        je end_string

        mov byte[ebx],al
        inc ebx
        inc dword[str_len]
        jmp reading_string

    end_string:
        mov byte[ebx],0
        popa

    mov ebx,dword[str_len]
    mov dword[str_len_copy],ebx

    mov ebx,string1
    mov ecx,string2
    add ecx,dword[str_len]

    reversal:
        mov al,byte[ebx]
        mov byte[ecx],al
        dec ecx
        inc ebx
        dec dword[str_len_copy]
        mov eax,dword[str_len_copy]
        cmp eax,0
        jne reversal
    
    mov eax,4
    mov ebx,1
    mov ecx,string2
    mov edx,str_len
    int 80h

    mov eax,1
    mov ebx,0
    int 80h


; actually reverses the string instead of cheesing it
; i know i couldve cheesed it
; no