<p align="center">
  <img src="docs/banner.svg" alt="Kubernetes Automation Platform Banner" width="100%">
</p>

<h1 align="center">☸️ Kubernetes Automation Platform</h1>

<p align="center">
  Production-style Kubernetes cluster automation using Infrastructure as Code — Vagrant, Ansible, kubeadm, containerd, and Calico CNI, validated through GitHub Actions CI/CD.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Kubernetes-kubeadm-blue?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes">
  <img src="https://img.shields.io/badge/Ansible-Automation-red?style=for-the-badge&logo=ansible&logoColor=white" alt="Ansible">
  <img src="https://img.shields.io/badge/Vagrant-Provisioning-1868F2?style=for-the-badge&logo=vagrant&logoColor=white" alt="Vagrant">
  <img src="https://img.shields.io/badge/containerd-Runtime-575757?style=for-the-badge&logo=containerd&logoColor=white" alt="containerd">
  <img src="https://img.shields.io/badge/Calico-CNI-orange?style=for-the-badge&logo=projectcalico&logoColor=white" alt="Calico">
  <img src="https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions">
  <img src="https://img.shields.io/badge/Status-Active%20Development-yellow?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <a href="https://devriston.com.pk"><img src="https://img.shields.io/badge/Portfolio-Devriston-000000?style=for-the-badge&logo=googlechrome&logoColor=white" alt="Portfolio"></a>
  <a href="https://www.linkedin.com/in/kamrankabeer/"><img src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"></a>
  <a href="https://github.com/muhammadkamrankabeer-oss"><img src="https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"></a>
</p>

---

## 📌 Project Goal

This project automates a **production-style Kubernetes cluster deployment** in a local lab environment using Infrastructure as Code and Configuration Management principles — no manual `kubeadm` commands, no manual node joins, no manual CNI installs. Everything is provisioned and configured through Vagrant + Ansible, end to end.

The platform provisions:

- ☸️ Kubernetes control plane (master) node
- 🖥️ Multiple Kubernetes worker nodes
- 🐳 containerd container runtime
- 🌐 Calico pod networking (CNI)
- 🔗 Automated worker-to-master node joining
- ✅ Post-deployment cluster verification

---

## 🖼️ Screenshots

<p align="center">
  <img src="docs/screenshots/ansible-connectivity.png" alt="Ansible connectivity check" width="45%">
  <img src="docs/screenshots/ansible-playbook-success.png" alt="Ansible playbook run success" width="45%">
</p>
<p align="center">
  <img src="docs/screenshots/cluster-bootstrap-complete.png" alt="Cluster bootstrap complete" width="45%">
  <img src="docs/screenshots/kubernetes-nodes-ready.png" alt="Kubernetes nodes ready" width="45%">
</p>
<p align="center">
  <img src="docs/screenshots/calico-networking.png" alt="Calico networking" width="45%">
  <img src="docs/screenshots/deployment-nginx-running.png" alt="Nginx demo deployment running" width="45%">
</p>

---

## 🧱 Architecture

<p align="center">
  <img src="diagrams/architecture-diagram.png.png" alt="Architecture Diagram" width="80%">
</p>

Full breakdown available in [`docs/architecture.md`](docs/architecture.md).

---

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| Vagrant | VM provisioning |
| VirtualBox | Virtualization layer |
| Ansible | Configuration management & automation |
| Kubernetes | Container orchestration |
| kubeadm | Cluster bootstrap |
| containerd | Container runtime |
| Calico | Pod networking (CNI) |
| GitHub Actions | CI/CD validation pipeline |

---

## 🌐 Cluster Topology

| Node | IP Address | Role |
|---|---|---|
| k8s-master | 192.168.56.10 | Control Plane |
| worker-1 | 192.168.56.11 | Worker Node |
| worker-2 | 192.168.56.12 | Worker Node |

---

## ⚙️ Ansible Role Breakdown

| Role | Responsibility |
|---|---|
| `common` | Base OS prep — packages, swap disable, sysctl/kernel params |
| `containerd` | Installs and configures the container runtime |
| `kubernetes` | Installs kubeadm, kubelet, kubectl from the official repo |
| `master` | Initializes control plane, installs Calico CNI, generates join command, sets up kubeconfig, verifies cluster |
| `worker` | Joins worker nodes to the cluster using the generated join command |

---

## 🚀 Setup Workflow

### Step 1 — Provision virtual machines

```bash
vagrant up
```

### Step 2 — Run Ansible automation

```bash
ansible-playbook ansible/playbooks/site.yml
```

### Step 3 — Verify cluster

```bash
kubectl get nodes
```

### Step 4 — Deploy demo workload (optional)

```bash
kubectl apply -f kubernetes/demo-app/nginx.yaml
```

> 💡 A `Makefile` is included to wrap these steps into shorter commands (e.g. `make up`, `make provision`, `make verify`) — see the `Makefile` for available targets.

---

## 📂 Repo Structure

```text
k8s-automation-platform/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   ├── group_vars/all.yml
│   │   └── hosts.ini
│   ├── playbooks/
│   │   └── site.yml
│   └── roles/
│       ├── common/
│       ├── containerd/
│       ├── kubernetes/
│       ├── master/
│       └── worker/
├── cluster-setup/
├── diagrams/
│   └── architecture-diagram.png
├── docs/
│   ├── architecture.md
│   ├── interview-guide.md
│   ├── setup-guide.md
│   ├── troubleshooting.md
│   └── screenshots/
├── kubernetes/
│   ├── backend/
│   ├── demo-app/
│   │   └── nginx.yaml
│   ├── frontend/
│   ├── ingress/
│   └── storage/
├── scripts/
├── vagrant/
│   ├── scripts/bootstrap.sh
│   └── Vagrantfile
├── Makefile
└── README.md
```

---

## 🗺️ Roadmap

- [x] Automated Kubernetes cluster setup
- [x] Multi-node architecture
- [x] Ansible role-based automation
- [x] Calico CNI integration
- [ ] Ingress controller
- [ ] Persistent storage provisioning
- [ ] Monitoring stack integration
- [ ] CI/CD validation pipeline (GitHub Actions)
- [ ] Automated health-check playbook

---

## 📖 Docs

- [Architecture](docs/architecture.md)
- [Setup Guide](docs/setup-guide.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Interview Guide](docs/interview-guide.md)

---

## 🚧 Status

Project under **active development** — control plane bootstrap, worker joining, and Calico networking are functional. Ingress, storage, and monitoring are in progress.

---

## 👤 Author

**Muhammad Kamran Kabeer**
Founder & DevOps Engineer · [Devriston](https://devriston.com.pk)
[LinkedIn](https://www.linkedin.com/in/kamrankabeer/) · [GitHub](https://github.com/muhammadkamrankabeer-oss)
