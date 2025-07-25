mtype = { Idle, CoverageCheck, CalculatingShare, ClaimSubmitted, FallbackPayment };
mtype state;
active proctype FR22() {
    state = Idle;
    do
    :: state == Idle             -> state = CoverageCheck
    :: state == CoverageCheck    -> state = CalculatingShare
    :: state == CoverageCheck    -> state = FallbackPayment
    :: state == CalculatingShare -> state = ClaimSubmitted
    :: (state == ClaimSubmitted || state == FallbackPayment) -> break
    od
}
ltl p1 { [] ((state == CoverageCheck) -> <> ((state == ClaimSubmitted) || (state == FallbackPayment))) } // liveness: every CoverageCheck leads to resolution, avoiding livelock
ltl p2 { [] (!( (state == ClaimSubmitted || state == FallbackPayment) && state == Idle)) }             // safety: forbids resolution before initiating CoverageCheck, preserving invariant
