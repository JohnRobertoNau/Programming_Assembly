section .data
	; declare global vars here
section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	push ebp
	xor ebp, ebp
	add ebp, esp	;; mov ebp, esp
	sub esp, 4
	
	xor ebx, ebx
	add ebx, [ebp + 8]		;; ebx -> sirul de caractere
	xor ecx, ecx			;; ecx -> indexul loop-ului

	;; Mutam in ecx valoarea -1 pentru ca atunci cand intra in
	;; loop, sa intre cu valoarea 0
	dec ecx

search_vowels:
	;; Vom parcurge sirul nostru pentru a identifica vocale
	inc ecx

	;; Mutam in 'al' valoarea byte-ului curent
	xor eax, eax
	add al, byte [ebx + ecx]

	;; Verificam daca am ajuns la sfarsitul sirului,
	;; daca da, sarim la end_search
	test al, al
	jz end_search

	;; Verificam daca byte-ul curent este vocala
	;; Daca da, vom da push pe stiva
	cmp al, 'a'
	je push_vowel

	cmp al, 'e'
	je push_vowel

	cmp al, 'i'
	je push_vowel

	cmp al, 'o'
	je push_vowel

	cmp al, 'u'
	je push_vowel

	;; Ne intoarcem la parcurgere
	jmp search_vowels

push_vowel:
	;; 'Push' pe stiva a vocalei si ne intoarcem la parcurgere
	push eax

	;; Ne intoarcem la parcurgere
	jmp search_vowels

end_search:
	;; Reinitializam counter-ul la -1 pentru a parcurge din nou sirul
	xor ecx, ecx
	dec ecx

	;; Acum ca am identificat toate vocalele din string,
	;; vom parcurge din nou vectorul ca sa dam pop la vocale
replace_vowels:
	inc ecx

	;; Mutam in 'al' byte-ul curent
	xor eax, eax
	add al, byte [ebx + ecx]

	;; Verificam daca am ajuns la sfarsitul sirului
	;; Daca da, sarim la end_replace
	test al, al
	jz end_replace

	cmp al, 'a'
	je pop_vowel

	cmp al, 'e'
	je pop_vowel

	cmp al, 'i'
	je pop_vowel

	cmp al, 'o'
	je pop_vowel

	cmp al, 'u'
	je pop_vowel

	;; Ne intoarcem la parcurgere
	jmp replace_vowels

pop_vowel:
 	pop eax
	
	;; Mutam vocala de pe stiva din 'al' in pozitia curenta a byte-ului
	xor edx, edx
	add dl, byte [ebx + ecx]
	sub byte [ebx + ecx], dl	;; acum byte [ebx + ecx] este 0
	add byte [ebx + ecx], al	

	;; Ne intoarcem la parcurgere
 	jmp replace_vowels

end_replace:
	pop ebx
	xor esp, esp
	add esp, ebp		;; mov esp, ebp
	pop ebp
 	
	ret