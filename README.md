**Clone:** `git clone https://github.com/shoaib2000857/se.git` — open this README. **Replace `YOUR_...` placeholders.** Run commands **inside the appropriate folder**, except Jenkins GUI and AWS SSH. **Never push passwords, .pem keys or real tokens.**

| Question says… | Open / do |
|---|---|
| Docker commands / Dockerfile / Redis | **§1** below |
| WordPress + MySQL | `compose/wordpress.yml` |
| Flask + Nginx | `compose/flask-nginx/` |
| Java WAR + MySQL / Docker Hub image | `compose/war-mysql.yml`, `docker/Tomcat.Dockerfile` |
| Nginx + Postgres + Redis | `compose/nginx-postgres-redis.yml` |
| Nginx + Nagios | `compose/nagios.yml` |
| Jenkins GUI / Maven Freestyle / Tomcat deploy | **§3** |
| Jenkins Scripted Pipeline / Docker push / email | `jenkins/Jenkinsfile` and **§4** |
| Jenkins faculty Declarative Pipeline | `jenkins/Declarative.Jenkinsfile` |
| Kubernetes Minikube / NodePort / four Pods | **§5**; optional `k8s/` YAML |
| Nagios setup / monitoring configs | **§6**, `nagios/webapp.cfg` |
| AWS EC2 SSH + Docker Tomcat | **§7** |

## §1 Docker — copy commands
```bash
docker --version
docker pull redis
docker run -d --name my-redis redis
docker ps -a
docker exec -it my-redis redis-cli
# Redis prompt: SET name Alice  /  GET name  /  exit
docker logs my-redis
docker stop my-redis
docker start my-redis
docker rm -f my-redis
docker images
docker build -t myapp .                 # run where Dockerfile exists
docker run -d --name web -p 8080:80 nginx
docker commit web myimage:snapshot
docker login
docker tag myapp YOUR_USER/myapp:latest
docker push YOUR_USER/myapp:latest
docker rmi IMAGE
docker network ls; docker volume ls
```
Dockerfile example: `docker/Redis.Dockerfile` or `docker/Tomcat.Dockerfile`. **Image = template; container = instance.** Ports = `HOST:CONTAINER`.

## §2 Docker Compose — universal commands
**Pick a file:** `docker compose -f compose/wordpress.yml up -d` (from repo root). For Flask: `cd compose/flask-nginx` then `docker compose up -d --build`.
```bash
docker compose -f FILE.yml config
docker compose -f FILE.yml up -d --build
docker compose -f FILE.yml ps
docker compose -f FILE.yml logs -f
docker compose -f FILE.yml stop          # preserve containers
docker compose -f FILE.yml start         # resume
docker compose -f FILE.yml stop web      # one service
docker compose -f FILE.yml restart web
docker compose -f FILE.yml up -d --build --no-deps web
docker compose -f FILE.yml down          # keep named data volumes
docker compose -f FILE.yml down -v       # DELETE volume data!
```
**Answers:** DB hostname **`db`**, not localhost *inside other containers*. `depends_on` = start order, **not DB readiness**. DB volume = persistence across `down` / recreation. Port conflict → change **host** port. `docker compose config` validates YAML. `docker compose exec web sh` opens container shell.

## §3 Jenkins Freestyle (faculty Week 8) — exact GUI
**Prereqs:** Jenkins `localhost:8080`, JDK, Git, Maven, Tomcat (e.g. `localhost:8085`). **Manage Jenkins → Tools:** configure Maven as `MAVEN_HOME`. **Plugins:** Git, Maven Integration, Copy Artifact, Build Pipeline, Deploy to Container, Pipeline, Email Extension. **Manage Jenkins → Credentials:** add Git/Tomcat/Docker tokens as needed.
- **Java Build:** New Item → `MavenJava_Build` → **Freestyle** → Source Code Management **Git** (URL, `*/main` or actual branch) → Build Steps **Invoke top-level Maven targets** `clean`, then `install` (tool `MAVEN_HOME`) → Post-build **Archive artifacts** (`**/*` per faculty; narrower `target/*.jar` if sufficient) → **Build other projects**: `MavenJava_Test`, only if stable → Save.
- **Java Test:** New Item `MavenJava_Test` → Freestyle → Build Environment **Delete workspace** → Build Step **Copy artifacts from MavenJava_Build** (`**/*`, stable) → Maven `test` → Archive artifacts. **Tests need `pom.xml` + source**, not only packaged JAR.
- **Web Build→Test→Deploy:** Same as above, names `MavenWeb_Build` → `MavenWeb_Test` → `MavenWeb_Deploy`. Build `clean`, `install`; Test copies project, runs `test`, archives `**/*` **including WAR**; Deploy copies artifacts from Test → Post-build **Deploy WAR/EAR to a container**, WAR `**/*.war`, context `Webpath`, Tomcat 9.x, URL e.g. `http://localhost:8085/`, Jenkins Tomcat credentials. Tomcat Manager user needs `manager-script` role; HTTP vs HTTPS must match server.
- **View:** Dashboard **+** → **Build Pipeline View** → initial job `MavenJava_Build` or `MavenWeb_Build` → Save → **Build Now / Run** → build number → **Console Output** (look for `BUILD SUCCESS`). **Build Pipeline View ≠ Pipeline script**.
- **Artifacts:** `mvn clean package` → `target/*.war` only when `pom.xml` has `<packaging>war</packaging>`. `mvn install` already runs tests/package. **JAR ≠ WAR.**

