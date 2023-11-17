Task 1:


Pentru rezolvarea primului task am folosit urmatoarea strategie:

Am folosit registrul ebx ca un contor pentru loop-ul meu, pentru
a verifica daca am ajuns sau nu la sfarsitul sirului. 

Am stocat in subregistrul "al" byte-ul de la pozitia curenta din
plain. Am adunat in valoarea stepului stocata in "dl" peste
byte-ul de la pozitia curenta, iar apoi am comparat codul ASCII
al caracterului cu valoarea lui 'Z'.

Daca caracterul curent are valoarea ASCII mai mare ca cea a lui
'Z', sarim la label-ul "special_case", in care scadem 26 din
valoarea ASCII a byte-ului curent (26 fiind numarul de caractere
din alfabetul englez, realizand practic o "shiftare
circulara") si am tot comparat valoarea ASCII a byte-ului curent
cu valoarea lui 'Z'. Cand aceasta este mai mica sau egala
cu cea a lui 'Z', sarim la labelul normal_case, in care pur
si simplu se copiaza byte-ul "shiftat" la pozitia curenta din
sirul "enc_string".

Apoi se incrementeaza ebx-ul, se verifica daca am ajuns la
sfarsitul sirului (daca ebx < ecx) si se executa toti acesti
pasi pentru fiecare pozitie din sir.

----------------------------------------------------------------

Task 4:

Strategia a fost urmatoarea: analizam valorile lui x si y
pentru a stii daca ne aflam intr-un caz special.

Cazurile speciale sunt daca ne aflam pe: linia de sus (y = 7),
linia de jos (y = 0), coloana din stanga (x = 0), coloana din
dreapta (x = 7) si colturile tablei. 

Daca valorile lui x si y nu prezinta niciun astfel de caz, se
va scrie valoarea 1 pe orice pozitie vecina pe diagonale,
adica pe pozitiile: a[y+1][x-1], a[y-1][x-1], a[y+1][x+1] si
a[y-1][x+1].

La inceputul codului se analizeaza valorile lui x si y, apoi se
analizeaza daca suntem intr-unul din cazurile speciale.

Daca da, se sare la unul din label-urile "xzero", "xseven",
"yzero", "yseven". In aceste label-uri se verifica daca ne
aflam pe unul din colturile de pe linia sau coloana respectiva.
Daca da, se sare la label-urile pentru colturi ("stangajos",
"stangasus", "dreaptajos", "dreaptasus"), iar daca nu, se va
scrie 1 pe cele 2 pozitii valabile.

In label-urile pentru colturi se va scrie 1 pe singura
pozitie valabila.

Dupa scriere, fie ca suntem intr-un caz special sau nu, se v
face salt la sfarsitul programului.

---------------------------------------------------------------
