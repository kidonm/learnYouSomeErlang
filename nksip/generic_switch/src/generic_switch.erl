-module(generic_switch).
-export([launch/0, trace/1, loglevel/1]).


launch() ->
    ok = nksip:start(server, inbound_sip_gw, [server], 
        [
            registrar, 
            {transport, {udp, {0,0,0,0}, 5060}}
         ]),

	 ok = nksip:start(client1, simple_sip_client, [client1], 
        [
            {from, "sip:client1@nksip"},
            {transport, {udp, {127,0,0,1}, 5070}} 
        ]),

    ok = nksip:start(client2, simple_sip_client, [client2], 
        [
            {from, "sip:client2@nksip"},
            {transport, {udp, {127,0,0,1}, 5080}} 
        ]),

	nksip_uac:register(client1, "sip:127.0.0.1", [{pass, "1234"}, make_contact]),
	nksip_uac:register(client2, "sip:127.0.0.1", [{pass, "1234"}, make_contact]),
   	ok = nksip:stop_all().

-spec trace(Start::boolean()) -> ok.

trace(true) ->  nksip_trace:start();
trace(false) -> nksip_trace:stop().

-spec loglevel(debug|info|notice) -> ok.

loglevel(Level) -> lager:set_loglevel(lager_console_backend, Level).