## §4 Jenkins Pipeline / Webhook / Email — GUI
**Scripted** = `node { stage('...') { bat/sh '...' } }` → `jenkins/Jenkinsfile`. **Declarative** = `pipeline { agent any; stages { stage(...) { steps {...} } } }` → faculty `jenkins/Declarative.Jenkinsfile`. Replace `bat` with `sh` for Linux Jenkins. Maven must be on agent PATH (or configured with `tool`).
1. **New Item → Pipeline → Pipeline script from SCM → Git URL, branch `*/main`, Script Path `jenkins/Jenkinsfile` → Save → Build Now.** If Jenkinsfile lives in another repo, copy it into that repo or choose Pipeline script and paste code.
2. **Credentials → Global → Add:** Secret text ID `dockerhub-token` (Docker Hub access token). For `jenkins/Jenkinsfile` change Git URL, Docker username/image and notification email. Docker must work on the Jenkins agent.
3. **Webhook:** `ngrok config add-authtoken TOKEN`; `ngrok http 8080` → copy public HTTPS URL. GitHub repo → **Settings → Webhooks → Add webhook** → `https://YOUR-NGROK-URL/github-webhook/`, Content type JSON, **push** event. Jenkins job → **Configure → Build Triggers → GitHub hook trigger for GITScm polling**. Push commit; inspect GitHub **Recent Deliveries** + Jenkins Build History. Keep Jenkins authenticated while tunneling; close ngrok after exam.
4. **Email:** Plugin **Email Extension** → Manage Jenkins → **System → Extended E-mail Notification** → `smtp.gmail.com`, port `465`, SSL, Gmail username + **App Password** stored as credential, test mail. Pipeline uses `emailext` in Scripted `catch/finally`; Declarative uses `post { failure { ... } }`. Replace email placeholder.
5. **Other triggers:** GUI **Build periodically** `0 18 * * *` (daily 6 PM controller TZ) or **Poll SCM** `H/5 * * * *`. **If tests fail, do not push/deploy.**

## §5 Kubernetes / Minikube — commands
```bash
minikube start --driver=docker
minikube status
kubectl get nodes
kubectl create deployment mynginx --image=nginx
kubectl get deploy,pods,svc
kubectl expose deployment mynginx --type=NodePort --port=80 --target-port=80
kubectl scale deployment mynginx --replicas=4
kubectl rollout status deployment/mynginx
kubectl get pods -o wide
minikube service mynginx --url           # open returned URL
kubectl port-forward svc/mynginx 8081:80 # alternate: localhost:8081
minikube dashboard
kubectl delete pod POD_NAME              # watch replacement Pod appear!
kubectl set image deployment/mynginx nginx=nginx:stable
kubectl rollout history deployment/mynginx
kubectl rollout undo deployment/mynginx
kubectl describe pod POD_NAME
kubectl logs POD_NAME --previous
kubectl describe svc mynginx
kubectl get pods --show-labels
kubectl get endpoints mynginx            # if empty: selector/labels/readiness
kubectl delete svc mynginx
kubectl delete deployment mynginx
minikube stop
```
**Use YOUR Docker Hub image:** `kubectl create deployment myapp --image=YOUR_USER/myapp:latest` → `kubectl expose deployment myapp --type=NodePort --port=8080 --target-port=8080` → `kubectl scale deployment myapp --replicas=4` → `minikube service myapp --url`. Add `/app/` for Tomcat `app.war`. Fixed NodePort `30080`: `k8s/service.yaml` (apply with matching deployment labels). **CrashLoopBackOff** → `kubectl logs POD --previous`; **ImagePullBackOff** → image/tag/auth; **Pending** → `describe pod` for scheduling/resources; no endpoints → check matching labels and Ready Pods. PowerShell: paste commands on **one line**.

