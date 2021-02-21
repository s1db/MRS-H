init { /* file: ex.1a */
    byte i = 0;
    do
    ::atomic{(i==10)->break}
    ::atomic{else->i = i+1}
    od
}