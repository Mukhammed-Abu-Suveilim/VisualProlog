implement main
    open core, stdio

domains
    /*unit = лет; год; года.*/
    id = integer.
    name = string.

class facts - factsDb
    аптека : (id IdАптеки, name НазваниеАптеки, string Адрес, string Телефон).
    лекарство : (id IdЛекарства, name НазваниеЛекарства).
    продает : (id IdАптеки, id IdЛекарства, integer Цена, integer Количество).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    адрес : (name НазваниеАптеки) nondeterm.
    телефон : (name НазваниеАптеки) nondeterm.
    доступные_лекарства : (name НазваниеЛекарства) nondeterm.

clauses
    адрес(X) :-
        аптека(_, X, Адрес, _),
        writef("\tАдрес аптеки %: %.\n", X, Адрес),
        fail.

    телефон(X) :-
        аптека(_, X, _, Телефон),
        writef("\tТелефон аптеки %: %.\n", X, Телефон),
        fail.

    доступные_лекарства(X) :-
        лекарство(IdЛекарства, X),
        продает(IdАптеки, IdЛекарства, _, Количество),
        Количество > 0,
        аптека(IdАптеки, НазваниеАптеки, _, _),
        writef("\tЛекарство % доступно в аптеки %.\n", X, НазваниеАптеки),
        fail.

clauses
    run() :-
        file::consult("../factsbase.txt", factsDb),
        fail.

    run() :-
        адрес("Горздрав"),
        fail.

    run() :-
        телефон("телефон"),
        fail.

    run() :-
        доступные_лекарства("Ибупрофен"),
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
