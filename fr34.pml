mtype = { Waiting, Formatting, Dispatching, Logged };
mtype state;
active proctype FR34() {
    state = Waiting;
    do
    :: state == Waiting     -> state = Formatting
    :: state == Formatting  -> state = Dispatching
    :: state == Dispatching -> state = Logged
    :: state == Logged      -> break
    od
}
ltl p1 { [] ((state == Waiting) -> <> (state == Logged)) } // liveness: every alert event eventually logs

