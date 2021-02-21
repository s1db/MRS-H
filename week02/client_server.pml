/* A client-server model from the SPIN book, chapter 15, p. 341, illustrates Dynamic Process Creation */

#define N	2

mtype = { request, deny, hold, grant, return };

chan server = [0] of { mtype, chan };

proctype Agent(chan listen, talk)
{
	do
	:: talk!hold(listen)
	:: talk!deny(listen) -> break
	:: talk!grant(listen) ->
wait:		listen?return; break
	od;
	server!return(listen)
}

active proctype Server()
{	chan agents[N] = [0] of { mtype };
	chan pool = [N] of { chan };
	chan client, agent;
	byte i;

	do
	:: i < N -> pool!agents[i]; i++
	:: else -> break
	od;

end:	do
	:: server?request(client) ->
		if
		:: empty(pool) ->
			client!deny(0)
		:: nempty(pool) ->
			pool?agent;
			run Agent(agent,client)
		fi
	:: server?return(agent) ->
		pool!agent
	od
}

#define M	3
/* #define timeout	true */
#define timeout	(_nr_pr <= N+M)

active [M] proctype Client()
{	chan me = [0] of { mtype, chan };
	chan agent;

end:	do
	:: timeout ->
		server!request(me);
		do
		:: me?hold(agent)
		:: me?deny(agent) ->
			break
		:: me?grant(agent) ->
			agent!return;
			break
		od
	od
}
