# Library System SRS

## Purpose

The library system lets members find books and helps librarians track loans, returns, and available copies. Assume each physical copy has its own ID and each member has a library account.

## Functional requirements

1. **FR-01** The system shall allow members to search by book title or author.
2. **FR-02** The system shall display the number of available copies for each search result.
3. **FR-03** The system shall allow librarians to issue an available copy to an active member, record its due date, and mark the copy as on loan. It shall reject an issue request for a copy already on loan.
4. **FR-04** The system shall allow librarians to record the return of a copy against its active loan, close that loan, and mark the copy as available.

## Non-functional requirements

1. **NFR-01 Performance.** At least 95% of catalog searches shall return within 2 seconds in a lab test with 10,000 titles and 20 concurrent users. These are assumed test targets.
2. **NFR-02 Security.** Every issue or return request shall require an authenticated user with the Librarian role.
3. **NFR-03 Reliability.** If saving an issue or return fails, both the loan record and the copy status shall retain their previous values.
