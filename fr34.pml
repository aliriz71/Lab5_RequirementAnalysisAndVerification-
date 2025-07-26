byte state34 = 0;  // 0=Waiting,1=Fmt,2=Disp,3=Logged

active proctype FR34() {
    goto x0;

x0:
    if
    :: state34 == 0 -> state34 = 1; goto x1;
    :: else -> goto x0;
    fi;

x1:
    if
    :: state34 == 1 -> state34 = 2; goto x2;
    :: else -> goto x1;
    fi;

x2:
    if
    :: state34 == 2 -> state34 = 3; goto x3;
    :: else -> goto x2;
    fi;

x3: skip;
}

ltl p1 { ((state34 == 0) -> <> (state34 == 3)) } // liveness: every alert event eventually logs, preventing lost notifications
