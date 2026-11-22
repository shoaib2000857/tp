# KMIT SE Lab External — 23 Nov 2026

## Source precedence
1. **Primary:** `se-lab.zip` faculty handouts (Maven; Docker single; Docker Compose; Jenkins pipeline, script/triggers, Git hooks; Kubernetes/Nagios; AWS).
2. **Supplementary:** `SE Record.pdf` (112-page lab record; SRS, StarUML samples, Git, extra screenshots, scenario questions).
3. **Exam-specific:** CR messages (21–22 Nov): four tasks — SRS section(s), one of Class/Sequence/Use Case/Component **in StarUML**, and two tools practicals from Git, Docker, Jenkins, Kubernetes, Nagios, AWS. Tool choices and marking aren't confirmed.

## Fast navigation
- [SRS template and example](01-SRS/master-template.md) — Q1
- [StarUML four-diagram workshop](02-UML/staruml-guide.md) — Q2
- [Tool practical command map](03-Tools/tool-practicals.md) — Q3/Q4
- [Mock external](04-Mock/mock-external.md) — practise all four

## Source map
| Topic | Primary handout | Additional record pages |
|---|---|---|
| SRS | No dedicated handout in ZIP | 22–42 (worked SRS) |
| UML | No dedicated handout in ZIP | 43–46 (four diagrams), 37–40 |
| Git | No dedicated handout in ZIP | 9–21 |
| Maven | Maven Java and Web Projects.docx | 47–67 |
| Docker | Docker file, Single containerization.docx | 68–70 |
| Compose | Docker Compose, Multi Containerization.docx | 71–74 |
| Jenkins Freestyle | Jenkins pipeline Upload.docx | 75–88 |
| Jenkins script/triggers | Jenkins Script and buils triggers.docx | 89–92 |
| Jenkins hooks | Jenkins CICD with git Hooks.docx | 93–95 |
| Kubernetes and Nagios | Kubernetes and Nagios.doc | 96–103 |
| AWS EC2 | Cloud Deployment using AWS.docx | 104–112 |

## Practice order
1. Write SRS components for one unseen case (25–40 min).
2. Draw all four diagrams *in StarUML* for the same case (50–70 min).
3. Execute Docker CLI + Compose; verify with `docker ps`/`docker compose ps`.
4. Execute Jenkins build + pipeline + triggers and explain logs.
5. Execute Git scenarios; Kubernetes/Minikube/Nagios; review AWS EC2 setup.
6. Take a four-question mock. Keep screenshots of successful outputs if instructed by faculty.

**Safety:** never commit secrets, Docker Hub tokens, GitHub tokens or EC2 PEM keys. Do not expose Jenkins publicly without authentication. AWS resources can incur charges; stop/terminate practice resources according to lab instructions.

Existing repo reference material remains in place. This folder is an exam-first index, not a claim that every practical has been run or verified on your machine.
