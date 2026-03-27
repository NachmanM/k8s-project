# aws-k8s-platform

A fully automated, self-managed Kubernetes cluster provisioned on AWS from scratch.
Covers the complete infrastructure lifecycle: cloud provisioning, cluster bootstrapping,
workload deployment, and monitoring — all driven by a single command.

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws)

## Architecture
```
apply.sh
  ├── Terraform apply       → EC2 master + ASG worker nodes, ALB/NLB, SGs, IAM, Route53
  └── Ansible playbook      → kubeadm init on master, worker join, CNI (Flannel)
                                └── k8s manifests applied → workloads + monitoring stack
```

## Stack

| Layer | Technology |
|---|---|
| Cloud Infrastructure | AWS (EC2, ASG, ALB/NLB, SG, IAM, Route53) |
| Infrastructure as Code | Terraform |
| Cluster Bootstrap | Ansible + kubeadm |
| Container Orchestration | Kubernetes |
| Monitoring | Prometheus + Grafana (Monitor/) |
| Automation | Shell scripts |

## Project Structure
```
aws-k8s-platform/
├── Terraform/              # AWS infrastructure modules
├── Ansible/                # kubeadm bootstrap playbooks + EC2 dynamic inventory
├── k8s/                    # Kubernetes manifests
├── Monitor/                # Monitoring stack (Prometheus, Grafana)
├── apply.sh                # Full provisioning: Terraform → Ansible
├── destroy.sh              # Full teardown
└── restart.sh              # Cluster restart
```

## How It Works

### 1. Infrastructure (Terraform)
Provisions all AWS resources from code: EC2 master node, Auto Scaling Group for
workers, load balancers, security groups with least-privilege rules, IAM instance
profiles, and Route53 DNS.

### 2. Cluster Bootstrap (Ansible)
Runs against the EC2 dynamic inventory immediately after Terraform completes.
Executes `kubeadm init` on the master, distributes the join command to workers,
and deploys Flannel as the CNI.

### 3. Workloads & Monitoring (Kubernetes)
Applies manifests from `k8s/` and `Monitor/` — including the monitoring stack
(Prometheus + Grafana) for cluster observability.

## Quickstart

**Prerequisites:** AWS CLI authenticated, Terraform >= 1.0, Ansible, Python venv
```bash
# Full provision (infra + cluster + workloads)
./apply.sh

# Tear down everything
./destroy.sh

# Restart cluster
./restart.sh
```

## Contributors

- [@NachmanM](https://github.com/NachmanM)
- [@Hi9841](https://github.com/Hi9841)
