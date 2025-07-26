byte state19 = 0;  // 0=Monitoring,1=Abnormal,2=AlertCreated

active proctype FR19() {
    goto u0;

u0:
    if
    :: state19 == 0 -> state19 = 1; goto u1;
    :: else          -> goto u0;
    fi;

u1:
    if
    :: state19 == 1 -> state19 = 2; goto u2;
    :: else          -> goto u1;
    fi;

u2: skip;
}

ltl p1 { ((state19 == 0) -> <> (state19 == 2)) }  // liveness: every monitoring event eventually creates an alert, avoiding silent failures
