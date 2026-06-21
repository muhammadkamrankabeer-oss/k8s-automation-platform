# Kubernetes Automation Platform Architecture

## Overview

This project deploys a production-style Kubernetes cluster using:

- Vagrant
- Ansible
- Containerd
- Kubernetes
- Calico CNI

The cluster consists of:

- 1 Control Plane Node
- 2 Worker Nodes

---

## Infrastructure Layer

| Host | IP Address | Role |
|--------|--------|--------|
| k8s-master | 192.168.56.10 | Control Plane |
| worker-1 | 192.168.56.11 | Worker |
| worker-2 | 192.168.56.12 | Worker |

---

## Automation Layer

Ansible performs:

- Node preparation
- Containerd installation
- Kubernetes installation
- Cluster bootstrap
- Worker join automation
- Calico deployment
- Validation

---

## Kubernetes Components

### Control Plane

- kube-apiserver
- etcd
- kube-scheduler
- kube-controller-manager

### Worker Nodes

- kubelet
- kube-proxy
- containerd

---

## Networking

Calico provides:

- Pod networking
- Pod-to-pod communication
- Cluster routing

Pod CIDR:

192.168.0.0/16

---

## Result

Fully automated Kubernetes cluster deployment using Infrastructure as Code principles.