## §6 Nagios
```bash
docker pull jasonrivers/nagios:latest
docker run -d --name nagiosdemo -p 8888:80 jasonrivers/nagios:latest
docker ps
docker logs nagiosdemo
# http://localhost:8888 ; faculty example login nagiosadmin / nagios (demo only)
docker stop nagiosdemo
docker rm nagiosdemo
```
Dashboard **Hosts → Services → Host Details → Reschedule check / Downtime**. **Host:** UP/DOWN/UNREACHABLE; **service:** OK/WARNING/CRITICAL/UNKNOWN. Real HTTP monitoring requires configuring a host and service in Nagios (see `nagios/webapp.cfg`); CPU/disk require appropriate remote agent/plugins. Web container running ≠ HTTP healthy. Container + Nagios Compose: `compose/nagios.yml`.

## §7 AWS EC2 — faculty port 6060
**AWS console:** EC2 → **Launch instance** → Ubuntu AMI → eligible instance type → create/download `.pem` key → Security group **SSH 22 from your IP**, **TCP 6060** from intended clients (HTTP 80/HTTPS 443 only if used) → Launch → select instance → **Connect → SSH client** → copy exact SSH command.
```bash
# On YOUR computer (example; use your actual key and EC2 hostname):
ssh -i path/to/key.pem ubuntu@EC2_PUBLIC_DNS
# On EC2 Ubuntu:
sudo apt update
sudo apt install -y git docker.io maven
sudo systemctl enable --now docker
git clone https://github.com/USERNAME/MAVEN-WEB-REPO.git
cd MAVEN-WEB-REPO
mvn clean package                           # generates target/*.war
# Put docker/Tomcat.Dockerfile content in a file named Dockerfile here
sudo docker build -t webapp .
sudo docker run -d --restart unless-stopped --name app-demo -p 6060:8080 webapp
sudo docker ps
sudo docker logs app-demo
```
Browser: `http://EC2_PUBLIC_IP:6060/app/` for `app.war`. **404:** check WAR name/context, `docker logs`, Tomcat compatibility. **Works with localhost but not public IP:** AWS inbound TCP 6060 + OS firewall + bound port. **IP changes:** Elastic IP. **First-boot automation:** EC2 User Data. **Clean up AWS resources after exam to avoid charges.** For static HTML + Apache: `sudo apt install -y apache2 && sudo systemctl enable --now apache2`, copy HTML to `/var/www/html/index.html`, allow port 80.

## Quick troubleshooting / scenario answers
| Symptom | Check |
|---|---|
| Docker port already allocated | `docker ps`; change HOST port |
| MySQL connection refused | DB hostname `db`, internal port 3306, credentials, logs, startup readiness |
| Data vanished | Volume missing / mistakenly used `down -v` |
| Jenkins Maven failure | Job → Console Output, `pom.xml`, JDK/tool config |
| Jenkins webhook not triggering | ngrok running, `/github-webhook/`, Recent Deliveries, job trigger |
| Docker Hub push unauthorized | Correct username/image name, Jenkins access token credential |
| Tomcat 404 | WAR generated? correct `/app/` path? compatible Tomcat? |
| K8s Pods won't start | `kubectl describe pod`, `kubectl logs`, image tag, resources |
| K8s Service has no endpoints | selector labels + ready Pods + same namespace |
| Nagios says web DOWN | network/hostname/internal port + actual HTTP response |
| EC2 site unreachable | public IP, SG inbound 6060, Docker mapping, Ubuntu firewall |

**Evidence/screenshots:** `docker ps`, browser output, Jenkins stages and Console Output, Docker Hub image, `kubectl get pods` with four replicas, Minikube URL, Nagios Hosts/Services, EC2 inbound rules + public browser page.

**Source basis:** KMIT faculty Week 5 Docker, Week 6 Compose, Week 8 Freestyle, Week 9 Pipeline, Week 11 Webhook/Email, Kubernetes+Nagios, AWS deployment; CSM Sets 1–9. Snippets are reusable exam templates; application-specific WAR paths, database integration, credentials and ports must match the assigned project.
