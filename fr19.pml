mtype = { Monitoring, AbnormalDetected, AlertCreated };
mtype state;
active proctype FR19() {
    state = Monitoring;
    do
    :: state == Monitoring       -> state = AbnormalDetected
    :: state == AbnormalDetected -> state = AlertCreated
    :: state == AlertCreated     -> break
    od
}
ltl p1 { [] ((state == Monitoring) -> <> (state == AlertCreated)) } // liveness: every Monitoring event eventually generates AlertCreated

