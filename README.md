# 🚀 Multi-Service Node.js E-commerce Deployment with Terraform and Docker

## 📘 Project Description

This project demonstrates the end-to-end deployment of a containerized Node.js-based e-commerce application consisting of four backend services (`user`, `products`, `orders`, `cart`) and one `frontend`, hosted on AWS EC2 instances using Terraform.

---

## 🎯 Objective

Provision infrastructure and deploy five Dockerized microservices on AWS using Terraform. The frontend must be accessible via a public IP or DNS, and all services should be up and running via EC2.

---

## 🛠️ Tech Stack

- **Node.js** (Service Logic)
- **MongoDB Atlas** (Database)
- **Docker** (Containerization)
- **AWS EC2** (Deployment)
- **Terraform** (Infrastructure as Code)

---

## 📁 Directory Structure

```
E-CommerceStore/
│
├── backend/
│   ├── user-service/
│   ├── product-service/
│   ├── order-service/
│   └── cart-service/
│
├── frontend/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── user_data.sh
```

---

## ✅ Application Setup (Manual)

### 1. Create Dockerfiles for All Services

Each service should have a `Dockerfile` exposing the relevant port and returning a test response like `"User Service Running"`.

### 2. Build and Test Images Locally

```bash
docker build -t <your-dockerhub-username>/user-service ./backend/user-service
docker run -d -p 3001:3001 <your-dockerhub-username>/user-service
```

### 3. Tag and Push to DockerHub

```bash
docker tag <local-image> <your-dockerhub-username>/user-service
docker push <your-dockerhub-username>/user-service
```

Repeat the same for all other services (`product`, `cart`, `order`, `frontend`).

---

## ☁️ Infrastructure Provisioning with Terraform

### 1. Components

- **VPC** with at least one **public subnet**
- **Internet Gateway**, **Route Table**, and **Security Groups**
- **EC2 instance(s)** to host Docker containers

### 2. Sample Terraform Workflow

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

> The `user_data.sh` script installs Docker, pulls all Docker images, and runs containers.

---

## 🌐 Public Access and Validation

- Access the frontend via: `http://<public-ip>:3000`
- Check backend health via: `http://<public-ip>:3001`, `:3002`, etc.
- Use `terraform output` to get the public IP.

---

## 📷 Add Screenshots

You may add screenshots in the following places (create `images/` folder):

## ✅ DockerHub Repositories Pics-

<img width="623" height="221" alt="image" src="https://github.com/user-attachments/assets/2333cbc1-ae90-4614-9bda-8fa3199de21b" /><br>


<img width="633" height="94" alt="Screenshot 2025-07-27 191956" src="https://github.com/user-attachments/assets/91988df4-990f-4d0d-a59a-46d6d41bd34c" /><br>


<img width="733" height="134" alt="Screenshot 2025-07-28 024453" src="https://github.com/user-attachments/assets/68d8a868-5c2f-414c-84d0-4b25179254a4" /><br>


<img width="943" height="171" alt="Screenshot 2025-07-28 024512" src="https://github.com/user-attachments/assets/cfc794e1-d9d9-40bb-b026-c6492bb565b7" /><br>


--------------


## ✅ EC2 Running with Docker Containers Pics:


<img width="947" height="285" alt="Screenshot 2025-07-28 143215" src="https://github.com/user-attachments/assets/4ae867f8-90a8-4d93-8a06-60fbcfe8f3c6" /><br>


<img width="647" height="311" alt="Screenshot 2025-07-29 031344" src="https://github.com/user-attachments/assets/c49fa12c-7bce-4308-8040-87104f6c8697" /><br>


<img width="589" height="130" alt="Screenshot 2025-07-29 031833" src="https://github.com/user-attachments/assets/c0ef0f08-ca95-478b-aed4-03b1032b38aa" /><br>


<img width="663" height="92" alt="Screenshot 2025-07-29 032012" src="https://github.com/user-attachments/assets/502fe196-4c7c-42fa-bdba-feaecc97cd02" /><br>


<img width="631" height="141" alt="Screenshot 2025-07-29 032230" src="https://github.com/user-attachments/assets/70a9fa37-1196-4ff4-b0a6-ed301f977e11" /><br>


--------------


## ✅ Terraform Apply Pics-

<img width="467" height="191" alt="Screenshot 2025-07-29 022639" src="https://github.com/user-attachments/assets/953b95b8-b604-4004-8363-7a021ba45521" /><br>


<img width="479" height="287" alt="Screenshot 2025-07-29 022933" src="https://github.com/user-attachments/assets/0e819e5b-9391-4045-b076-d20f922c0f41" /><br>


<img width="760" height="169" alt="Screenshot 2025-07-28 215706" src="https://github.com/user-attachments/assets/8b9c8a8d-803b-42b7-8937-5e190f57c317" /><br>


<img width="834" height="146" alt="Screenshot 2025-07-28 221057" src="https://github.com/user-attachments/assets/7171504f-0039-4f83-9aaa-086b0724c07c" /><br>


<img width="848" height="166" alt="Screenshot 2025-07-28 221435" src="https://github.com/user-attachments/assets/65f9a00b-62ba-426f-9bc7-9b9438288f97" /><br>


<img width="836" height="174" alt="Screenshot 2025-07-28 221952" src="https://github.com/user-attachments/assets/f02e5b22-d022-4558-8434-f1a47a1034fa" /><br>


--------------

  
- ✅ Frontend Access in Browser Pic -


<img width="948" height="470" alt="Screenshot 2025-07-29 013316" src="https://github.com/user-attachments/assets/6c31501e-bf70-4fe5-b820-3c836ffbf660" /><br>


-------------------------


## 🧪 Testing Strategy

- `curl http://localhost:<PORT>` for manual testing
- `docker ps` to verify containers are running
- Add `/health` endpoint for each service for health check
- Use MongoDB Compass to check if data is being inserted

---

## ⚠️ Notes & Constraints

- Use **Ubuntu 22.04 AMI** on EC2
- Use **public DockerHub** images
- All deployments should be reproducible with `terraform apply`

---

## 👨‍💻 Author

Minnath Dhani  
GitHub: [minnathdhani](https://github.com/minnathdhani)

---

## 📄 License

This project is licensed under the MIT License.
