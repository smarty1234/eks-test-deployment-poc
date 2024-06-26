# Deploying Jenkins as a Kubernetes Service with Helm Chart
## Preinstall Check of EKS

1. Open a terminal in MacBook and Apply SSO KEYS as follows
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
```
2. assuming kubectl is already installed
`aws eks update-kubeconfig --region us-east-2 --name <cluster name>`
3. Verify kubectl is working `kubectl get ns`

## deployment of jenkins in EKS
4. Create a name spece for devops tools: `kubectl create namespace devops-tools`
5. `cd jenkins-eks`
6. `kubectl apply -f sa.yaml` < create service account
7. get hostname of node to create PVC: `kubectl get nodes`
```
bash-3.2$ kubectl get nodes
NAME                                       STATUS   ROLES    AGE     VERSION
ip-10-0-52-70.us-east-2.compute.internal   Ready    <none>   6d18h   v1.29.3-eks-ae9a62a
```
8. add the node to the volume.yaml and execute: `kubectl create -f volume.yaml`
9. Deploy jenkins: `kubectl apply -f deployment.yaml`
10. Make sure it is done: `kubectl describe deployments --namespace=devops-tools`
11. Add service as node-port 32000: 
```
bash-3.2$ kubectl get pods -n devops-tools
NAME                      READY   STATUS    RESTARTS   AGE
jenkins-bf6b8d5fb-2gfk8   1/1     Running   0          88m
```
`kubectl exec -it jenkins-bf6b8d5fb-2gfk8 cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools`

12. Open Jenkins UI at <Node-PublicIP>:32000and use the above password

## Do a test build to validate Jenkins using docker

1. Open the IAM role  attached to the VM and add policy `AmazonEC2RoleforSSM` and `AmazonSSMManagedEC2InstanceDefaultPolicy`
2. login to ECE Amazon Linux
3. `yum update` yes
4. `yum search docker`
5. `yum info docker`
6. `yum install docker` y
7. `usermod -a -G docker ec2-user`
8. `id ec2-user`
9. `newgrp docker`
10. `systemctl enable docker.service`
11. `systemctl start docker.service`
12. `docker ps`
13. `yum install git` y
14.  Install the `docker pipeline` plugin, `Amazon EC2` plugin, `Docker` Plugin, `GitHub Integration` plugin, `Kubernetes` plugin, `Kubernetes CLI`, `Kubernetes Credentials Provider`, `Kubernetes Pipeline Plugin` and `Parameterized Trigger ` plugin and Restart
15. Go to cluster and get Cluster API url: `https://5F165D57YYSYSYSS9DEF3A3DSSSC175.gr7.us-east-2.eks.amazonaws.com`
16. jenkins, add cloud named `Kubernetes` - give above url and select service account. Test connection
17. Pad Labels: Key: `jenkins` Value: `agent` - Save
18. Go to Pod Template: `jenkins/inbound-agent:4.3-7-alpine` working directory `/home/jenkins/agent` - remove sleep and 999999 etc.
19. `http://ec2-52-15-142-162.us-east-2.compute.amazonaws.com:32000/job/test1/configure` add Label Expression: `kubeagent`
20. Go to Build Steps - bring up Shell - `echo Testing` - Save and click `Build Now`

17. configured the Docker Hub credential (using Docker Hub account credentials)
18. Jenkins url not needed as this itself in EKS
19. GitHub credentials (using GitHub account credential token)
20. install java in node: `yum search java-17-amazon-corretto-headless` at /tmp
21. `yum install java-17-amazon-corretto-headless.x86_64`
22. `java --version`
```
root@ip-10-0-52-70 tmp]# java --version
openjdk 17.0.11 2024-04-16 LTS
OpenJDK Runtime Environment Corretto-17.0.11.9.1 (build 17.0.11+9-LTS)
OpenJDK 64-Bit Server VM Corretto-17.0.11.9.1 (build 17.0.11+9-LTS, mixed mode, sharing)
```
23. Open jnlp port `50000` from `3.16.146.0/29`
24. install `kubectl`
```
`cd /tmp`
`curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
`
`chmod +x ./kubectl`
`mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH`
`su - ec2-user`
`mkdir -p $HOME/bin && cp /tmp/kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH`
```
25. verify version
```
[ec2-user@ip-10-0-52-70 ~]$ kubectl version
Client Version: v1.29.3-eks-ae9a62a
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
```
26. update to latest version of aws cli
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
```
27. Verify
```
[root@ip-10-0-52-70 tmp]# /usr/local/bin/aws --version
aws-cli/2.15.51 Python/3.11.8 Linux/5.10.215-203.850.amzn2.x86_64 exe/x86_64.amzn.2
```
28. Execute the following in a new job test-kubectl
```
/usr/local/bin/aws --version
kubectl version
aws eks update-kubeconfig --region us-east-2 --name mpadhi-test-cluster
kubectl get pods -n devops-tools
kubectl get pods -A
kubectl get deployment -n devops-tools
kubectl get svc -n devopstools
```
23. Once Jenkins restart - use this repo and point to JenkinsFile-1
24. Jenkins agent reference: `https://github.com/jenkinsci/docker-agent`
