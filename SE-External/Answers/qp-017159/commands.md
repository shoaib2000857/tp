# Commands to run in the lab

## Q3 — Scale Nginx with Kubernetes

**Prerequisites.** Docker running, Minikube and `kubectl` on PATH, and local port 8081 available. Use a fresh lab profile so the `mynginx` name is available. The Deployment manages identical Nginx Pods. Scaling changes the desired Pod count from one to four. The Service selects the ready Pods and gives clients a stable endpoint.

Run in a lab terminal:

```bash
minikube start -p se-lab --driver=docker
minikube status -p se-lab
kubectl --context se-lab create deployment mynginx --image=nginx
kubectl --context se-lab rollout status deployment/mynginx --timeout=180s
kubectl --context se-lab get deployment,pods
kubectl --context se-lab expose deployment mynginx --type=NodePort --port=80 --target-port=80
kubectl --context se-lab scale deployment mynginx --replicas=4
kubectl --context se-lab rollout status deployment/mynginx --timeout=180s
kubectl --context se-lab get deployment,pods,svc
kubectl --context se-lab get endpointslice -l kubernetes.io/service-name=mynginx
kubectl --context se-lab port-forward svc/mynginx 8081:80
```

Keep port forwarding running. Open `http://localhost:8081/` or run `curl -fsS http://localhost:8081/` in another terminal. Expected Deployment readiness is `1/1` before scaling and `4/4` after scaling, with four ready Pods in the final Pod list and the Nginx welcome page in the browser. The port-forward verifies HTTP access to a Pod selected through the Service. Use the EndpointSlice and Pod output as evidence of the replicas.

If Pods fail to become ready, inspect `kubectl --context se-lab describe pods -l app=mynginx` and `kubectl --context se-lab logs deployment/mynginx`. If port 8081 is occupied, choose another local port or use `minikube -p se-lab service mynginx --url` and open the returned URL. Keep that command running if it opens a tunnel. The handout's `myngnix` typo is corrected to `mynginx` throughout.

After capturing evidence, press Ctrl+C in the forwarding terminal and run:

```bash
kubectl --context se-lab delete service mynginx
kubectl --context se-lab delete deployment mynginx
minikube stop -p se-lab
```

To remove the dedicated lab cluster as well, run `minikube delete -p se-lab`.

## Q4 — Deploy a Maven web app on AWS EC2

**Prerequisites.** A lab-authorized AWS account, a GitHub repository you control, an SSH client and network access for GitHub, Maven and container downloads. This uses an Ubuntu EC2 instance with a public IPv4 address. The sample is a Maven WAR with one JSP. Assume its repository is publicly readable for the clone step. If using a private repository, use your lab's authorized Git authentication method. The multi-stage Dockerfile builds the WAR with Maven and deploys it as `ROOT.war` to Tomcat 9. The instance needs Docker and Git.

### 1. Publish the sample

Create an empty GitHub repository you control. On the lab computer, open Bash in `aws-webapp/`. Run the following in a fresh copy of the folder, entering the actual repository clone URL. GitHub authentication and Git author identity must already be configured for the push.

```bash
read -r -p 'GitHub repository clone URL: ' WEB_REPO_URL
git init
git add pom.xml Dockerfile src
git commit -m 'Add Maven web app for EC2 lab'
git branch -M main
git remote add origin "$WEB_REPO_URL"
git push -u origin main
```

### 2. Launch Ubuntu and connect

1. In AWS Console, open **EC2 → Launch instance**. Choose a region allowed by the lab, one Ubuntu Server 64-bit instance, the lab-approved instance type (the handout uses `t2.micro`), and an 8 GiB root disk if accepted by the selected AMI. Check pricing and eligibility shown in the console before launch.
2. Create or select a key pair. If creating one, save its `.pem` privately. Select a public subnet with a route to an Internet Gateway and enable public IPv4 assignment. Add security group inbound rules for **SSH TCP 22** from your own public IP and **Custom TCP 6060** from the address range that should test the app. For public access from any IPv4 address during the lab, set the 6060 rule to `0.0.0.0/0`. The handout's HTTP and HTTPS rules cover ports 80 and 443. This deployment publishes HTTP on 6060, so it needs the explicit 6060 rule.
3. Wait for instance status checks, then open **Connect → SSH client**. In the local terminal, change to the directory holding your `.pem` file. On Linux or macOS, use the first command below to restrict key permissions, then paste the exact `ssh -i` command from the AWS console. On Windows, use the console command in your SSH terminal and apply restrictive key permissions if prompted.

```bash
read -r -p 'Path to your EC2 PEM file: ' EC2_KEY_FILE
chmod 400 "$EC2_KEY_FILE"
```

### 3. Build, run and verify

Run on the connected Ubuntu instance. Enter the same repository clone URL. `app-demo` is the chosen local container name and image tag.

```bash
sudo apt update
sudo apt-get install -y docker.io
sudo apt install -y git curl
sudo systemctl enable --now docker
read -r -p 'GitHub repository clone URL: ' WEB_REPO_URL
git clone "$WEB_REPO_URL" ec2-webapp
cd ec2-webapp
sudo docker build -t app-demo .
sudo docker images app-demo
sudo docker run -d --name app-demo -p 6060:8080 app-demo
sudo docker ps --filter name=app-demo
sudo docker logs app-demo
curl -fsS http://localhost:6060/
```

Allow Tomcat a few seconds to start before retrying `curl` if necessary. From your lab computer, open `http://<EC2-public-IPv4>:6060/` using the actual address listed in EC2. Expected output is the page heading **Course Reservation Demo**. The image name is a tag you assign. Use the real instance address shown in AWS. The Docker flags use ASCII hyphens and the build context is the literal `.`.

If local curl works and the browser times out, check the public IP, the inbound 6060 rule and the subnet route. For a 404, inspect the container logs for WAR deployment and confirm the URL ends in `/` because the app is installed at the root context.

### 4. Clean up

On EC2, after capturing evidence:

```bash
sudo docker stop app-demo
sudo docker rm app-demo
sudo docker rmi app-demo
exit
```

In the AWS console, remove the temporary 6060 rule. Stop the instance if the lab requires keeping it, or terminate your disposable lab instance after saving evidence. Check the lab's instructions for retaining disks and any other resources created for the exercise.