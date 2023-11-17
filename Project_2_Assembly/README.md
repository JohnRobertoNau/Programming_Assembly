Task 1:
             
Pentru primul task am folosit urmatoarea strategie: am parcurs sirul de
caractere, verificand daca intalnim vocale. Daca da, dam push pe stiva
la vocalele respective. Dupa ce am terminat de parcurs si de dat push,
am parcurs din nou vectorul. De data aceasta, am verificat daca intalnim
vocale, iar daca da, dam pop de pe stiva la pozitia respectiva.

Deoarece stiva functioneaza dupa regula LIFO, daca parcurgem sirul de
la inceput ca sa dam pop, vocalele vor aparea in ordine inversa, exact
cum este cerut in cerinta.

Pentru inceput stocam in ebx adresa sirului de caractere si folosim
registrul ecx pentru counterul loop-ului.

Prima parcurgere: incrementam counterul, acesta pornind de la valoarea 0.
Mutam in 'al' caracterul curent din sir si apoi verificam cu ajutorul
instructiunii 'test' daca am ajuns la sfarsitul sirului. Daca da, sarim
la instructiunea end_search. Daca nu, verificam daca caracterul este vocala.
Daca este vocala sarim la label-ul push_vowel unde dam push pe stiva
caracterului si ne intoarcem inapoi la parcurgere.

A doua parcurgere: counter-ul incepe din nou de la -1, si se parcurge in
mod analog sirul, dandu-se pop de pe stiva la pozitiile unde se intalnesc
vocale.

----------------------------------------------------------------------------

Bonus 1:

Lucrand pe o arhitectura de 64 bits, primii 5 parametrii sunt stocati in
rdi, rsi, rdx, rcx, r8.

M-am folosit de registrul r9 ca si counter pentru v1 si v2. 'rax' este un
registru auxiliar de care m-am folosit ca sa construiesc noul vector v,
iar r10 este counter-ul acestui vector.

Pentru inceput, verificam daca am ajuns la sfarsitul unuia dintre vectorii
v1 si v2, daca nu se construieste vectorul v intercaland v1 si v2.

Daca am ajuns la sfarsitul unuia dintre vectori, adaugam restul vectorului
mai lung in vectorul rezultat v, fie in labelul first_end, fie in
second_end, depinde de care vector este mai scurt.

Dupa terminarea intercalarii, se sare la label-ul end unde este sfarsitul
programului.

----------------------------------------------------------------------------
