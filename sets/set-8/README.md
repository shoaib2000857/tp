# SET 8 — Blood Bank: complete quick solution

**Paper:** SET-8.docx from 19-11-26.zip. **Source:** https://github.com/sarasrija/BloodBanksystem (branch `main`). Maven produces `target/bloodbank.war` per pom.xml.  
**Questions:** Q1 Scripted Jenkins · Q2 AWS · Q3 Kubernetes+Nagios · Q4 Web/PG Compose (4×25).  
**Important:** PostgreSQL web stack, scripted Jenkins, AWS static-or-Java hosting, K8s+Nagios.

## 0. Maven WAR → Docker image (for app deployment, K8s, AWS)
```bash
git clone https://github.com/sarasrija/BloodBanksystem.git
cd BloodBanksystem
mvn clean package
# COPY this set's Dockerfile here beside pom.xml (target WAR must exist)
docker build -t YOUR_DOCKERHUB_USERNAME/set8:v1 .
docker login
docker push YOUR_DOCKERHUB_USERNAME/set8:v1
```
The Dockerfile copies WAR to Tomcat `ROOT.war`, so browser path is **/**. Use your own fork for any GitHub webhook test. Replace the placeholder Docker Hub username.

## 1. Docker / Docker Compose
From `sets/set-8` (not from the Maven app):
```bash
docker compose config
docker compose up -d 
docker compose ps
docker compose logs --tail=30
docker compose stop
docker compose start
docker compose down        # keeps DB data volumes
docker compose up -d       # data persists
```
Open http://localhost:8088/. Web WAR + database containers run together; real JDBC is not proven from supplied project source. **Never use `down -v` for persistence tests.** Port conflicts → change HOST port only. Postgres hostname `db:5432` or MySQL `db:3306` within Docker network.

## 2. Jenkins
**Jenkins Scripted Pipeline**: copy `Jenkinsfile` to writable fork root; Manage Jenkins → Tools → Maven named `MAVEN_HOME` → New Item → Pipeline → Pipeline script from SCM → Git fork URL, `*/main`, Script Path `Jenkinsfile` → Build Now. Set 9 also requires Tomcat deployment with Deploy-to-Container plugin/Manager credentials; Stage View or linked Freestyle Build Pipeline View.
**Webhook:** fork → `ngrok http 8080` → GitHub Settings → Webhooks → `https://NGROK-URL/github-webhook/` (JSON/push) → Jenkins job Build Triggers → GitHub hook trigger for GITScm polling. Poll SCM: `H/5 * * * *`. Jenkins requires auth and a live ngrok tunnel. Build console shows Maven compilation/test errors, `target/*.war` artifact.


## 3. Kubernetes (2→4 replicas)
```bash
minikube start --driver=docker
kubectl apply -f k8s.yaml
kubectl get deploy,pods,svc
kubectl scale deployment set8-web --replicas=4
kubectl rollout status deployment/set8-web
minikube service set8-web --url
kubectl get pods
kubectl delete pod POD_NAME         # controller creates replacement
kubectl describe pod POD_NAME
kubectl logs POD_NAME --previous
kubectl port-forward svc/set8-web 8098:8080
# Optional: publish :v2 first, then update and rollback
kubectl set image deployment/set8-web web=YOUR_DOCKERHUB_USERNAME/set8:v2
kubectl rollout undo deployment/set8-web
kubectl delete -f k8s.yaml
```
Port-forward browser http://localhost:8098/. Pending → `describe pod`; CrashLoopBackOff → `logs --previous`; ImagePullBackOff → image/tag/credentials; Service endpoints empty → labels/readiness. Paper doesn't mandate exact replicas; 2→4 is a practice choice.

## 4. Nagios
```bash
docker run -d --name nagiosdemo -p 8888:80 jasonrivers/nagios:latest
docker ps
docker logs nagiosdemo
# browser http://localhost:8888 ; faculty demo nagiosadmin/nagios
```
`nagios.cfg` has host + HTTP check **template**, not a complete monitored deployment. Put file into Nagios objects path, register cfg_file in main config, validate with `/opt/nagios/bin/nagios -v /opt/nagios/etc/nagios.cfg`, reload. Nagios and web must share a network and `web` must resolve. To monitor CPU/RAM/disk/uptime use NRPE/NCPA/SNMP etc. Actual alerts require contacts/notification commands.

## 5. AWS EC2
AWS Console → EC2 → Launch Ubuntu → key pair PEM → SG inbound TCP **22 My IP only**, **8080** to intended users (and 80 only if needed). Charges may apply.
```bash
# Your PC: ssh -i KEY.pem ubuntu@EC2_PUBLIC_IP
# On EC2:
sudo apt update
sudo apt install -y git maven docker.io
sudo systemctl enable --now docker
git clone https://github.com/sarasrija/BloodBanksystem.git
cd BloodBanksystem
mvn clean package
# Place this set's Dockerfile here beside pom.xml (paste with nano Dockerfile)
sudo docker build -t set8-aws .
sudo docker run -d --restart unless-stopped --name app -p 8080:8080 set8-aws
sudo docker ps
sudo docker logs app
```
Browser `http://EC2_PUBLIC_IP:8080/`. Set 8 static HTML alternative: apt install apache2, copy index.html to /var/www/html, enable apache2, allow 80. 404 → WAR/context/Tomcat; timeout → SG/firewall/published port. Stable IP → Elastic IP; load balancer + multiple EC2 for availability. **Stop/terminate resources after exam**.

## Set 8: scenario answers
1. Folder change: fix script path/project base/pom, not Maven syntax.
2. Install/test failure normally halts later stages; echo env.BUILD_NUMBER.
3. EC2 localhost works but public fails → SG/port/firewall.
4. K8s rollback via rollout undo; app errors via kubectl logs.
5. Nagios Core process logs / config validation; monitor resource/HTTP.

**General viva:** CI builds/tests changes, CD delivers/deploys; Maven manages libraries; `depends_on` doesn't guarantee DB ready without healthcheck; volumes preserve DB; ReplicaSet recreates deleted Pod; Service stable; manual scale ≠ HPA; Nagios host UP ≠ service OK; WARNING vs CRITICAL threshold; SSH 22 admin IP only.

**Screenshots:** `compose ps`, browser, persistent post/row, Jenkins Console Output/archived WAR, webhook recent delivery, K8s replicas/Pod recovery, Nagios dashboard + check, EC2 Public IP + Security Group.
