	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC A */

	case 5: // STATE 1
		;
		_m = unsend(now.ch);
		;
		goto R999;

	case 6: // STATE 2
		;
		XX = 1;
		unrecv(now.ch, XX-1, 0, ((int)now.x), 1);
		now.x = trpt->bup.oval;
		;
		;
		goto R999;

	case 7: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;
	}

