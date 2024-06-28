## Documentation for Building, Running, and Deploying the Application

---

### 1. How to Build and Run the Docker Container

**Step 1: Building the Docker Container**

1. Navigate to your project directory:
   ```bash
   cd /path/to/your/ipfs-metadata
   ```

2. Ensure the Dockerfile is present in the root of your project directory:

   ```
   # Start with the official Golang base image
   FROM golang:1.21-alpine

   # Set the Current Working Directory inside the container
   WORKDIR /app

   # Copy go.mod and go.sum files
   COPY go.mod go.sum ./

   # Download all dependencies
   RUN go mod download

   # Copy the source from the current directory to the Working Directory inside the container
   COPY . .

   # Build the Go app
   RUN go build -o main .

   # Expose port 8080 to the outside world
   EXPOSE 8080

   # Command to run the executable
   CMD ["./main"]
   ```

3. Build the Docker image:
   ```bash
   docker build -t your_dockerhub_username/ipfs-metadata:latest .
   ```

**Step 2: Running the Docker Container**

1. Run the Docker container:
   ```bash
   docker run -d -p 8080:8080 \
   -e POSTGRES_HOST=your_postgres_host \
   -e POSTGRES_PORT=5432 \
   -e POSTGRES_USER=your_postgres_user \
   -e POSTGRES_PASSWORD=your_postgres_password \
   -e POSTGRES_DB=your_postgres_db \
   your_dockerhub_username/ipfs-metadata:latest
   ```

2. Verify the container is running:
   ```bash
   docker ps
   ```

---

### 2. How to Trigger the CI/CD Pipeline

**GitHub Actions Workflow**

1. Create a `.github/workflows/main.yml` file in your repository:

   ```
   name: Build and Push Docker Image to ECR

   on:
     push:
       branches:
         - main

   jobs:
     build-and-push:
       runs-on: ubuntu-latest

       steps:
       - name: Checkout code
         uses: actions/checkout@v2

       - name: Configure AWS credentials
         uses: aws-actions/configure-aws-credentials@v1
         with:
           aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
           aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
           aws-region: us-east-1  # Ensure this matches your ECR region

       - name: Login to Amazon ECR
         id: login-ecr
         run: |
           aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b2f2g3q4

       - name: Build and push Docker image
         id: build-and-push
         uses: docker/build-push-action@v2
         with:
           context: .
           push: true
           tags: public.ecr.aws/b2f2g3q4/ipfs-metadata:01

       - name: Image digest
         run: echo ${{ steps.build-and-push.outputs.digest }}
   ```

2. Set up your GitHub Secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.
   - `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.

3. Push the changes to your repository:
   ```bash
   git add .github/workflows/main.yml
   git commit -m "Add CI/CD pipeline"
   git push origin main
   ```

This will trigger the CI/CD pipeline whenever changes are pushed to the `main` branch.

---

### 3. How to Deploy the Application Using Terraform

**Step 1: Initialize Terraform**

1. Navigate to your Terraform configuration directory:
   ```bash
   cd /path/to/your/terraform/configuration
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

**Step 2: Apply the Terraform Configuration**

1. Apply the Terraform configuration:
   ```bash
   terraform apply -auto-approve
   ```

This will create the required AWS resources (VPC, subnets, RDS instance, ECS service) based on the configurations defined.

---

### 4. Assumptions and Prerequisites

**Assumptions**

- You have a Docker Hub account and have set up Docker on your local machine.
- You have an AWS account with appropriate permissions to create resources such as VPCs, subnets, RDS instances, and ECS services.
- You are familiar with basic Terraform commands and AWS services.
- Your Go application is properly configured to connect to the PostgreSQL database using environment variables.

**Prerequisites**

1. **Docker**: Install Docker on your local machine.
   - [Docker Installation Guide](https://docs.docker.com/get-docker/)

2. **Terraform**: Install Terraform on your local machine.
   - [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)

3. **AWS CLI**: Install the AWS CLI and configure it with your AWS credentials.
   - [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
   - Configure AWS CLI:
     ```bash
     aws configure
     ```

4. **GitHub Repository**: Create a GitHub repository to store your code and configurations.

5. **GitHub Secrets**: Set up the necessary secrets in your GitHub repository for Docker Hub and AWS credentials.

---

By following these instructions, you should be able to build and run the Docker container, trigger the CI/CD pipeline, and deploy the application using Terraform. 
