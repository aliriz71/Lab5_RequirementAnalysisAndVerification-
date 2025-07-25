mtype = { Idle, ReceivedRequest, QueryingDB, ConflictDetected, NoConflict };
mtype state;
active proctype FR12() {
    state = Idle;
    do
    :: state == Idle            -> state = ReceivedRequest
    :: state == ReceivedRequest -> state = QueryingDB
    :: state == QueryingDB      -> state = ConflictDetected
    :: state == QueryingDB      -> state = NoConflict
    :: (state == ConflictDetected || state == NoConflict) -> break
    od
}
ltl p1 { [] ((state == ReceivedRequest) -> <> ((state == ConflictDetected) || (state == NoConflict))) } // liveness: every request resolves to ConflictDetected or NoConflict, avoiding livelock
ltl p2 { [] (!( (state == ConflictDetected || state == NoConflict) && state == Idle)) }              // safety: forbids resolution states without a prior request, preserving invariant
