# SE Lab Exam

| Question | Files | Run or open in the lab | Evidence to capture |
|---|---|---|---|
| 1. Explain functional and non-functional requirements for online course reservation | `SRS.md` | Open `SRS.md` and read both sections. | Submit the written requirements. |
| 2. Create a use case diagram for online course reservation | `course-reservation.mdj`, `course-reservation.svg` | In StarUML, choose **File → Open**, select `course-reservation.mdj`, and double-click **Course Reservation Use Cases** in Model Explorer. Open the SVG in a browser for comparison. | Capture the full diagram in StarUML with the system boundary, actors and associations visible. |
| 3. Scale a MySQL container using Kubernetes | `commands.md`, Q3 | Run the commands in order on the lab Minikube cluster. Wait for the scale-up to complete, then list pods. | Capture the scale command and the three `1/1 Running` MySQL pods once observed. |
| 4. Deploy a web app on AWS EC2 using Nginx | `commands.md`, Q4, `nginx-web/Dockerfile`, `nginx-web/index.html` | Push the two app files to your lab GitHub repository, launch and connect to Ubuntu EC2, clone the repo, and build and run the Nginx container. Open `http://<actual-public-ip>:6060/`. | Capture `docker ps` with the published port and the app in a browser at the EC2 public address. |

## Recreate the use case diagram in StarUML

Add a **Use Case Diagram** to a UML model. Add a **Use Case Subject** named **Online Course Reservation System**. Put five use cases inside the boundary, with the three Student use cases on the left and the two Administrator use cases on the right. Place the actors outside the boundary. Draw solid associations from **Student** to **Browse Courses**, **Reserve Course** and **Cancel Reservation**, and from **Administrator** to **Manage Course Offerings** and **View Reservations**. Save as `.mdj`.

The SVG is a matching preview. Structural checks of IDs, references and ownership do not prove GUI rendering. Confirm the diagram in StarUML on the lab computer. The practical commands have not been executed here, and no screenshots are supplied as execution evidence.
