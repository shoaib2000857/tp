# Commands to run on the lab computer

## Q3. Scale MySQL on Kubernetes

Prerequisites are a running Minikube cluster and `kubectl`. If the lab cluster has yet to start and Docker is running, use `minikube start --driver=docker`.

```bash
kubectl create deployment mysql --image=mysql:8.0 --dry-run=client -o yaml | kubectl set env --local -f - MYSQL_RANDOM_ROOT_PASSWORD=yes -o yaml | kubectl apply -f -
kubectl scale deployment/mysql --replicas=3
kubectl rollout status deployment/mysql
kubectl get pods -l app=mysql
```

Expected result is three MySQL pods showing `1/1 Running` after startup. The first command sets the image's random root password option before creating the Deployment. This scaling demo runs three independent MySQL servers with disposable data. Database replication would need a separate setup.

After capturing evidence, run `kubectl delete deployment mysql`.

## Q4. Deploy a static web app to Ubuntu EC2 with Docker and Nginx

Prerequisites are Git and SSH on the lab computer, an empty GitHub repository you can push to, and access to the lab AWS account. The clone step assumes the repo is readable from EC2. For a private repo, use the lab's approved Git authentication on EC2. Port 6060 follows the EC2 handout. Nginx listens on container port 80, so publish `6060:80`. Shell options below use standard ASCII hyphens.

### Publish the app from the lab computer

From the directory containing this answer, run the following in Bash. Enter your actual GitHub clone URL at the prompt.

```bash
cd nginx-web
git init
git add Dockerfile index.html
git commit -m "Add Nginx web app"
git branch -M main
read -r -p 'GitHub clone URL: ' APP_REPO_URL
git remote add origin "$APP_REPO_URL"
git push -u origin main
```

### Launch and connect

1. In AWS Console, open **EC2 → Launch instance**. Select Ubuntu Server (64-bit), one lab-approved micro instance and a key pair you can access. Use the lab-approved disk size (the handout uses 8 GiB). Enable a public IPv4 address in a public subnet with an internet gateway route.
2. In the instance security group, allow inbound TCP 22 from your lab computer's public IP and TCP 6060 from the intended browser clients, including your lab computer. The browser test uses HTTP on 6060.
3. Select the running instance and open **Connect → SSH client**. From the folder containing your actual key, set its permissions and paste the exact SSH command supplied by the console.

```bash
read -r -p 'Path to your EC2 PEM file: ' APP_PEM_PATH
chmod 400 "$APP_PEM_PATH"
```

### Build and run on the EC2 instance

Run these commands in the Ubuntu SSH session. Enter the same GitHub clone URL again.

```bash
sudo apt update
sudo apt install -y docker.io git curl
sudo systemctl enable --now docker
read -r -p 'GitHub clone URL: ' APP_REPO_URL
git clone "$APP_REPO_URL" nginx-web
cd nginx-web
sudo docker build -t nginx-web .
sudo docker images nginx-web
sudo docker run -d --name app-demo -p 6060:80 nginx-web
sudo docker ps --filter name=app-demo
curl -fsS http://localhost:6060/
sudo docker logs app-demo
```

From the lab computer, open `http://<actual-public-ip>:6060/`, replacing the placeholder with the public IPv4 shown in EC2. Expected result is a page headed **Online Course Reservation** with the message **This demo page is served by Nginx on Amazon EC2.** If the local curl succeeds and the browser cannot connect, check the public IP, subnet route and inbound rule for TCP 6060.

### Clean up after capturing evidence

```bash
sudo docker stop app-demo
sudo docker rm app-demo
sudo docker rmi nginx-web
```

In the EC2 console, terminate the instance if you created it solely for this lab, then remove the lab-only security group if it is no longer attached. For a shared lab instance, remove only the resources and ingress rule you added.
