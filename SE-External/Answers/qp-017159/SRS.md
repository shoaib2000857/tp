# Online Course Reservation System

## Functional requirements

Functional requirements describe what the system shall do. Assumption for this exercise is that each course offering has a fixed seat capacity and that a reservation holds one seat for one student.

- **FR-01. Browse courses.** The system shall let students browse course offerings and see each offering's title, schedule and available seats.
- **FR-02. Reserve a course.** The system shall let a signed-in student reserve one seat in an open offering with space. It shall confirm a successful reservation and reject a duplicate or full-course request with a clear message.
- **FR-03. Cancel a reservation.** The system shall let a signed-in student cancel their own active reservation and return its seat to the offering.
- **FR-04. Manage course offerings.** The system shall let administrators create and update offerings, set seat capacity and open or close reservations. It shall reject a capacity below the active reservation count.
- **FR-05. View reservations.** The system shall let an administrator select an offering and see its active reservations.

## Non-functional requirements

Non-functional requirements describe how well the system shall work and the constraints it shall meet. The workload and response time below are proposed lab targets.

- **NFR-01. Performance.** With 50 concurrent users in a lab test, at least 95% of course-list and reservation requests shall finish within 2 seconds.
- **NFR-02. Security.** Reservation changes shall require sign-in. Students shall access only their own reservation records, and only administrators shall manage offerings or view the reservation list for a course.
- **NFR-03. Data integrity.** If two students request the last seat at the same time, exactly one request shall succeed and the remaining seat count shall be zero.
- **NFR-04. Usability.** The browse, reserve and cancel screens shall work at widths of 360 and 1280 pixels without horizontal scrolling.
- **NFR-05. Reliability.** If the system confirms a reservation and then restarts, the reservation and the updated seat count shall still be present.
