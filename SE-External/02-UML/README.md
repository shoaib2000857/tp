# StarUML practical files — Hospital Appointment Management System

Four separate **editable StarUML `.mdj` projects** created for KMIT SE Lab external revision:

| File | Diagram | Included elements |
|---|---|---|
| [01-use-case.mdj](01-use-case.mdj) | Use Case | Patient, Doctor, Administrator; booking/search/manage use cases and associations |
| [02-class.mdj](02-class.mdj) | Class | User, Patient, Doctor, Administrator, Appointment; attributes, operations, generalization and association models |
| [03-sequence.mdj](03-sequence.mdj) | Sequence | Patient → AppointmentUI → BookingService → Database; time-ordered booking messages |
| [04-component.mdj](04-component.mdj) | Component | Web Application, Backend API, Auth, Appointment, Doctor services, Database |

## Open and practice
1. Download a `.mdj` file (GitHub **Raw → Save as** or use `git clone`).
2. In StarUML choose **File → Open** and select the file.
3. In **Model Explorer**, double-click the diagram. Reposition elements and edit names for a new problem statement.
4. Save your own edited copy. If StarUML reports a problem or lays out an element incorrectly, consult the [manual step-by-step guide](staruml-guide.md) to recreate it.

## Verification scope
These are generated StarUML JSON projects. Their structure, unique IDs and internal references were checked programmatically; **they have not been opened/rendered with the StarUML desktop application** in this environment, so visually confirm each one before relying on it in an exam.

**Source hierarchy:** ZIP handouts are primary, SE Record.pdf is supplementary. The supplementary record's four UML examples are a different domain (GLUCOVISION-AI); these are exam practice projects based on the Hospital Appointment scenario, not exact reconstructions of those examples.
