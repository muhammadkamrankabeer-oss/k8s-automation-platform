# Kubernetes Automation Platform

Production-style Kubernetes cluster automation using:

- Vagrant
- Ansible
- kubeadm
- containerd
- GitHub Actions

---

# Project Goal

This project automates Kubernetes cluster deployment in a local lab environment using Infrastructure as Code and Configuration Management principles.

The platform provisions:

- Kubernetes master node
- Kubernetes worker nodes
- Container runtime
- Cluster networking
- Automated node joining

---

# Technologies Used

| Technology | Purpose |
|---|---|
| Vagrant | VM provisioning |
| VirtualBox | Virtualization |
| Ansible | Automation |
| Kubernetes | Container orchestration |
| kubeadm | Cluster bootstrap |
| containerd | Container runtime |
| GitHub Actions | CI/CD |

---

# Planned Features

- Automated Kubernetes cluster setup
- Multi-node architecture
- Ansible role-based automation
- Calico CNI integration
- Ingress controller
- Monitoring stack
- CI/CD validation pipeline
- Health check automation

---

# Current Project Structure

```text
k8s-automation-platform/
├── ansible/
├── kubernetes/
├── scripts/
├── screenshots/
└── vagrant/
```

---

# Cluster Topology

| Node | IP Address | Role |
|---|---|---|
| k8s-master | 192.168.56.10 | Control Plane |
| worker-1 | 192.168.56.11 | Worker Node |
| worker-2 | 192.168.56.12 | Worker Node |

---

# Setup Workflow

## Step 1

Provision virtual machines:

```bash
vagrant up
```

## Step 2

Run Ansible automation:

```bash
ansible-playbook ansible/playbooks/site.yml
```

## Step 3

Verify cluster:

```bash
kubectl get nodes
```

---

# Status

Project under active development.

---

# Author

Muhammad Kamran Kabeer
