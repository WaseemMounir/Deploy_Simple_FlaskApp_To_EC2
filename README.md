# Deploy Simple Flask APP into AWS EC2 using jenkins pipeline and anible playbook.

Objective:
Implement a fully automated CI/CD pipeline using Jenkins, Docker, and Ansible to deploy a simple Flask application on an EC2 instance. The pipeline will automate the processes of code integration, containerization, and deployment to a cloud environment.

# Technologies Used:
    •  Jenkins for continuous integration
    •  Docker for containerization
    •  Flask for creating the web application
    •  Ansible for deployment configuration and management
    •  Git for source code management
    •  AWS EC2 for cloud hosting

# Add Github and Dockerhub credentials in Jenkins
    Manage Jenkins > Manage Credentials > Global > Add Credentials
    - From Github create access token as below:
      settings > Developer settings > Personal access tokens > tokens (classic)
    - From Docker Hub create 
      Account settings > Personal access tokens > Create new token

# Pipeline Architecture:
   
- Stages of the Pipeline:
```
1. Clone Code from Repository
2. Build Docker Image
3. Push Image to Docker Hub
4. Deploy Application using Ansible on EC2
5. Send Email Notification on Success or Failure or any other status:
    •	Install the "Email Extension Plugin" in Jenkins.
    •	Go to Jenkins -> Manage Jenkins -> Configure System.
    •	Scroll to "Extended E-mail Notification" and configure the SMTP server details (e.g., smtp.gmail.com, port 465).
    •	Set the default email suffix (e.g., @yourdomain.com).
    •	Add the following stage to the Jenkins pipeline to send
```

# Adding Local hook To trigger the Jenkins pipeline automatically when a commit is made to a Git repository
    - Navigate to your local Git repository's .git/hooks directory.
    - Create a file named post-commit 

  Add Hook Script:

```
#!/bin/sh

#Replace with your Jenkins URL and job name

JENKINS_URL="http://localhost:8080"
JOB_NAME="your-job-name"

#Trigger Jenkins job using curl

curl -X POST "$JENKINS_URL/job/$JOB_NAME/build" --user your-jenkins-username:your-api-token
```

#Ensure the hook script is executable by running:

      # chmod +x .git/hooks/post-commit

# to Add and Push changes.
```
  - git add .
  - git commit -m "Modified"
  - git push origin main
```

# Connect to EC2 via SSH:

Step 1: Generate a new SSH key pair (if you don’t have one)
```
   - Open a terminal window on your local machine.
   - ssh-keygen -t rsa -b 2048 -f ~/.ssh/aws_ec2_key
  This command generates a new SSH key pair named aws_ec2_key with a 2048-bit RSA encryption algorithm. It will prompt you to optionally 
   - add a passphrase for additional security.
```

Step 2: Upload the public key to AWS
```
   - Go to the AWS Management Console and navigate to the EC2 dashboard.
   - Click on “Key Pairs” under “Network & Security” in the left sidebar.
   - Click on the “Import Key Pair” button.
   - Provide a name for your key pair (e.g., aws_ec2_key) and paste the contents of the public key file (aws_ec2_key.pub) into the "Public Key Contents" field.
   - Click “Import” to upload the key pair.
   - Step 3: SSH into your EC2 instance using the private key
```
Change the permissions of the private key file to make it readable only by you:
   - chmod 400 ~/.ssh/aws_ec2_key

Use the ssh command to connect to your EC2 instance:

ssh -i ~/.ssh/aws_ec2_key ec2-user@<YOUR_EC2_PUBLIC_IP>

   
