# Online Course Reservation System

## Functional requirements

Functional requirements describe what the system shall do. Assume the college provides student and administrator accounts, and students reserve one seat at a time in a specific course offering.

- **FR-01 Browse course offerings.** The system shall let students browse open offerings and see their course name, schedule, and available seats.
- **FR-02 Reserve a seat.** The system shall let a signed-in student reserve a seat in an open offering, confirm the reservation, and reduce the available seat count by one. It shall reject reservations for closed or full offerings and duplicate active reservations by the same student.
- **FR-03 View reservations.** The system shall let signed-in students view their own reservations and their current status.
- **FR-04 Cancel a reservation.** The system shall let students cancel their own active reservations and release the corresponding seats.
- **FR-05 Manage course offerings.** The system shall let authorized administrators create and update offerings, set their seat limits, and open or close reservations. It shall reject seat limits below the number of active reservations.
- **FR-06 View course rosters.** The system shall let authorized administrators view the list of students with active reservations for each offering.

## Non-functional requirements

Non-functional requirements describe how well the system shall work and what constraints it shall satisfy. The numerical targets below are proposed for lab testing.

- **NFR-01 Performance.** With 50 concurrent users, at least 95% of browse and reservation requests shall respond within 2 seconds.
- **NFR-02 Security.** Protected functions shall require authentication. Access tests shall verify that students cannot read or cancel another student's reservation or use administrator functions. The deployed system shall use HTTPS for sign-in and authenticated pages.
- **NFR-03 Reliability.** When two eligible students request the last seat at the same time, exactly one reservation shall succeed. Failed requests shall leave the seat count and reservation records consistent.
- **NFR-04 Usability.** Browse, reserve, view, and cancel shall work in desktop and mobile browsers at viewport widths of 1280 and 360 pixels without horizontal scrolling.
- **NFR-05 Availability.** The service shall be reachable at least 99% of the time during the published reservation period, measured by one availability check per minute.