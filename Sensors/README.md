Am impartit programul in subprograme. Am creat o functie "print_simple" care
afiseaza senzorii si informatiile acestora. Pentru a tine cont de prioritati,
am "sortat" vectorul de senzori in main, folosinf o copie.

Dupa aceea am folosit o functie "deleteSensor" pentru a sterge un senzor
de la un anumit index, ulterior eliberandu-i memoria si realocand
vectorul. In functia "clear" am verificat daca senzorii din vector
contin valori eronate, iar daca contin valori eronate, se va apela
functia deleteSensor pentru a-i sterge.

Am folosit functia analyze pentru a executa operatiile respective din vectorul
de operatii al senzorului de la indexul respectiv.

Am folosit functia freeSensor care elibereaza memoria dintr-un anumit vector.

In main am facut citirile necesare din fisierul binar, am creat o copie a
vectorului de senzori care contine senzorii in ordinea prioritatilor, am
eliberat vechea memorie din vectorul principal si i-am atribuit senzorii in
ordinea prioritatilor. Dupa aceea, am declarat un vector de operatii cu 8
elemente (deoarece atatea operatii sunt in scheletul de cod). M-am folosit
de un si "aux" pentru a identifica instructiunile de la tastatura.

Cu ajutorul instructiunii while am creat un loop care se va opri la citirea
comenzii exit. In while se verifica daca comenzile de la tastatura sunt: print,
analyze, clear sau exit. Deoarece la tastatura se pot oferi indecsi negativi,
m-am folosit de un sir auxiliar "str_aux" astfel: am cautat cu ajutorul
functiei strchr subsirul care contine caracterul space si am verificat daca
caracterul de dupa spatiu este '-', pentru a stii daca este un numar negativ.
Apoi am cautat intregul numar dat ca index, verificand daca fiecare caracter
este intre '0' si '9'. Daca numarul este negativ, variabila 'n' care
reprezinta indexul va fi inmultita cu sign (care in acest caz este -1) si va
fi transmis catre functie. Aceasta abordare este folosita pentru
instructiunile print si analyze. 

La intalnirea comenzii clear se apeleaza functia clear, iar la intalnirea
comenzii exit se elibereaza memoria, se inchide fisierul si se iese din
while.

Punctajul oferit de checkerul local este 100 / 100.