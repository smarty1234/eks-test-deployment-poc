Deploying Jenkins as a Kubernetes Service with Helm Chart

- Create a service account with sufficient permissions to deploy pods and access persistent volumes in EKS
  `kubectl create serviceaccount jenkins`
-  the cluster-admin role is a built-in Kubernetes role that grants full control over every resource in the cluster
   - Create an IAM Policy: Define a policy that grants the necessary permissions for the cluster-admin role.
     This policy should include permissions to perform actions on all Kubernetes resources within the EKS cluster.
   - Attach the Policy to an IAM Role or User: Once you have the policy, you can attach it to an IAM role or user.
     This role or user will then inherit the permissions defined in the policy.
   - Associate the IAM Role or User with the Kubernetes Cluster: Finally, you need to associate the IAM role or user with the Kubernetes cluster.
      This step allows the IAM entity to authenticate with the cluster and assume the cluster-admin role.

        `kubectl create clusterrolebinding jenkins-admin \
     --clusterrole=cluster-admin \
     --serviceaccount=default:jenkins`

