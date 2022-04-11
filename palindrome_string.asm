section .data
msg_yes : db 'yes, palindrome, wow, beautiful',10
l1 : equ $-msg_yes
msg_no : db 'no, not palindrome, ew, ugly',10
l2 : equ $-msg_no
newline: db '', 10

section .bss
char_temp: resb 1
str_len: resd 1
string : resb 100
counter : resd 1
index1 : resb 1
index2 : resb 1
cc1 : resd 1
cc2 : resd 1
ii1 : resd 1
ii2 : resd 1

section .text
    global _start:
    _start:

    mov ebx,string
    mov dword[str_len],0
    pusha

    read_char:
        push ebx

        mov eax,3
        mov ebx,0
        mov ecx,char_temp
        mov edx,1
        int 80h

        pop ebx

        cmp byte[char_temp],10
        je exit_read_loop
        inc dword[str_len]
        mov al,byte[char_temp]
        mov byte[ebx],al
        add ebx,1
        jmp read_char
        
        exit_read_loop:
            mov byte[ebx],0
            mov ebx, string
            popa

    mov eax,dword[str_len]
    mov edx,0
    mov ebx,2
    div ebx
    mov dword[counter],eax

    ; counter now should store n/2
    mov dword[cc1],0
    mov eax,dword[str_len]
    sub eax,1
    mov dword[cc2],eax

    mov ebx,string
    
    func:
    mov eax,dword[cc1]
    ; mul dword[four]
    mov dword[ii1],eax

    mov eax,dword[cc2]
    ; mul dword[four]
    mov dword[ii2],eax

    push ebx

    add ebx, dword[ii1]
    mov al, byte[ebx]
    mov byte[index1],al

    pop ebx

    push ebx

    add ebx, dword[ii2]
    mov al, byte[ebx]
    mov byte[index2],al

    pop ebx

    push ebx

    mov bl,byte[index1]
    mov al,byte[index2]
    cmp al,bl
    jne not_palindrome

    dec dword[counter]
    mov eax,dword[counter]
    cmp eax,0
    jng is_palindrome

    pop ebx

    inc dword[cc1]
    dec dword[cc2]
    jmp func

    ;compare it to zero and leave if it is zero

    not_palindrome:
    mov eax,4
    mov ebx,1
    mov ecx,msg_no
    mov edx,l2
    int 80h
    jmp exit

    is_palindrome:
    mov eax,4
    mov ebx,1
    mov ecx,msg_yes
    mov edx,l1
    int 80h

    exit:
    mov eax,1
    mov ebx,0
    int 80h