-module(inbound_sip_gw).
-behaviour(nksip_sipapp).
-export([init/1, invite/3, register/3, get_user_pass/3,
		authorize/4, route/6, handle_call/3]).

-record(state, {
    id,
    started
}).

init([Id]) ->
    {ok, #state{id=Id, started=httpd_util:rfc1123_date()}}.

invite(_ReqId, _From, State) ->
	io:format("got invite from client ~n", []),
    {reply, decline, State}.

register(_ReqId, _From, State) ->
	io:format("enter register", []),
	{noreply, State}.

get_user_pass(_User, <<"nksip">>, State) -> 
    {reply, <<"1234">>, State};
get_user_pass(_User, _Realm, State) -> 
    {reply, false, State}.

authorize(Auth, _ReqId, _From, State) ->
    case lists:member(dialog, Auth) orelse lists:member(register, Auth) of
        true -> 
            {reply, true, State};
        false ->
            case proplists:get_value({digest, <<"nksip">>}, Auth) of
                true -> 
                    {reply, true, State};       % Password is valid
                false -> 
                    {reply, false, State};      % User has failed authentication
                undefined -> 
                    {reply, {proxy_authenticate, <<"nksip">>}, State}
                    
            end
    end.

route(_Scheme, _User, _Domain, _ReqId, _From, State) ->
    {reply, process, State}.

handle_call(get_started, _From, #state{started=Started}=State) ->
    {reply, {ok, Started}, State}.
