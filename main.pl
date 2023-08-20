:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_server_files)).

% Defina a rota para a página principal
:- http_handler(root(.), main_page, []).

% Página principal que gera uma lista de itens
main_page(_Request) :-
    format('Content-type: text/html~n~n'),
    format('<html>~n', []),
    format('<head><title>Lista de Itens</title></head>~n', []),
    format('<body>~n', []),
    format('<h1>Lista de Itens</h1>~n', []),
    format('<ul>~n', []),
    generate_item_list(5), % Gere uma lista de 5 itens
    format('</ul>~n', []),
    format('</body></html>~n', []).

% Gera uma lista de itens com base no número fornecido
generate_item_list(0) :- !.
generate_item_list(N) :-
    format('<li>Item ~w</li>~n', [N]),
    Next is N - 1,
    generate_item_list(Next).

% Inicie o servidor na porta 8080
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Inicie o servidor na porta 8080 quando o arquivo for carregado
:- initialization(server(8080)).
