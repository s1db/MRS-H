never  {    /* ! ([](q -> <>r)) */
T0_init:
	do
	:: (! ((r)) && (q)) -> goto accept_S4
	:: (1) -> goto T0_init
	od;
accept_S4:
	do
	:: (! ((r))) -> goto accept_S4
	od;
}
