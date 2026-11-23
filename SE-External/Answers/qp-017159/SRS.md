# Online Course Reservation System

## Functional requirements

Functional requirements describe what the system shall do. Assume students and administrators already have accounts, and students reserve seats in individual course offerings.

- **FR-01 — Sign in.** The system shall authenticate students and administrators and show the features available to their role.
- **FR-02 — Browse courses.** The system shall let students view open course offerings with the title, schedule and available seat count.
- **FR-03 — Reserve a seat.** The system shall let a student reserve a seat in an open offering if a seat is available and the student has no active reservation for that offering. It shall confirm a successful reservation or explain why the request was rejected.
- **FR-04 — View reservations.** The system shall let students view their own reservations and their status.
- **FR-05 — Cancel a reservation.** The system shall let students cancel their own active reservations and release the seats for other students.
- **FR-06 — Manage course offerings.** The system shall let administrators add offerings, edit schedules and seat limits, and open or close reservations. It shall reject a new seat limit below the number of active reservations.

## Non-functional requirements

Non-functional requirements describe how well the system shall work and the constraints it shall meet. The times and workload below are proposed lab targets.

- **NFR-01 — Performance.** At least 95% of course list and reservation requests shall finish within two seconds in a lab test with 50 concurrent users.
- **NFR-02 — Security.** The system shall use HTTPS and enforce role and ownership checks on the server. In an access test, a student shall be denied access to another student's reservation and to course administration.
- **NFR-03 — Data consistency.** When two students request the last seat at the same time, the system shall confirm exactly one reservation and the available seat count shall remain nonnegative.
- **NFR-04 — Reliability.** Confirmed reservations and cancellations shall retain their recorded status after an application restart.
- **NFR-05 — Usability.** Students shall be able to browse, reserve and cancel using a desktop browser at 1280 px and a mobile browser at 360 px without horizontal scrolling.