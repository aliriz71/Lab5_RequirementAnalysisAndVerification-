byte state23 = 0;  // 0=Idle,1=Agg,2=Adj,3=Inv,4=Notif

active proctype FR23() {
    goto w0;

w0:
    if
    :: state23 == 0 -> state23 = 1; goto w1;
    :: else          -> goto w0;
    fi;

w1:
    if
    :: state23 == 1 -> state23 = 2; goto w2;
    :: else          -> goto w1;
    fi;

w2:
    if
    :: state23 == 2 -> state23 = 3; goto w3;
    :: else          -> goto w2;
    fi;

w3:
    if
    :: state23 == 3 -> state23 = 4; goto w4;
    :: else          -> goto w3;
    fi;

w4: skip;
}

ltl p1 { ((state23 == 1) -> <> (state23 == 4)) } // liveness: invoicing always leads to notification, preventing dead-end flows  
ltl p2 { [] !((state23 == 4) && (state23 == 0)) } // safety: prohibits notification before billing aggregation
