section .data
msg1 : db 'GIVE ME STRING NOW',10
l1: equ $-msg1
msg2 : db 'hmmmmm okay give one more',10
l2: equ $-msg2

section .bss
string1 : resb 100
string2: resb 100
string3: resb 200
str_len1: resd 1
str_len2: resd 1
str_len3: resd 1
temp_char: resb 1

section .text
    global _start:
    _start:

    mov dword[str_len1],0
    mov dword[str_len2],0
    mov dword[str_len3],0

    mov eax,4
    mov ebx,0
    mov ecx,msg1
    mov edx,l1
    int 80h

    mov ebx,string1
    pusha

    reading_str1:
        push ebx
        mov eax,3
        mov ebx,0
        mov ecx,temp_char
        mov edx,1
        int 80h
        pop ebx

        mov al,byte[temp_char]
        cmp al,10
        je end_reading1

        mov byte[ebx],al
        inc ebx
        inc dword[str_len1]
        jmp reading_str1

    end_reading1:
        mov byte[ebx],0
        popa

    mov dword[str_len2],0

    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,l2
    int 80h

    mov ebx,string2
    pusha 
    reading_str2:
        push ebx
        mov eax,3
        mov ebx,0
        mov ecx,temp_char
        mov edx,1
        int 80h
        pop ebx

        mov al,byte[temp_char]
        cmp al,10
        je end_reading2

        mov byte[ebx],al
        inc ebx
        inc dword[str_len2]
        jmp reading_str2

    end_reading2:
        mov byte[ebx],0
        popa

    
    mov ecx,string3
    mov ebx,string1
    put_str_1:
        mov eax,dword[str_len1]
        cmp eax,0
        je end_put_str_1
        mov al,byte[ebx]
        mov byte[ecx],al
        inc ecx
        inc ebx
        inc dword[str_len3]
        dec dword[str_len1]
        jmp put_str_1
    end_put_str_1:
        mov ebx,string2
        jmp put_str_2

    put_str_2:
        mov eax,dword[str_len2]
        cmp eax,0
        je end_put_str_2
        mov al,byte[ebx]
        mov byte[ecx],al
        inc ecx
        inc ebx
        dec dword[str_len2]
        inc dword[str_len3]
        jmp put_str_2
    
    end_put_str_2:
        mov byte[ecx],0

    
    mov eax,4
    mov ebx,1
    mov ecx,string3
    mov edx,str_len3
    int 80h

    mov eax,1
    mov ebx,0
    int 80h




