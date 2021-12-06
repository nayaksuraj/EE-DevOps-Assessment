
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#setup-configuration">Setup Configuration</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#my-github-statistics">My GitHub Statistics</a></li>
  </ol>
</details>


***
 
<!-- ABOUT THE PROJECT -->

<details>
    <summary>DevOps Assessment</summary>
    
## About The Project
* [VPC Module Link](/aws-infra-tf-modules/vpc-network)
* [CI-CD Infra](/aws-infra-tf-modules/ci-cd-infra)
* [Application Infra](/aws-infra-tf-modules/application-infra)

![Solution Architecture][solution-screenshot]

The VPC Module will provision components as follows:
* VPC
* Subnets (Private, Public)
* InternetGateway
* NAT Gateway (Highly Available)
* Route Tables & NACLs
* EIPs


The CI-CD Module will provision components as follows:
* Autoscaling-Group & Launch Template (Using AMI with Jenkins Installed)
* IAM Instance profile & SSH key for node access
* Application Load Balancer, Target Group & Listener Rule
* Security Groups
* EC2 userdata script installs AWSCLI, SSM Agent, Docker & Ansible


The Application Module will provision components as follows:
* Autoscaling-Group & Launch Template
* IAM Instance profile & SSH key for node access
* Application Load Balancer, Target Group & Listener Rule
* Security Groups
* EC2 user data scritp installs AWSCLI, SSM Agent & Nginx Server
</details>

***


### Built With

Used below tools:
* [Terraform](https://www.terraform.io/)
* [Packer](https://www.packerio/)


<!-- GETTING STARTED -->

### Prerequisites
To run the terraform deployment from local we should have below installation in our machine
* Terraform 
    - [Terraform Executable](https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip)
    - [Terraform Installation Doc.](https://learn.hashicorp.com/tutorials/terraform/install-cli)

* Install AWS Cli V2 
    - [AWS CLI Installation Doc.](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

* Install Packer
    - [Packer Executable](https://releases.hashicorp.com/packer/packer_1.7.4)



### Setup Configuration

* Configure IAM credentials to access AWS environment, all the script uses aws default profile from local.
* Create AMI for Jenkins server using packer. This will configure Jenkins with Admin user & password.
    - [Jenkins-AMI](ami-creation-script.sh)
  ```
    ./ami-creation-script.sh >> output-logs.txt
  ```
* To trigger the deployment of VPC module, please use below script.
    - [VPC Deployment](vpc-infra-deployment-script.sh)
  ```
    ./vpc-infra-deployment-script.sh >> output-logs.txt
  ```
* To trigger the deployment of CI-CD module, please use below script.
    - [CI-CD Deployment](ci-cd-infra-deployment-script.sh)
  ```
    ./ci-cd-infra-deployment-script.sh >> output-logs.txt
  ```
* To trigger the deployment of Application module, please use below script.
    - [Application Deployment](vpc-infra-deployment-script.sh)
  ```
    ./vpc-infra-deployment-script.sh >> output-logs.txt
  ```
  



<!-- CONTACT -->
## Contact

Vivek Mishra - [@linkedin](https://www.linkedin.com/in/vivek-mishra-22aa44bb55cc/) - vivekkmishra2020@gmail.com


<!-- GitHub Stats -->
## My GitHub Statistics

![Vivek Mishra github stats](https://github-readme-stats.vercel.app/api?username=vivek22117&show_icons=true&theme=tokyonight)
<img src="https://github-readme-streak-stats.herokuapp.com/?user=vivek22117&theme=tokyonight" alt="mystreak"/>
![Vivek's Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=vivek22117&theme=tokyonight&layout=compact)




<!-- MARKDOWN LINKS & IMAGES -->
[solution-screenshot]: images/Solution_Design.svg
