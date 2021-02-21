	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
	/* 0 */	((P0 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 4: // STATE 5
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 5: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;
	}

