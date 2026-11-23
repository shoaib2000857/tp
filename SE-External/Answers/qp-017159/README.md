# Software Engineering Lab Exam

| Question | Files | What to open or run |
|---|---|---|
| 1. Explain functional and non-functional requirements of an online course reservation system | [SRS.md](SRS.md) | Open the Markdown file and read both requirements sections. |
| 2. Create a use case diagram for an online course reservation system | [course-reservation.mdj](course-reservation.mdj), [course-reservation.svg](course-reservation.svg) | In StarUML, choose **File → Open**, select the `.mdj`, then double-click **Course Reservation Use Cases** in Model Explorer. Open the SVG in a browser to see the intended layout. |
| 3. Scale a container via Kubernetes | [commands.md](commands.md#q3--scale-nginx-with-kubernetes) | Run the Q3 commands in order on the lab computer. Keep the port-forward terminal open while visiting `http://localhost:8081/`. |
| 4. Deploy a web app via AWS EC2 | [commands.md](commands.md#q4--deploy-a-maven-web-app-on-aws-ec2), [pom.xml](aws-webapp/pom.xml), [index.jsp](aws-webapp/src/main/webapp/index.jsp), [web.xml](aws-webapp/src/main/webapp/WEB-INF/web.xml), [Dockerfile](aws-webapp/Dockerfile) | Put the contents of `aws-webapp/` at the root of your own GitHub repository. Launch Ubuntu EC2, connect via SSH, then clone, build and run using Q4. Open `http://<EC2-public-IPv4>:6060/` with the address shown in your console. |

## Recreate Q2 in StarUML

1. Create a UML project. In Model Explorer, right-click the model and choose **Add Diagram → Use Case Diagram**.
2. Add a **Use Case Subject** named **Online Course Reservation System**. Place the Student actor on the left and the Administrator actor on the right, both outside the subject.
3. Add the six named use cases from the SVG inside the subject. Use plain UML **Association** connectors to connect Student to the four left use cases and Administrator to the two right use cases.
4. Save as `.mdj`. The native project is supplied as JSON. Structural checks of IDs and references do not prove GUI rendering. Open the file in StarUML and inspect the labels, boundary and connectors before capturing evidence.

## Evidence to capture in the lab

- Q2: StarUML canvas with both actors, the system boundary and all six use cases visible.
- Q3: Terminal output showing the Deployment before scaling and after scaling to four ready replicas, plus the Nginx page at `localhost:8081`.
- Q4: EC2 running state and application port rule, terminal output showing the Docker build and published port, and the web page loaded from the instance's public address. Keep credentials and key material out of screenshots.

The supplied outputs are expectations. Capture actual results during the lab.