-module(erldocker_app).
-behaviour(application).

%% Application callbacks
-export([start/0,
         start/2,
         stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
    start_deps(erldocker, permanent).

start_deps(App, Type) ->
    case application:start(App, Type) of
        ok ->
            ok;
        {error, {not_started, Dep}} ->
            start_deps(Dep, Type),
            start_deps(App, Type)
    end.

start(_StartType, _StartArgs) ->
    {ok, _Pid} = hackney:start_pool(erldocker_pool, [{timeout, 150000}, {pool_size, 1}]),

    erldocker_sup:start_link().



stop(_State) ->
    hackney:stop_pool(erldocker_pool),

    ok.
