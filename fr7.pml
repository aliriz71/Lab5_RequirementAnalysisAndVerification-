byte state7 = 0;   // 0=Idle,1=Viewing,2=Selecting,3=SlotSel,4=Subm,5=Conf

active proctype FR7() {
  goto s0;

s0:
  if
  :: state7 == 0 -> state7 = 1; goto s1;
  :: else -> goto s0;
  fi;

s1:
  if
  :: state7 == 1 -> state7 = 2; goto s2;
  :: else -> goto s1;
  fi;

s2:
  if
  :: state7 == 2 -> state7 = 3; goto s3;
  :: else -> goto s2;
  fi;

s3:
  if
  :: state7 == 3 -> state7 = 4; goto s4;
  :: else -> goto s3;
  fi;

s4:
  if
  :: state7 == 4 -> state7 = 5; goto s5;
  :: else -> goto s4;
  fi;


s5: 
  if
  :: state7 == 5 -> goto done;
  :: else -> goto s5;
  fi;

done:
  skip;

}

ltl p1 { ((state7 == 4) -> <> (state7 == 5)) }  // liveness: every submission eventually confirms, preventing livelock  
ltl p2 { [] !((state7 == 5) && (state7 == 0)) } // safety: forbids Idle to Confirmed jump, preserving workflow
