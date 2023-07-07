# AWS Terraform Module

This directory contains Terraform configurations for AWS resources including EC2 instances, Security Groups, VPC, and EC2 Keypair. The structure of the directory is as follows:

- `ec2.tf`: Contains the Terraform configuration for AWS EC2 instances.
- `ec2-sg.tf`: Contains the Terraform configuration for AWS EC2 Security Groups.
- `keypair.tf`: Contains the Terraform configuration for AWS EC2 Keypair.
- `vpc.tf`: Contains the Terraform configuration for AWS VPC (Virtual Private Cloud).

## Prerequisites

You should have the following installed on your system before you proceed:

- [Terraform](https://www.terraform.io/downloads.html) (version 0.13+)
- [AWS CLI](https://aws.amazon.com/cli/)

Make sure to configure your AWS credentials by running `aws configure`.

## Usage
export AWS_CREDS ( this creds are fake )
``` bash
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
```

Initialize the Terraform working directory:

```bash
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Apply the changes:

```bash
terraform apply
```

## Accessing the NGINX Server

Once the EC2 instance has been successfully deployed, an output named `ec2_public_ip` will be provided. This output contains the public IP address of the deployed EC2 instance where the NGINX server is running. Please note that it may take around 5-6 minutes for the instance to be fully configured and operational. 

To test the NGINX server, you can use the `curl` command with the public IP of the EC2 instance. To automatically repeat the curl command until a successful response is received, you can use a bash loop like this:

```bash
while true; do
    if curl -s "$(terraform output -raw ec2_public_ip)" >/dev/null
    then
        echo "Successfully connected to the NGINX server."
        break
    else
        echo "Unable to connect, retrying..."
        sleep 10
    fi
done
```

This script will continuously attempt to reach the NGINX server every 10 seconds, and will stop once a successful connection is made.





## Outputs

Please check each `outputs.tf` file for specific outputs produced by the corresponding resource.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support or any kind of issues, please raise an issue in the repository, providing as much information as possible.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.


## Extra credit #1:

Terraform maintains an internal database known as the "state" which contains the metadata of your infrastructure resources. This state file allows Terraform to map resources to configuration, track metadata, and improve performance for large infrastructures.

When working in a team or on a large-scale infrastructure, it's important to use remote state management. Remote state management allows state files to be stored on a remote server, which allows state to be shared between multiple team members, stored safely off of your local machine, and integrated with version control systems.

In this context, we propose to use the AWS S3 remote backend with a DynamoDB table for state locking.

### AWS S3 for Remote Backend

Amazon S3 is a reliable and secure object storage service. It is ideal for storing our Terraform state files due to its high durability and availability, versioning capabilities, and security features like encryption and access policies.

### DynamoDB for State Locking

In addition to the S3 backend, we propose the use of an AWS DynamoDB table for state locking. When working with shared states, it's important to avoid state corruption that can happen if multiple people attempt to run Terraform commands simultaneously. A lock on the state file ensures that only one person can modify the state at a time.

The backend can be configured in your Terraform script like this:

```hcl
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
    dynamodb_table = "mytable"
    encrypt = true
  }
}
```

### Pros, Cons, and Trade-offs

Pros:
- Using the S3 backend allows teams to share the state file, enhancing collaboration.
- The S3 backend is encrypted, providing an extra layer of security.
- Versioning capabilities of S3 allows you to keep track of and revert to previous states.
- The DynamoDB state lock prevents concurrent state operations, reducing the risk of state corruption.

Cons:
- There is additional complexity in setting up and managing the remote backend and state lock.
- Additional costs for storing the state file in S3 and using a DynamoDB table.

Trade-offs:
- While local state management might be simpler and cheaper, it lacks the scalability, collaboration facilitation, and security of remote state management.
- The additional complexity and cost is a trade-off for enhanced collaboration, scalability, and security.

Overall, using S3 and DynamoDB for remote state management is a solid choice for teams developing scalable infrastructure on AWS.