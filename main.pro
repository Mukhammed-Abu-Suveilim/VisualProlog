implement main
    open core, stdio

domains
% id = integer.
%name = string.
    инфоАптеки = инфоАптеки(string НазваниеАптеки, string Адрес).
    инфоЛекарства = инфоЛекарства(string НазваниеЛекарства).

class facts - factdb
    аптека : (integer IdАптеки, string НазваниеАптеки, string Адрес, string Телефон).
    лекарство : (integer IdЛекарства, string НазваниеЛекарства).
    продает : (integer IdАптеки, integer IdЛекарства, integer Цена, integer Количество).

class predicates
    length : (A*) -> integer N.
    sum_elem : (real* List) -> real Sum.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    sum_elem([]) = 0.
    sum_elem([H | T]) = sum_elem(T) + H.

class predicates
    /*
    list_show : (string NameCinema) -> show_info* determ.
    list_film : (string NameCinema) -> string* Films determ.
    amount_of_film : (string NameCinema) -> integer N determ.
    list_cinema : (string NameFilm) -> string* Cinemas determ.
    film_profit : (string NameFilm) -> real Film_profit determ.
    list_film_info : (string NameCinema) -> film_info* determ.
    list_cinema_info : (string NameFilm) -> cinema_info* determ.
*/
    вывод_аптеки : (string НазваниеАптеки) -> string* Аптеки determ.
    вывод_лекарства : (string НазваниеЛекарства) -> string* Лекарства determ.
    %количество_лекарств : (integer Количество) -> integer N determ.

clauses
    %Написать названия фильмов, которые показывали в кинотеатре, и количество показываемых фильмов.
/*
    list_film(NameCinema) = ListFilm :-
        cinema(IdCinema, NameCinema, _, _, _),
        !,
        ListFilm =
            [ NameFilm ||
                show(IdCinema, IdFilm, _, _, _),
                film(IdFilm, NameFilm, _, _, _)
            ].
    amount_of_film(NameCinema) = length(list_film(NameCinema)).
*/
    вывод_аптеки(НазваниеАптеки) = Выводаптеки :-
        аптека(_, НазваниеАптеки, Адрес, _),
        !,
        Выводаптеки = [ НазваниеАптеки || аптека(_, НазваниеАптеки, Адрес, _) ].
        %Написать называния кинотеатров, в которых показывают этот фильм
/*    list_cinema(NameFilm) = ListCinema :-
        film(IdFilm, NameFilm, _, _, _),
        !,
        ListCinema =
            [ NameCinema ||
                show(IdCinema, IdFilm, _, _, _),
                cinema(IdCinema, NameCinema, _, _, _)
            ].
*/
    вывод_лекарства(НазваниеАптеки) = Выводлекарства :-
        лекарство(_, НазваниеЛекарства),
        !,
        Выводлекарства = [ НазваниеАптеки || лекарство(_, НазваниеЛекарства) ].

class predicates
/*
    write_film_info : (film_info* X).
    write_cinema_info : (cinema_info* X).
    write_show_info : (show_info* X).
*/
    выводИнфоАптеки : (инфоАптеки* Х).
    выводИнфоЛекарства : (инфоЛекарства* Х).

clauses
    выводИнфоАптеки(E) :-
        foreach инфоАптеки(НазваниеАптеки, Адрес) = list::getMember_nd(E) do
            writef("\t%s\t%s\n", НазваниеАптеки, Адрес)
        end foreach.
    выводИнфоЛекарства(E) :-
        foreach инфоЛекарства(НазваниеЛекарства) = list::getMember_nd(E) do
            writef("\t%s\n", НазваниеЛекарства)
        end foreach.
/*
    write_film_info(L) :-
        foreach film_info(NameFilm, PublishingYear, Director, Genre) = list::getMember_nd(L) do
            writef("\t%s\t%s\t%s\t%s\n", NameFilm, PublishingYear, Director, Genre)
        end foreach.
    write_cinema_info(L) :-
        foreach cinema_info(NameCinema, Address, Telephone) = list::getMember_nd(L) do
            writef("\t%s\t%s\t%s\n", NameCinema, Address, Telephone)
        end foreach.
    write_show_info(L) :-
        foreach show_info(NameFilm, Date, Time, TkPrice) = list::getMember_nd(L) do
            writef("\t%s\t%s\t%s\t%s\n", NameFilm, Date, Time, toString(TkPrice))
        end foreach.
*/

clauses
    run() :-
        console::init(),
        file::consult("..\\factsdatabase.txt", factdb),
        fail.
    run() :-
        НазваниеАптеки = "Горздрав",
        L = вывод_аптеки(НазваниеАптеки),
        write("Название аптеки ", НазваниеАптеки, "\n"),
        write(L),
        nl,
        fail.
    run() :-
        НазваниеАптеки = "Ригла",
        L = вывод_аптеки(НазваниеАптеки),
        write("Название аптеки ", НазваниеАптеки, "\n"),
        write(L),
        nl,
        fail.
    run() :-
        НазваниеАптеки = "Эвалар",
        L = вывод_аптеки(НазваниеАптеки),
        write("Название аптеки ", НазваниеАптеки, "\n"),
        write(L),
        nl,
        fail.
    run() :-
        НазваниеЛекарства = "Ксилометазолин",
        L = вывод_лекарства(НазваниеЛекарства),
        write("Название лекарства ", НазваниеЛекарства, "\n"),
        write(L),
        nl,
        fail.
    run() :-
        НазваниеАптеки = "36,6",
        L = вывод_аптеки(НазваниеАптеки),
        write("Название аптеки ", НазваниеАптеки, "\n"),
        write(L),
        nl,
        fail.
/*
    run() :-
        N = length([]),
        %write("Название аптеки ", НазваниеАптеки, "\n"),
        write(N),
        nl,
        fail.
*/
    run() :-
        succeed.

end implement main

goal
    console::run(main::run).
