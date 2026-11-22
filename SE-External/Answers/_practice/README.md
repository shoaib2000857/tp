# SE Lab Exam

| Question | Files | Run or open | Evidence to capture in the lab |
|---|---|---|---|
| Q1. Library system purpose, 4 FRs and 3 NFRs | `SRS.md` | Open `SRS.md` in a Markdown viewer or text editor. | Submit the SRS text. |
| Q2. Native StarUML use case diagram | `library-use-case.mdj`, `library-use-case.svg` | In StarUML choose **File → Open**, select `library-use-case.mdj`, and double-click **Library Use Cases** in Model Explorer. Open the SVG in a browser for comparison. | Capture the full diagram from StarUML after checking labels and connectors. |
| Q3. Docker Nginx static page | `nginx/Dockerfile`, `nginx/index.html`, `commands.md` | From the submission root, follow Q3 in `commands.md`. Open `http://localhost:8081/` before cleanup. | Capture the build output, `docker ps` with the port mapping, the page, and the HTTP access log. |
| Q4. Git feature branch, merge and log | `commands.md` | From the submission root, follow Q4 in `commands.md` in a fresh practice directory. | Capture branch creation, the merge output, and the commit graph showing the merge. |

## Q2 assumptions and recreation

The diagram uses two roles: members search the catalog, and librarians issue and return books. If recreation is needed, add a **Use Case Diagram** to a UML model. In the Toolbox, add a **Subject** named **Library System**. Place **Search Catalog**, **Issue Book**, and **Return Book** inside it. Place **Member** on the left and **Librarian** on the right. Use solid UML Associations from Member to Search Catalog and from Librarian to Issue Book and Return Book. Save as an `.mdj` project.

The native project is supplied as JSON with model elements, views, and references. Structural checks do not prove GUI rendering. Open the project in StarUML and visually confirm it before capturing evidence. The SVG is a preview. All command outputs described in this submission are expected outputs.
