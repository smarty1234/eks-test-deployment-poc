# eks-test-deployment-poc

```
bash-3.2$ aws configure sso
SSO session name (Recommended): test-poc
SSO start URL [None]: https://d-222840051954.awsapps.com/start
SSO region [None]: us-east-1
SSO registration scopes [sso:account:access]:
Attempting to automatically open the SSO authorization page in your default browser.
If the browser does not open or you wish to use a different device to authorize this request, open the following URL:

https://device.sso.us-east-1.amazonaws.com/

Then enter the code:

ZVQH-FDLM
The only AWS account available to you is: 222840051954
Using the account ID 222840051954
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
CLI default client Region [you can authenticate Docker to an Amazon ECR private registry with get-login-password (recommended)]:
CLI default output format [None]:
CLI profile name [AdministratorAccess-222840051954]:

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile AdministratorAccess-222840051954
bash-3.2$ 

bash-3.2$ export AWS_PROFILE=AdministratorAccess-222840051954
bash-3.2$ terraform plan -var-file=poc.tfvars
```
- Please Read the Readme_EKS.md to create the EKS cluster
- Please Read the Readme_deployJenkins.md to deploy the helm chart
- Please Read the Readme_weatherApp.md to deploy the microservice
