section .text
	global intertwine

;; void intertwine(int *v1, int n1, int *v2, int n2, int *v);
;
;  Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2,
;  and intertwine them
;  The resulting array is stored in v
intertwine:
	push	rbp
	mov 	rbp, rsp

	;; rdi = v1
	;; rsi = n1
	;; rdx = v2
	;; rcx = n2
	;; r8 = v, noul vector intercalat
	
	xor r9, r9 			;; counter pentru v1 si v2
	xor rax, rax		;; registru auxiliar
	xor r10, r10		;; counter-ul vectorului rezultat

intercalare:
	;; Verificam daca am ajuns la sfarsitul primului vector
	;; daca da, sarim la first_end
	cmp r9, rsi
	jge first_end

	;; Verificam daca am ajuns la sfarsitul celui de-al 2lea vector
	;; daca da, sarim la second_end
	cmp r9, rcx
	jge second_end

	mov rax, [rdi + r9 * 4]		;; x = v1[i]
	mov [r8 + r10 * 4], rax  	;; v[i] = v1[i]
	inc r10

	mov rax, [rdx + r9 * 4]		;; x = v2[i]
	mov [r8 + r10 * 4], rax		;; v[i+1] = v2[i]
	inc r10

	inc r9

	jmp intercalare

second_end:
	;; Daca am ajuns si la sfarsitul primului vector
	;; atunci sarim la end
	cmp r9, rsi
	jge end

	;; am ajuns la sfarsitul celui de al 2lea vector deci v[i] = v1[i]
	mov rax, [rdi + r9 * 4]
	mov [r8 + r10 * 4], rax
	inc r9
	inc r10
	jmp second_end
    

first_end:
	;; Daca am ajuns si la sfarsitul celui de-al 2lea vector
	;; atunci sarim la end
	cmp r9, rcx
	jge end

	;; sfarsitul primulului vectoR, deci v[i] = v2[i]
	mov rax, [rdx + r9 * 4]		;; x = v2[i]
	mov [r8 + r10 * 4], rax		;; v[i] = v2[i]
	inc r9
	inc r10
	jmp first_end

end:
	leave
	ret
