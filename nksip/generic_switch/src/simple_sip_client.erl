-module(simple_sip_client).
-behaviour(nksip_sipapp).
-export([init/1, invite/3, options/3]).

-record(state, {
    id
}).

init([Id]) ->
    {ok, #state{id=Id}}.

invite(ReqId, From, #state{id=AppId}=State) ->
    SDP = nksip_request:body(AppId, ReqId),
    case nksip_sdp:is_sdp(SDP) of
        true ->
            Fun = fun() ->
                nksip_request:reply(AppId, ReqId, ringing),
                timer:sleep(2000),
                nksip:reply(From, {ok, [], SDP})
            end,
            spawn(Fun),
            {noreply, State};
        false ->
            {reply, {not_acceptable, <<"Invalid SDP">>}, State}
    end.



options(_ReqId, _From, #state{id=Id}=State) ->
    Headers = [{"NkSip-Id", Id}],
    Opts = [make_contact, make_allow, make_accept, make_supported],
    {reply, {ok, Headers, <<>>, Opts}, State}.
