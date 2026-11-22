# Q1 — SRS answer template
**Instruction:** write only sections actually requested, in the problem domain given. Avoid substituting implementation plans for testable requirements.

## Abstract
[System] is a [web/mobile/etc.] application designed to help [users] solve [problem]. It enables [3 principal capabilities]. The proposed system improves [benefit] while ensuring [security/reliability/etc.].

## Purpose & Scope
Purpose: this SRS defines the behaviour and quality requirements of [System]. Scope: support [features] for [actors], with [out-of-scope items] excluded where appropriate.

## Users / Actors
- [Actor 1]: [responsibilities, access]
- [Actor 2]: [responsibilities, access]
- Administrator: [management and monitoring]

## Functional requirements — action / system SHALL
FR-01 The system shall allow [actor] to register/login with valid credentials.
FR-02 The system shall allow [actor] to [domain-specific core task].
FR-03 The system shall validate [input] and display appropriate errors.
FR-04 The system shall store and retrieve [records] based on user permissions.
FR-05 The system shall notify [actor] when [event] occurs.
FR-06 The administrator shall be able to [manage relevant resources].

## Non-functional requirements — measurable quality
NFR-01 Performance: under [defined workload], [core action] shall finish within [target] seconds.
NFR-02 Security: protected functions shall require authenticated, authorized access.
NFR-03 Availability: the system shall achieve [target]% monthly uptime (proposed target).
NFR-04 Usability: the primary flow shall be usable from common desktop/mobile browsers.
NFR-05 Reliability: invalid requests shall return an error without corrupting persisted data.
NFR-06 Maintainability: the system shall separate major modules and log operational errors.
**Note:** performance/availability numbers are hypothetical targets unless given in the prompt.

## Workflow for each user
User: open site → login → perform task → validate → save/confirm → view status → logout.
Admin: login → review requests/records → approve/update → audit → logout.

## Use case text
**ID:** UC-01; **Name:** [verb/object]; **Primary actor:** [role]
**Preconditions:** [must already be true]
**Trigger:** [event]
**Main flow:** 1 [actor action] 2 [system response] 3 [result]
**Alternative/exception flow:** [validation failure]
**Postconditions:** [outcome]

## Additional SRS sections when explicitly requested
Introduction, product perspective, assumptions/dependencies, constraints, hardware/software interfaces, external interfaces, glossary, acceptance criteria, references.

## Worked mini-example — Library Management
Abstract: A Library Management System digitizes book discovery, issuing and returns for members and librarians, reducing manual tracking and improving visibility into availability.
Actors: Member searches/reserves/views loans; Librarian issues/returns/manages inventory; Admin manages accounts.
FR-01 Members shall search books by title or author.
FR-02 Librarians shall issue available copies to valid members.
FR-03 The system shall update available-copy counts when loans are issued/returned.
FR-04 The system shall prevent issuing a copy already on loan.
NFR-01 Only authorized librarians may issue/return copies.
NFR-02 Book searches shall return within 3 seconds under the defined test workload (proposed target).
Use case Issue Book: Preconditions member active and copy available; librarian selects member/book; system validates availability; creates loan and adjusts stock; alternative: unavailable book triggers rejection; postcondition loan recorded.

## Exam check
- Abstract = short overview, not a list of every requirement.
- FR = **what** the system does. NFR = **how well / constraints**.
- Use unique IDs and 'shall'; avoid vague phrases like 'fast', 'secure' with no detail.
- Name all actors and make each workflow reflect permissions.
- The record sample (pp. 22–42) is one domain-specific example, **not** the expected problem statement.
