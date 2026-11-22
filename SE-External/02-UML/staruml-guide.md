# Q2 — StarUML four-diagram practical

CR explicitly says the UML diagram **must be drawn on StarUML**. Practise using the app, not only pencil diagrams.

## Shared case: Library Management System
Actors: Member, Librarian, Administrator.
Domain: User, Member, Librarian, Book, Loan, Reservation.
Components: Web UI, Backend API, Auth Service, Catalog Service, Loan Service, Database.

## StarUML workflow
1. Open StarUML; create/open a UML project.
2. In the Model Explorer, right-click the model/package → **Add Diagram** → select the exact UML diagram type (menu labels may differ by version).
3. Drag elements from the Toolbox onto canvas. Use Quick Edit/double-click to rename.
4. Link with the **appropriate connector**, not an arbitrary line.
5. Arrange for readability; save the .mdj project. Export an image only if requested.

### A. Use Case
Add actors **Member**, **Librarian**, **Admin**, system boundary **Library Management System**, and use cases **Search Books**, **Reserve Book**, **Issue Book**, **Return Book**, **Manage Catalog**, **Manage Accounts**.
Associations: Member–Search/Reserve; Librarian–Issue/Return/Manage Catalog; Admin–Manage Accounts.
Use `<<include>>` only where a mandatory reused behaviour exists (e.g. 'Issue Book' includes 'Check Availability'). `<<extend>>` for optional/conditional behaviour. Don't connect actors directly to classes.

### B. Class
Create `User` (+id, +name, +login()); `Member` (+memberId, +reserveBook()); `Librarian` (+employeeId, +issueBook()); `Book` (+isbn, +title, +availableCopies); `Loan` (+loanId, +dueDate, +returnBook()).
Relationships: Member and Librarian generalize User (hollow triangle points **to User**). Member 1 — 0..* Loan. Book 1 — 0..* Loan. Include multiplicities and a sensible association label. Separate attributes from operations.

### C. Sequence — 'Issue Book'
Lifelines left→right: Librarian (actor), Library UI, LoanController, CatalogService, LoanRepository.
Messages top→bottom: 1 issueBook(memberId, bookId) → 2 validateInput() → 3 checkAvailability(bookId) → 4 availability result (dashed return) → 5 createLoan(...) [if available] → 6 confirmation → 7 displayResult().
Use an **alt combined fragment** for [available] vs [unavailable] where time permits. Vertical ordering conveys time; don't connect arbitrarily.

### D. Component
Components: Web UI, Backend API, Authentication, Catalog, Loan Management, Database.
Dependencies: Web UI → Backend API; Backend API → Auth/Catalog/Loan; Catalog/Loan → Database. Use component elements and dependency/assembly connectors. Show interfaces only if known; don't confuse component with class diagram.

## Four diagram distinctions
- Use Case = **who does what** (actors + capabilities).
- Class = **static data and relationships** (attributes/methods/multiplicity).
- Sequence = **time-ordered messages** (lifelines + calls).
- Component = **high-level architecture/dependencies** (modules + interfaces).

## 5-minute pre-submission audit
Correct diagram type? Everything named? Right arrow/connector semantics? No overlapping labels? Correct actor/system boundary or class multiplicities or lifeline ordering? Save file in exam location.

Reference illustrations: supplementary SE Record pp. 43–46. They are examples; adapt to the problem statement assigned.
