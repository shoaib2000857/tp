# Software Engineering Lab Exam

| Question | Files | Open or run in the lab | Evidence to capture |
|---|---|---|---|
| Q1. Explain functional and non-functional requirements of an Online Course Reservation System | `SRS.md` | Open in a Markdown viewer or text editor. | Written requirements. |
| Q2. Create a use case diagram for the same system | `course-reservation.mdj`, `course-reservation.svg` | Open the `.mdj` through StarUML → File → Open. Expand **Online Course Reservation** in Model Explorer and double-click **Course Reservation Use Cases**. Open the SVG in a browser for comparison. | Screenshot of the diagram open in StarUML. |
| Q3. Scale an MS SQL Server container using Kubernetes | `commands.md`, `kubernetes/mssql.yaml` | From the submission root, run Q3 in `commands.md`. Start at one replica, scale to four, and run the verification steps. | `kubectl` output showing one ready replica before scaling and four after, plus the SQL query results. |
| Q4. Deploy a web app on AWS EC2 using Nginx | `commands.md`, `web/Dockerfile`, `web/index.html` | Follow Q4 in `commands.md` to launch Ubuntu, copy `web/` to EC2, build and run the Nginx image, and open the EC2 public endpoint. | EC2 instance details with its public address, the container and port mapping, and the browser showing the app at that address. Keep secrets and private keys out of evidence. |

## Recreate the use case diagram in StarUML

Create a UML project and add a Use Case Diagram from Model Explorer. Add a Use Case Subject named **Online Course Reservation System** and put the six use cases from the SVG inside it. Put **Student** outside on the left and **Administrator** outside on the right. Use plain Associations from Student to Browse Course Offerings, Reserve Seat, View My Reservations, and Cancel Reservation. Associate Administrator with Manage Course Offerings and View Course Rosters. Save as `.mdj` and inspect the labels and lines at normal zoom. Structural checks do not prove GUI rendering. Open the native file in StarUML before capturing evidence.

Assumptions are stated in the SRS and command guide. All tool output described in the guide is expected until observed in the lab.