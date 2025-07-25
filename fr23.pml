mtype = { Idle, AggregateCharges, ApplyAdjustments, InvoiceCreated, NotifySent };
mtype state;
active proctype FR23() {
    state = Idle;
    do
    :: state == Idle             -> state = AggregateCharges
    :: state == AggregateCharges -> state = ApplyAdjustments
    :: state == ApplyAdjustments -> state = InvoiceCreated
    :: state == InvoiceCreated   -> state = NotifySent
    :: state == NotifySent       -> break
    od
}
ltl p1 { [] ((state == AggregateCharges) -> <> (state == NotifySent)) } // liveness: every AggregateCharges eventually leads to NotifySent, preventing dead-end flows
ltl p2 { [] (!(state == NotifySent && state == Idle)) }                // safety: forbids NotifySent before billing steps, ensuring correct sequence
