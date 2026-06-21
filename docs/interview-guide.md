# Kubernetes Automation Lab – Interview Guide

## Project Overview

### Q: Tell me about this project.

This project is a production-style Kubernetes automation lab built using Vagrant, Ansible, Containerd, and Kubernetes.

The environment consists of:

* 1 Kubernetes Control Plane Node
* 2 Kubernetes Worker Nodes
* Vagrant for infrastructure provisioning
* Ansible for configuration management
* Containerd as the container runtime
* Calico as the CNI networking solution

The entire cluster can be deployed automatically using Ansible playbooks with minimal manual intervention.

---

# Architecture

### Q: What is the architecture of your cluster?

The cluster contains:

* k8s-master (Control Plane)
* worker-1
* worker-2

Control Plane Components:

* kube-apiserver
* etcd
* kube-controller-manager
* kube-scheduler

Worker Components:

* kubelet
* kube-proxy
* containerd

Networking:

* Calico CNI

---

# Vagrant

### Q: Why did you use Vagrant?

Vagrant allows repeatable infrastructure provisioning.

Benefits:

* Infrastructure as Code
* Easy environment recreation
* Consistent development environments
* Multi-node lab simulation on a laptop

---

### Q: Why use static private IPs?

Each node receives a fixed IP:

* 192.168.56.10
* 192.168.56.11
* 192.168.56.12

Benefits:

* Predictable communication
* Stable Ansible inventory
* Easier troubleshooting

---

# Ansible

### Q: Why use Ansible?

Ansible automates configuration management.

Benefits:

* Agentless
* SSH-based
* Idempotent
* Easy to maintain

---

### Q: What Ansible roles did you create?

Roles:

* common
* containerd
* kubernetes
* master
* worker

Purpose:

common:

* OS preparation

containerd:

* Runtime installation and configuration

kubernetes:

* kubeadm
* kubelet
* kubectl

master:

* Cluster initialization

worker:

* Node joining

---

### Q: What is idempotency?

Idempotency means:

Running the same playbook multiple times produces the same result without causing unwanted changes.

Example:

kubeadm init uses:

creates: /etc/kubernetes/admin.conf

so initialization only happens once.

---

# Linux Preparation

### Q: Why disable swap?

Kubernetes requires swap to be disabled.

Reason:

Kubelet expects predictable memory management.

If swap remains enabled:

* kubelet warnings occur
* scheduling problems may happen
* cluster validation can fail

---

### Q: Why configure sysctl parameters?

Parameters:

* net.bridge.bridge-nf-call-iptables
* net.ipv4.ip_forward

Purpose:

Allow Kubernetes networking and pod communication.

---

# Container Runtime

### Q: What is Containerd?

Containerd is a lightweight container runtime.

Responsibilities:

* Pull images
* Manage containers
* Handle container lifecycle

---

### Q: Why not Docker?

Kubernetes removed direct Docker support.

Modern Kubernetes commonly uses:

* Containerd
* CRI-O

Containerd is lightweight and Kubernetes-native.

---

### Q: Why enable SystemdCgroup?

Configuration:

SystemdCgroup = true

Reason:

Containerd and kubelet must use the same cgroup driver.

Benefits:

* Stable resource management
* Avoid kubelet warnings
* Better compatibility

---

# Kubernetes Installation

### Q: What components did you install?

Installed:

* kubeadm
* kubelet
* kubectl

Purpose:

kubeadm:

* cluster bootstrap

kubelet:

* node agent

kubectl:

* cluster management CLI

---

### Q: Why hold Kubernetes packages?

Packages:

* kubeadm
* kubelet
* kubectl

Reason:

Prevent unexpected upgrades.

Unexpected upgrades can:

* break compatibility
* introduce version mismatches

---

# kubeadm

### Q: What is kubeadm?

kubeadm is the Kubernetes bootstrap tool.

Functions:

* Initialize control plane
* Generate certificates
* Create cluster configuration
* Generate worker join commands

---

### Q: What command initializes the cluster?

Example:

kubeadm init 
--apiserver-advertise-address=192.168.56.10 
--pod-network-cidr=192.168.0.0/16

