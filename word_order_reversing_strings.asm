section .data
msg: db 'give string :)',10
l1: equ $-msg
string_old: TIMES 1000 db 0
string_new: TIMES 1000 db 0
; change 20 to any number thats the maximum word length

section .bss
tempchar: resb 1
words: resd 1
index1: resd 1
loop_count : resb 1

section .text
    global _start:
    _start:

    mov ebx,string_old
    mov dword[words],0
    ; mov dword[strlen] 
    ; no need for strlen here because im smarter than that
    reading_inp:
        push ebx
        mov eax,3
        mov ebx,0
        mov ecx,tempchar
        mov edx,1
        int 80h
        pop ebx
        mov al,byte[tempchar]
        cmp al,10
        je end_reading_inp
        cmp al,32
        je add_word_keep_reading
        mov byte[ebx],al
        inc ebx
        jmp reading_inp


    add_word_keep_reading:
        mov byte[ebx],32
        inc dword[words]
        push eax
        mov eax,dword[words]
        mov ebx,20
        ; change 20 to any number thats the maximum word length
        mul ebx
        mov dword[index1],eax
        mov ebx,string_old
        add ebx,dword[index1]
        pop eax
        ; there wasnt anything important in eax anyway but still
        jmp reading_inp

    end_reading_inp:
        mov byte[ebx],32
        inc ebx
        inc dword[words]
        mov byte[ebx],0

    dec dword[words]
    ; in order to have word give us access to beginning of last word
    mov eax,dword[words]
    mov ebx,20
    ;changeeeeee 
    mul ebx
    mov ebx,string_old
    add ebx,eax

    ; ebx is at the last word of string 

    inc dword[words]
    mov eax,dword[words]
    mov dword[index1],eax

    ;index1 stores a copy of the number of words

    mov eax,string_new
    
    ; the main thing starts here
    word_exchange_loop:
        mov edx,eax
        push eax
        push ebx
        mov al,20
        ;changeeeeeeeeeeeeeeeeeeeeee
        mov byte[loop_count],al
        copying_loop:
            mov al,byte[ebx]
            mov byte[edx],al
            inc edx
            inc ebx
            dec byte[loop_count]
            jnz copying_loop
        pop ebx
        pop eax
        add eax,20
        sub ebx,20
        ; change 20
        dec dword[words]
        jnz word_exchange_loop

    mov eax,4
    mov ebx,1
    mov ecx,string_new
    mov edx,1000
    int 80h

    exit:
    mov eax,1
    mov ebx,0
    int 80h