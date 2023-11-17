
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ;; Verificam daca x = 0
    mov edx, 0
    cmp eax, edx
    je xzero

    ;; Verificam daca y = 0
    mov edx, 0
    cmp ebx, edx
    je yzero

    ;; Verificam daca x = 7
    mov edx, 7
    cmp eax, edx
    je xseven

    ;; Verificam daca y = 7
    mov edx, 7
    cmp ebx, edx
    je yseven

    ;; Daca nu suntem in niciun caz dintre cele de mai sus
    ;; se va scrie 1, fara restrictii, pe toate pozitiile 
    ;; vecine de pe diagonale, adica:
    ;; a[y+1][x-1] a[y-1][x-1] a[y+1][x+1] a[y-1][x+1]

    ;; vom stoca in edx suma ecx + ebx, pentru a nu folosi 3
    ;; registrii in accesarea lui a[y][x]
    ;; Astfel byte [ecx + 8 * eax + ebx] va deveni byte [edx + 8 * eax]

    ;; a[y+1][x-1]
    inc ebx                         ;; y++
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    inc eax                         ;; x--

    ;; a[y-1][x-1]
    dec ebx                         ;; y--
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    inc eax                         ;; x++

    ;; a[y+1][x+1]
    inc ebx                         ;; y++
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    dec eax                         ;; x--

    ;; a[y-1][x+1]
    dec ebx                         ;; y--
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    dec eax                         ;; x--

    jmp end

yzero:

    ;; Verificam daca x = 0
    mov edx, 0
    cmp eax, edx
    je stangajos

    ;;Verificam daca x = 7
    mov edx, 7
    cmp eax, edx
    je dreaptajos

    ;; Daca nu ne aflam in colturile liniei de jos
    ;; vom scrie 1 pe pozitiile a[y+1][x-1] si a[y+1][x+1]

    ;; a[y+1][x-1]
    inc ebx                         ;; y++
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    inc eax                         ;; x++

    ;; a[y+1][x+1]
    inc ebx                         ;; y++
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    dec eax                         ;; x--

    jmp end

xzero:

    ;; Verificam daca suntem in coltul din stanga-jos, adica y = 0
    mov edx, 0
    cmp ebx, edx
    je stangajos

    ;; Verificam daca suntem in coltul din stanga-sus, y = 7
    mov edx, 7
    cmp ebx, edx
    je stangasus

    ;; Daca nu suntem in colturile stanga-jos, stanga-sus ale coloanei din
    ;; stanga, se va scrie 1 pe pozitiile a[y+1][x+1] si a[y-1][x+1]
    
    ;; a[y+1][x+1]
    inc ebx                         ;; y++
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    dec eax                         ;; x--

    ;; a[y-1][x+1]
    dec ebx                         ;; y--
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    dec eax                         ;; x--

    jmp end

xseven:

    ;; Verificam daca y = 0
    mov edx, 0
    cmp ebx, edx
    je dreaptajos

    ;; Verificam daca y = 7
    mov edx, 7
    cmp ebx, edx
    je dreaptasus

    ;; Daca nu suntem in colturile dreapta-jos, dreapta-sus ale coloanei din dreapta
    ;; se va scrie 1 pe pozitiile a[y+1][x-1] si a[y-1][x-1]

    ;; a[y+1][x-1]
    inc ebx                         ;; y++
    dec eax                         ;; x--
    xor edx, edx                    ;; edx =0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    inc eax                         ;; x++

    ;; a[y-1][x-1]
    dec ebx                         ;; y--
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    inc eax                         ;; x++

    jmp end

yseven:

    ;; Verificam daca x = 0
    mov edx, 0
    cmp eax, edx
    je stangasus

    ;; Verificam daca x = 7
    mov edx, 7
    cmp eax, edx
    je dreaptasus

    ;; Daca nu suntem in colturile liniei de sus, se va scire 1
    ;; pe pozitiile a[y-1][x-1] si a[y-1][x+1]

    ;; a[y-1][x-1]
    dec ebx                         ;; y--
    dec eax                         ;; x--
    xor edx, edx                    ;; x = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    inc eax                         ;; x++

    ;; a[y-1][x+1]
    dec ebx                         ;; y--
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    dec eax                         ;; x--

    jmp end

stangajos:

    ;; Se va scrie 1 doar pe pozitia a[y+1][x+1]
    inc ebx                         ;; y++
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    dec eax                         ;; x--

    jmp end

stangasus:

    ;; Se va scrie 1 doar pe pozitia a[y-1][x+1]
    dec ebx                         ;; y--
    inc eax                         ;; x++
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x+1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    dec eax                         ;; x--

    jmp end

dreaptajos:

    ;; Se va scrie 1 doar pe pozitia a[y+1][x-1]
    inc ebx                         ;; y++
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y+1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    dec ebx                         ;; y--
    inc eax                         ;; x++

    jmp end

dreaptasus:

    ;; Se va scrie 1 doar pe pozitia a[y-1][x-1]
    dec ebx                         ;; y--
    dec eax                         ;; x--
    xor edx, edx                    ;; edx = 0
    mov edx, ecx                    ;; edx = ecx
    add edx, ebx                    ;; edx += ebx
    mov byte [edx + 8 * eax], 1     ;; a[y-1][x-1] = 1
    xor edx, edx                    ;; edx = 0
    inc ebx                         ;; y++
    inc eax                         ;; x++

    jmp end
    
end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY