# 🛒 E-CommerceStore – Multi-Service Node.js App with Terraform & Docker Deployment

This project showcases a full-stack **E-Commerce Microservices** application built using Node.js and React, and deployed on **AWS EC2 using Terraform and Docker**.

> 🔧 Backend services: User, Product, Cart, Order  
> 🎨 Frontend: React App  
> ☁️ Deployment: EC2 Ubuntu with Docker (via `user_data.sh`)  
> ⚙️ IaC: Terraform

---

## 📦 Microservices Overview

| Service       | Port | Description                        |
|---------------|------|------------------------------------|
| Frontend      | 3000 | React UI for E-Commerce Store      |
| User Service  | 3001 | Authentication & user management   |
| Product       | 3002 | Product listings & categories      |
| Cart          | 3003 | Cart operations                    |
| Order         | 3004 | Order processing and payments      |

---

## 🚀 Live Deployment Architecture

📸 *Insert architecture diagram here (e.g., Terraform flow or container layout)*  
📁 Suggested location: `docs/architecture.png`  
```markdown
![Architecture](docs/architecture.png)
```

```
Internet → EC2 (Ubuntu + Docker)
            ├── frontend-service :3000
            ├── user-service     :3001
            ├── product-service  :3002
            ├── cart-service     :3003
            └── order-service    :3004
```

---

## 📁 Project Structure

```
E-CommerceStore/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── user_data.sh
├── backend/
│   ├── user-service/
│   ├── product-service/
│   ├── cart-service/
│   └── order-service/
├── frontend/
└── README.md
```

---

## ⚙️ Prerequisites

- AWS Account + IAM User with EC2 permissions
- EC2 Key Pair (`.pem` file)
- DockerHub account (public images pushed)
- Terraform v1.5+ installed locally
- AWS CLI installed and configured (`aws configure`)

---

## 🛠️ Setup & Usage

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/minnathdhani/E-CommerceStore.git
cd E-CommerceStore/terraform
```

---

### 2️⃣ Update `main.tf`

- Set your key pair name:
```hcl
key_name = "minnath-key"
```

- Make sure your DockerHub username is used in `user_data.sh`.

---

### 3️⃣ Initialize and Deploy via Terraform

📸 *Insert screenshot of Terraform commands (`terraform init` and `terraform apply`)*  
📁 Suggested location: `docs/terraform-apply.png`  
```markdown
![Terraform Apply](docs/terraform-apply.png)
```

```bash
terraform init
terraform apply -auto-approve
```

> This will create a VPC, subnet, EC2 instance, security groups, and run Docker containers via `user_data.sh`.

---

### 4️⃣ Access the App in Browser

```
Frontend:       http://<EC2_PUBLIC_IP>:3000
User Service:   http://<EC2_PUBLIC_IP>:3001
Product:        http://<EC2_PUBLIC_IP>:3002
Cart:           http://<EC2_PUBLIC_IP>:3003
Order:          http://<EC2_PUBLIC_IP>:3004
```

📸 *Insert screenshot of the browser output showing “Frontend is Live”*  
📁 Suggested location: `docs/frontend-live.png`

---

## 🧪 Testing

Use `curl` or Postman to test endpoints:

```bash
# Register a new user
curl -X POST http://<EC2_PUBLIC_IP>:3001/api/auth/register \
-H "Content-Type: application/json" \
-d '{"firstName":"John","lastName":"Doe","email":"john@example.com","password":"password123"}'
```

📸 *Insert screenshot of Postman tests or curl output*  
📁 Suggested location: `docs/test-user-api.png`

---

## 📂 .gitignore Notes

Make sure to ignore large/auto-generated files:

```
.terraform/
*.tfstate
*.tfstate.backup
*.pem
*.zip
crash.log
```

---

## ✅ Cleanup

```bash
terraform destroy -auto-approve
```

---

## 📌 Author

👤 Minnath Dhani  
📧 minnathdhani@gmail.com

---

## 📈 Future Improvements

- CI/CD using GitHub Actions or Jenkins
- MongoDB Atlas integration
- API Gateway + Load Balancer setup
- ECS or EKS for container orchestration
