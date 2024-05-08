Deploying Jenkins as a Kubernetes Service with Helm Chart

1. Create a service account with sufficient permissions to deploy pods and access persistent volumes in EKS
  `kubectl create serviceaccount jenkins`
-  the cluster-admin role is a built-in Kubernetes role that grants full control over every resource in the cluster
   - Create an IAM Policy: Define a policy that grants the necessary permissions for the cluster-admin role.
     This policy should include permissions to perform actions on all Kubernetes resources within the EKS cluster.
   - Attach the Policy to an IAM Role or User: Once you have the policy, you can attach it to an IAM role or user.
     This role or user will then inherit the permissions defined in the policy.
   - Associate the IAM Role or User with the Kubernetes Cluster: Finally, you need to associate the IAM role or user with the Kubernetes cluster.
      This step allows the IAM entity to authenticate with the cluster and assume the cluster-admin role.

2.        `kubectl create clusterrolebinding jenkins-admin 
     --clusterrole=cluster-admin 
     --serviceaccount=default:jenkins`

3. Add the official Jenkins Helm repository to your local Helm client
    `helm repo add jenkins https://charts.jenkins.io`
     `helm repo update`

4. `helm install mypocjenkins jenkins/jenkins \
  --set persistence.enabled=true \
  --set persistence.storageClass=io1 \
  --set serviceAccount.name=jenkins \
  --set service.type=LoadBalancer`
# Jenkins is build heavy - used io1 type storage class
5. `kubectl get service mypocjenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`
6. `kubectl logs pod/mypocjenkins-init -c init-jenkins` # get first time password
7. Used Route53 to use the ALB as CNAME and add a domain with ACM
8. Open Jenkins in GUI
9. If things don't work trouble shoot - Security Groups, Network use Amazon VPC Reachability Analyzer
