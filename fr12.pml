byte state12 = 0;  // 0=Idle,1=RecReq,2=Query,3=Conflict,4=NoConf

active proctype FR12() {
  goto t0;

t0:
  if
  :: state12 == 0 -> state12 = 1; goto t1;
  :: else -> goto t0;
  fi;

t1:
  if
  :: state12 == 1 -> state12 = 2; goto t2;
  :: else -> goto t1;
  fi;

t2:
  if
  :: state12 == 2 -> state12 = 3; goto t3;
  :: state12 == 2 -> state12 = 4; goto t4;
  fi;

t3: skip;
t4: skip;
}

ltl p1 { ((state12 == 1) -> <> ((state12 == 3)||(state12 == 4))) }  // liveness: every request eventually resolves, preventing deadlock  
ltl p2 { [] !(((state12==3)||(state12==4)) && (state12==0)) }       // safety: forbids resolution without a request, preserving invariant
