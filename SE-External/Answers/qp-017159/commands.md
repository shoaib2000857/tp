# Commands to run in the lab

## Q3. Scale Microsoft SQL Server on Kubernetes

Assume an x86-64 lab computer with Docker running, Minikube and `kubectl` on `PATH`, internet access to Microsoft Container Registry, and enough capacity for four SQL Server containers. The example gives Minikube 4 CPUs and 10 GiB RAM, so the host needs additional RAM for its own processes. SQL Server will run in Developer edition for this lab. The Kubernetes handout scales an Nginx Deployment to four with `kubectl scale`; this exercise uses the same operation on SQL Server. Each replica is an independent SQL Server with disposable storage. Scaling this Deployment adds SQL Server instances. Database replication and persistence require additional configuration.

Run in Bash from the submission root. Use a fresh Minikube profile for this exercise.

```bash
minikube start -p sql-lab --driver=docker --cpus=4 --memory=10240
minikube status -p sql-lab
kubectl --context sql-lab get nodes
kubectl --context sql-lab create namespace sql-lab
```

Choose your own SQL Server administrator password. Use at least 12 characters with uppercase and lowercase letters, digits, and punctuation. The following prompts without echo and sends the value on standard input.

```bash
read -rsp 'Enter your SQL Server lab password: ' SQL_LAB_PASSWORD
printf '\n'
printf '%s' "$SQL_LAB_PASSWORD" | kubectl --context sql-lab -n sql-lab create secret generic mssql-lab-secret --from-file=MSSQL_SA_PASSWORD=/dev/stdin
unset SQL_LAB_PASSWORD
kubectl --context sql-lab -n sql-lab apply -f kubernetes/mssql.yaml
kubectl --context sql-lab -n sql-lab rollout status deployment/mssql --timeout=5m
kubectl --context sql-lab -n sql-lab get deployment mssql
kubectl --context sql-lab -n sql-lab get pods -l app=mssql
```

Expected before scaling: `1/1` ready in the Deployment and one pod ready. Capture this, then run:

```bash
kubectl --context sql-lab -n sql-lab scale deployment mssql --replicas=4
kubectl --context sql-lab -n sql-lab rollout status deployment/mssql --timeout=5m
kubectl --context sql-lab -n sql-lab get deployment mssql
kubectl --context sql-lab -n sql-lab get pods -l app=mssql -o wide
```

Expected after scaling: `4/4` ready in the Deployment and four `Running` pods with `1/1` ready. The TCP readiness check confirms that SQL Server is listening. Verify that every instance can also execute a query:

```bash
for sql_lab_pod in $(kubectl --context sql-lab -n sql-lab get pods -l app=mssql -o name); do
  printf '\n%s\n' "$sql_lab_pod"
  kubectl --context sql-lab -n sql-lab exec "$sql_lab_pod" -- sh -c 'export SQLCMDPASSWORD="$MSSQL_SA_PASSWORD"; /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -b -Q "SET NOCOUNT ON; SELECT 1 AS lab_ok;"' || break
done
```

Expected: a `lab_ok` value of `1` for each of the four pods. If startup fails, inspect the pod events and SQL Server logs. Common causes are insufficient resources, an image pull failure, or a password that fails policy.

```bash
kubectl --context sql-lab -n sql-lab describe pods -l app=mssql
kubectl --context sql-lab -n sql-lab logs -l app=mssql --tail=30
```

After capturing evidence, delete the dedicated cluster and its lab resources:

```bash
minikube delete -p sql-lab
```

## Q4. Deploy a web app on AWS EC2 with Nginx

Assume the question accepts a minimal static web app and an Ubuntu EC2 instance. The AWS handout's Docker workflow applies here. Its `6060:8080` example targets Tomcat, so use `6060:80` for Nginx. Copy the supplied files using SCP so the lab can run without a GitHub repository. Prerequisites are a lab-approved AWS account, a local SSH/SCP client, and outbound internet access on the instance to install Docker and pull the base image.

1. In the AWS console, open EC2 → Launch instance. Choose an Ubuntu Server x86-64 AMI and a lab-approved instance type. Use an instance size eligible under your account terms if required by the lab. Create or select a key pair for which you hold the `.pem` file.
2. Launch one instance in a public subnet with a route to an internet gateway and public IPv4 assignment enabled. In the security group allow SSH TCP 22 from **My IP** and custom TCP 6060 from the intended browser client's public IP/CIDR. Use the lab-approved client CIDR if the examiner tests from another device. Wait for the instance to start and pass its status checks.
3. In the instance's **Connect → SSH client** tab, identify the SSH username and public address. The official Ubuntu AMI normally uses `ubuntu`. Use the console values when prompted below.

Run on the local lab computer from the submission root:

```bash
read -rp 'Path to your EC2 .pem file: ' EC2_LAB_KEY
read -rp 'SSH username shown in EC2 Connect: ' EC2_LAB_USER
read -rp 'EC2 public IPv4 address: ' EC2_LAB_IP
chmod 400 "$EC2_LAB_KEY"
scp -i "$EC2_LAB_KEY" -r web "$EC2_LAB_USER@$EC2_LAB_IP:~/"
ssh -i "$EC2_LAB_KEY" "$EC2_LAB_USER@$EC2_LAB_IP"
```

Run inside the EC2 SSH session:

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
cd ~/web
sudo docker build -t course-web-nginx .
sudo docker images course-web-nginx
sudo docker run -d --name app-demo -p 6060:80 course-web-nginx
sudo docker ps --filter name=app-demo
curl -fsS http://127.0.0.1:6060/
sudo docker logs app-demo
```

Open `http://<EC2-public-IPv4>:6060/` in the lab browser, using the actual public IPv4 from the console. Expected: the course reservation demo page loads, `docker ps` shows host port 6060 mapped to container port 80, and the Nginx log records the request. If localhost works on EC2 but the browser times out, check the security group, public IPv4 address, and subnet route. If localhost fails, check container status and logs first.

After capturing evidence, run on EC2:

```bash
sudo docker stop app-demo
sudo docker rm app-demo
sudo docker rmi course-web-nginx
exit
```

If you launched a disposable instance solely for the exam, terminate it through the EC2 console after recording evidence. Check for any lab-created storage or Elastic IP still allocated, and remove any temporary inbound rule added to a reused security group.