---

### Q: What does pod-network-cidr mean?

Defines the IP range assigned to pods.

Example:

192.168.0.0/16

Required by the networking plugin.

---

# kubeconfig

### Q: What is admin.conf?

Location:

/etc/kubernetes/admin.conf

Purpose:

Provides Kubernetes API access.

Used by:

kubectl

---

### Q: Why copy admin.conf to ~/.kube/config?

Without kubeconfig:

kubectl tries localhost:8080

Result:

The connection to the server localhost:8080 was refused

Copying admin.conf solves this.

---

# Worker Join Process

### Q: How do workers join the cluster?

Process:

1. Generate join token on master
2. Save command
3. Copy command to workers
4. Execute join command

Example:

kubeadm join ...

---

### Q: What happens during worker join?

Worker receives:

* cluster certificates
* API server information
* kubelet configuration

Then becomes part of the cluster.

---

# Networking

### Q: What is a CNI?

CNI = Container Network Interface

Provides:

* Pod networking
* Inter-node communication
* IP allocation

---

### Q: Why was the cluster NotReady initially?

Because no CNI plugin was installed.

Symptoms:

* CoreDNS Pending
* Workers NotReady
* Networking unavailable

---

### Q: Which CNI did you choose?

Calico

Benefits:

* Widely used
* Production-ready
* Network policy support
* Easy installation

---

### Q: How did you install Calico?

Using:

kubectl apply -f calico.yaml

---

### Q: How did you verify Calico?

Commands:

kubectl get pods -n kube-system

Expected:

calico-node Running

calico-kube-controllers Running

---

# Real Problem Solved

### Q: What was the biggest issue you faced?

Incorrect node IP selection.

Nodes registered with:

10.0.2.15

instead of:

192.168.56.x

---

### Q: Why did this happen?

Vagrant creates multiple interfaces:

NAT:

10.0.2.x

Private Network:

192.168.56.x

Kubelet automatically selected the wrong interface.

---

### Q: How did you fix it?

Configured:

KUBELET_EXTRA_ARGS=--node-ip={{ ansible_host }}

File:

/etc/default/kubelet

Then restarted kubelet.

---

### Q: Why was this important?

Without the fix:

* Nodes communicate incorrectly
* Networking fails
* Cluster becomes unstable

---

# Verification

### Q: How do you verify cluster health?

Check nodes:

kubectl get nodes

Expected:

Ready

---

Check system pods:

kubectl get pods -A

Expected:

Running

---

Check daemonsets:

kubectl get daemonset -A

---

# Troubleshooting

### Q: What does NotReady mean?

Possible causes:

* Missing CNI
* Kubelet issue
* Runtime issue
* Network issue

---

### Q: Why was CoreDNS Pending?

No CNI plugin.

Pods could not be scheduled.

Installing Calico fixed it.

---

### Q: Why did kubectl fail with localhost:8080?

Missing kubeconfig.

Solution:

Use admin.conf.

---

# Security

### Q: Why use SSH keys with Ansible?

Benefits:

* Secure authentication
* No password prompts
* Automation friendly

---

# Production Improvements

### Q: What would you improve in production?

* High Availability Control Plane
* Load Balancer
* Monitoring with Prometheus
* Grafana Dashboards
* Ingress Controller
* Persistent Storage
* Automated Backups
* GitOps
* CI/CD Integration

---

# Key Commands

View nodes:

kubectl get nodes -o wide

View pods:

kubectl get pods -A

View services:

kubectl get svc -A

View daemonsets:

kubectl get daemonset -A

Check kubelet:

systemctl status kubelet

Check containerd:

systemctl status containerd

Check logs:

journalctl -u kubelet -f

---

# Project Summary

This project demonstrates:

* Linux Administration
* Infrastructure Automation
* Ansible Roles
* Kubernetes Installation
* Container Runtime Configuration
* Cluster Networking
* Troubleshooting
* Infrastructure as Code
* Multi-node Kubernetes Operations

The most valuable learning outcome was troubleshooting real Kubernetes networking and node registration issues rather than simply installing Kubernetes.
