section .data
msg_yes : db 'yes, palindrome, wow, beautiful',10
l1 : equ $-msg_yes
msg_no : db 'no, not one, ew, ugly',10
l2 : equ $-msg_no
msg_n : db 'how many numbers? : ',10
l3 : equ $-msg_n
msg_read : db 'enter number',10
l4 : equ $-msg_read
newline: db '', 10

section .bss
d: resb 1
arr: resd 50
n: resd 1
num_temp: resd 1
i: resd 1
temp1: resd 1
temp2: resd 1
count_check: resb 1
sum_final: resb 1
temp_prime: resd 1
counter: resd 1
index1 : resd 1
index2 : resd 1
cc1 : resd 1
cc2 : resd 1
ii1 : resd 1
ii2 : resd 1
four : resd 1


section .text
    global _start:
    _start:

    mov eax,4
    mov ebx,1
    mov ecx,msg_n
    mov edx, l3
    int 80h

    call read_num
    mov eax,dword[num_temp]
    mov dword[n],eax

    mov ebx,arr
    call read_arr

    mov eax,dword[n]
    mov edx,0
    mov ebx,2
    div ebx
    mov dword[counter],eax

    ; counter now should store n/2
    mov dword[cc1],0
    mov eax,dword[n]
    sub eax,1
    mov dword[cc2],eax
    mov eax,4
    mov dword[four],eax
    mov ebx,arr
    

    func:
    mov eax,dword[cc1]
    mul dword[four]
    mov dword[ii1],eax

    mov eax,dword[cc2]
    mul dword[four]
    mov dword[ii2],eax

    push ebx

    add ebx, dword[ii1]
    mov eax, dword[ebx]
    mov dword[index1],eax

    pop ebx

    push ebx

    add ebx, dword[ii2]
    mov eax,dword[ebx]
    mov dword[index2],eax

    pop ebx

    push ebx

    mov ebx,dword[index1]
    mov eax,dword[index2]
    cmp eax,ebx
    jne not_palindrome

    dec dword[counter]
    mov eax,dword[counter]
    cmp eax,0
    je is_palindrome

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


read_arr:
    mov dword[i], eax
    
    element_read_loop:
        push ebx
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_read
        mov edx, l4
        int 80h
        pop ebx
    
        call read_num
        mov ecx, dword[num_temp]
        mov dword[ebx], ecx
    
        add ebx, 4
        dec dword[i]
        jnz element_read_loop
    
    ret



read_num:

    pushad
    mov dword[num_temp], 0
    
    read:
        mov eax, 3
        mov ebx, 0
        mov ecx, d
        mov edx, 1
        int 80h

        cmp byte[d], 10
        je read_exit

        sub byte[d], 30h
        mov eax, dword[num_temp]
        mov ebx, 10
        mul ebx
        mov ebx, 0
        add bl, byte[d]
        add eax, ebx
        mov dword[num_temp], eax
        jmp read

    read_exit:
        popad
        ret



print_num:
    
    pushad
    mov byte[count_check], 0
    cmp dword[num_temp], 0
    je zero

    extract:
        mov eax, dword[num_temp]
        cmp eax, 0
        je print
        
        inc byte[count_check]
        mov edx, 0
        mov ebx, 10
        div ebx
        push dx
        mov dword[num_temp], eax
        jmp extract

    print:

        cmp byte[count_check], 0
        je print_exit

        dec byte[count_check]
        pop ax
        mov byte[d], al
        add byte[d], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, d
        mov edx, 1
        int 80h
        jmp print

    zero:
        mov byte[d], 30h
        mov eax, 4
        mov ebx, 1
        mov ecx, d
        mov edx, 1
        int 80h

    
    print_exit:
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 80h

        popad
        ret
