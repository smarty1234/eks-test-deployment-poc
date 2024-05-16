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
17. configured the Docker Hub credential (using Docker Hub account credentials)
18. Jenkins url not needed as this itself in EKS
19. GitHub credentials (using GitHub account credential token)

20. Once Jenkins restart - use this repo and point to JenkinsFile-1
21. Jenkins agent reference: `https://github.com/jenkinsci/docker-agent`