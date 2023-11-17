%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ;; valoarea din registrul ebx joaca rol de contor
    ;; pentru a verifica daca pasul la care suntem in
    ;; parcurgerea sirului nu este mai mare ca lungimea
    ;; sirului
    xor ebx, ebx
myloop:

    xor eax, eax
    ;; Mutam in al byte-ul de la pozitia curenta din plain
    mov al, byte [esi + ebx]
    add al, dl

    ;; Se compara litera din string cu 'Z'
    cmp al, 'Z'

    ;; Daca litera > Z, se executa cazul special 
    jg special_case

    ;; Daca nu, adaugam valoarea in enc_string
    jle normal_case

    ;; Se scade 26 din valoarea literei si se compara cu Z
special_case:

    sub al, 26
    cmp al, 'Z'
    jg special_case
    jle normal_case

normal_case:

    ;; Mutam in enc_string byte-ul shiftat stocat in al
    mov byte [edi + ebx], al

    ;; Incrementam ebx si verificam daca am ajuns la sfarsitul sirului
    inc ebx
    cmp ebx, ecx
    jl myloop

    ;; Your code ends here

    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
