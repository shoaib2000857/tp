# Q3 / Q4 — tool practical field guide
**Primary teaching sources: faculty ZIP handouts.** These are compact patterns, not replacements for their full instructions. Run commands from the appropriate directory and adapt names/ports.

## Git scenario
```bash
git init
git status
git add .
git commit -m "initial"
git branch -M main
git remote add origin YOUR_REPOSITORY_URL
git push -u origin main
git checkout -b feature/task
# make changes
git add . && git commit -m "feature"
git checkout main && git merge feature/task
git log --oneline --graph --all
```
Conflict: inspect `git status`, edit conflict markers, `git add`, `git commit` (or `git merge --continue` as applicable).
Patch: `git diff > fix.patch`, `git apply --check fix.patch`, `git apply fix.patch`; commit changes. For mailed commit patches use `git format-patch` + `git am` instead.

## Maven Java/Web
```bash
mvn -version
mvn clean compile
mvn test
mvn clean package
mvn dependency:tree
mvn -X compile
```
JAR project: packaging `jar`; WAR web app: packaging `war`, output `target/*.war`. `mvn install` also installs built artifact into local `.m2`. Check Java compiler release/JDK if unsupported class version.

## Docker CLI
```bash
docker version
docker pull redis
docker run -d --name redis-lab redis
docker ps -a
docker exec -it redis-lab redis-cli
# SET kmit yes
# GET kmit
docker logs redis-lab
docker stop redis-lab
docker rm redis-lab
docker images
docker build -t myapp .
docker run -d -p 8081:80 --name nginx-lab nginx
```
Dockerfile example:
```dockerfile
FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html/index.html
EXPOSE 80
```
EXPOSE documents a container port; `-p HOST:CONTAINER` publishes it.

## Compose — WordPress + MySQL pattern
```yaml
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: local-demo-only
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: local-demo-only
    volumes:
      - db_data:/var/lib/mysql
  wordpress:
    image: wordpress:latest
    depends_on:
      - db
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: local-demo-only
      WORDPRESS_DB_NAME: wordpress
volumes:
  db_data:
```
```bash
docker compose config
docker compose up -d
docker compose ps
docker compose logs -f wordpress
docker compose down
```
`depends_on` controls initial order, **not readiness**. Use non-example secret values in any real deployment. Do not run `down -v` if data must persist.

## Jenkins
**Freestyle:** New Item → Freestyle → Git SCM repository + correct branch → Maven build step `clean package` → Archive artifacts → Build Now → Console Output.
**Declarative syntax** (faculty pipeline handout shows `pipeline { ... }`; that is Declarative, even where labelled 'scripted'):
```groovy
pipeline {
  agent any
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Build') { steps { bat 'mvn clean package' } } // Windows agent; Linux uses sh
    stage('Test') { steps { bat 'mvn test' } }
  }
}
```
**Actual Scripted syntax**:
```groovy
node {
  stage('Checkout') { checkout scm }
  stage('Build') { bat 'mvn clean package' }
  stage('Test') { bat 'mvn test' }
}
```
Requires SCM configuration and Maven available on agent. **Build triggers:** Poll SCM `H/15 * * * *`; webhook via GitHub job trigger and properly configured public HTTPS endpoint. Webhooks are push-driven; Poll SCM checks changes periodically. Check console for actual success before claiming it worked.

## Kubernetes
```bash
minikube start --driver=docker
kubectl get nodes
kubectl create deployment mynginx --image=nginx
kubectl get deployment,pods
kubectl expose deployment mynginx --type=NodePort --port=80 --target-port=80
kubectl scale deployment mynginx --replicas=4
kubectl rollout status deployment/mynginx
kubectl get pods
minikube service mynginx --url
kubectl port-forward svc/mynginx 8081:80
kubectl describe pods
kubectl logs POD_NAME
```
`ImagePullBackOff`: image/tag/network/registry; `CrashLoopBackOff`: app logs; `Pending`: capacity/scheduling; no service traffic: ports, selectors, readiness.

## Nagios using Docker
```bash
docker run -d --name nagiosdemo -p 8888:80 jasonrivers/nagios:latest
docker ps
docker logs nagiosdemo
```
Visit `http://localhost:8888` and check Hosts/Services (demo credentials, if provided in handout, are **not** safe for public exposure). Host statuses: UP/DOWN/UNREACHABLE. Service: OK/WARNING/CRITICAL/UNKNOWN.

## AWS EC2 (only in lab-approved account)
Console → EC2 → Launch Ubuntu instance → key pair → allow SSH 22 from your IP and application port from intended clients → launch → Connect (copy exact Ubuntu SSH command). On host:
```bash
sudo apt update
sudo apt install -y docker.io git maven
sudo systemctl enable --now docker
git clone YOUR_WEBAPP_REPO
cd YOUR_WEBAPP_REPO
mvn clean package
# Dockerfile must copy correct WAR from target
sudo docker build -t webapp .
sudo docker run -d -p 6060:8080 --name webapp-demo webapp
sudo docker ps
sudo docker logs webapp-demo
```
Verify `http://EC2_PUBLIC_IP:6060/APP_CONTEXT` only if your Tomcat image and deployment context make that URL valid. Stop/terminate EC2 when finished; manage keys safely.

## Exam troubleshoot triage
1. Read full error, identify layer (Git/Maven/Docker/Jenkins/K8s/network).
2. Check tool version, working directory, file path, branch, privileges, port.
3. Reproduce with smallest command; inspect logs/console.
4. Fix one variable and rerun; capture evidence of success.
