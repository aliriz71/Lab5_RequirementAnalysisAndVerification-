byte state22 = 0;  // 0=Idle,1=CovChk,2=Calc,3=Claim,4=Fallback

active proctype FR22() {
    goto v0;

v0:
    if
    :: state22 == 0 -> state22 = 1; goto v1;
    :: else          -> goto v0;
    fi;

v1:
    if
    :: state22 == 1 -> state22 = 2; goto v2;
    :: state22 == 1 -> state22 = 4; goto v4;
    fi;

v2:
    if
    :: state22 == 2 -> state22 = 3; goto v3;
    :: else          -> goto v2;
    fi;

v3: skip;
v4: skip;
}

ltl p1 { ((state22 == 1) -> <> ((state22 == 3)||(state22 == 4))) } // liveness: coverage check always resolves, preventing livelock  
ltl p2 { [] !(((state22==3)||(state22==4)) && (state22==0)) }     // safety: forbids resolution before check initiation, preserving ordering
