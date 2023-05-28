implement main
    open core, stdio

domains
    /*unit = лет; год; года.*/
    id = integer.
    name = string.

class facts - factsDb
    /*
    publisher : (integer Id, string Название, string Темы, integer Price).
    reader : (integer Id_чел, string Имя, integer Возраст, unit Unit, string Дом).
    sub : (integer Id_чел, integer Id).
    */
    аптека : (id IdАптеки, name НазваниеАптеки, string Адрес, integer Телефон).
    лекарство : (id IdЛекарства, name НазваниеЛекарства).
    продает : (id IdАптеки, id IdЛекарства, integer Цена, integer Количество).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    /*
    тема : (string Тема) nondeterm anyflow.
    подписка : (string Name) nondeterm anyflow.
    бд_читателей : (integer Id_чел) failure.
    все : () failure.
    */
    адрес : (name НазваниеАптеки) nondeterm.
    телефон : (name НазваниеАптеки) nondeterm.
    доступные_лекарства : (name НазваниеЛекарства) nondeterm.

clauses
    /*
    тема(Topic) :-
        publisher(_, Name, Topic, _),
        write("\n", Name, " ", Topic),
        write("\n"),
        fail.

    подписка(Name) :-
        publisher(_, Name, _, Price),
        sum(Sum),
        assert(sum(Sum + Price * 30)),
        fail.

    подписка(Name) :-
        publisher(_, Name, _, _),
        sum(Sum),
        write("\n", Name, " ", Sum),
        write("\n"),
        fail.

    бд_читателей(X) :-
        sub(X, Y),
        publisher(Y, Name, _, _),
        reader(X, Info, _, _, _),
        write("\n", Info, " ", Name),
        fail.

    все() :-
        sub(X, Y),
        publisher(Y, Name, _, _),
        reader(X, Info, _, _, _),
        write("\n", Info, " ", Name),
        fail.
       */
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
