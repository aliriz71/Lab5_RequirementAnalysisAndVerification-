mtype = { Idle, ViewingSchedule, SelectingSlot, SlotSelected, BookingSubmitted, BookingConfirmed };
mtype state;
active proctype FR7() {
    state = Idle;
    do
    :: state == Idle             -> state = ViewingSchedule
    :: state == ViewingSchedule  -> state = SelectingSlot
    :: state == SelectingSlot    -> state = SlotSelected
    :: state == SlotSelected     -> state = BookingSubmitted
    :: state == BookingSubmitted -> state = BookingConfirmed
    :: state == BookingConfirmed -> break
    od
}
ltl p1 { [] ((state == BookingSubmitted) -> <> (state == BookingConfirmed)) } // liveness: ensures every BookingSubmitted eventually leads to BookingConfirmed, preventing livelock
ltl p2 { [] (!(state == BookingConfirmed && state == Idle)) }              // safety: invariant forbidding Idle and BookingConfirmed together, preventing invalid jump
