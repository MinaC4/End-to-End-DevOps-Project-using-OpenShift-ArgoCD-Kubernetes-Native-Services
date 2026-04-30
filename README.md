

---

# Netflix Clone — DevOps + GitOps (Tekton, ArgoCD, OpenShift)

## Architecture Diagram

![Netflix Clone Architecture](https://github.com/user-attachments/assets/d69f48ee-e2bc-412c-8562-1d8788f946b0)

### Detailed Architecture Flow

## A modern **Netflix Clone application** built with **React + TypeScript + Vite**, and deployed on **OpenShift** using a full **DevOps + GitOps pipeline** with **Tekton (CI)** and **ArgoCD (CD)**.

## What’s in this repo

### Application Layer

![Application Layer Screenshot](https://github.com/user-attachments/assets/bade5ecc-8a30-4762-b64d-12dbe44a3fef)

**Frontend**: React + TypeScript + Vite (`src/`)

- Netflix UI clone (home, details, watch page, genres grid)
- TMDB API integration (movies & TV shows)

### GitOps Layer (ArgoCD Managed)

![GitOps Layer Screenshot](https://github.com/user-attachments/assets/1a46f6f6-1633-4f6c-8b16-a3933588d3b3)

**OpenShift manifests** (`openshift/`)

![OpenShift Manifests](https://github.com/user-attachments/assets/dba1af77-9f61-4228-85b0-db424bd0f9a5)

- Deployment
- Service
- Route
- Horizontal Pod Autoscaler (HPA)
- Pod Disruption Budget (resilience)
- ResourceQuota
- LimitRange
- Security policies

**ArgoCD Application definition** (`argocd/`)

![ArgoCD Application](https://github.com/user-attachments/assets/726b80ae-adbb-4177-97cb-9967f177df40)

### CI Layer (OpenShift Pipelines - Tekton)

- Triggered on GitHub push
- Builds container image
- Runs security scans (Trivy)
- Pushes image to container registry

### Runtime Layer (OpenShift Cluster)

Runs the application workload and handles:

- Pods & Deployments
- Services & Routes
- Auto scaling (HPA)
- Resource governance (Quota / LimitRange)
- Pod resilience (PDB)

## CI/CD Pipeline (DevOps Flow)

### 1. Developer Workflow

Developer pushes code to GitHub

### 2. CI Layer (Tekton Pipeline)

![Tekton Pipeline Screenshot](https://github.com/user-attachments/assets/934e8cdb-fdc5-4c00-bd89-dc07b5c7929d)

**Pipeline steps:**

- Clone repository
- Build Docker image (React app)
- Run security scan (Trivy)
- Push image to container registry

### 3. CD Layer (ArgoCD GitOps)

- Watches GitHub repository continuously
- Detects changes in manifests
- Syncs desired state to OpenShift
- Ensures:
  - Self-healing
  - Drift correction
  - Declarative deployment

### 4. OpenShift Runtime

- Pulls updated container image
- Applies Kubernetes manifests
- Manages scaling and availability

## CI/CD Flow (End-to-End)

![End-to-End CI/CD Flow](https://github.com/user-attachments/assets/749870a3-90a3-41d0-b2b1-b1bb13d70aab)

**Flow:**
Developer pushes code → GitHub  
Tekton pipeline is triggered  
Docker image is built  
Security scan runs (Trivy)  
Image is pushed to registry  
ArgoCD detects manifest changes  
ArgoCD syncs to OpenShift  
OpenShift updates running pods

## DevOps Features

- GitOps deployment (ArgoCD)
- CI automation (Tekton)
- Container security scanning (Trivy)
- Kubernetes-native infrastructure
- Auto scaling (HPA)
- Resource control (Quota / LimitRange)
- Pod resilience (PDB)
- Declarative infrastructure (YAML-based)

## Observability (Optional Layer)

- Prometheus → metrics collection
- Grafana → dashboards & visualization
- OpenShift Monitoring Stack → cluster insights

![Observability Screenshot](https://github.com/user-attachments/assets/e6a0ec66-470a-4abb-97a2-e7e614730e2f)

### Verify Deployment

Open ArgoCD UI:

- **Sync Status** → Synced ✔
- **Health Status** → Healthy ✔

> **Note**: These components are cluster-managed:
> - Tekton pipeline definitions
> - OpenShift cluster setup
> - ArgoCD operator installation
> - Container registry configuration
> - Monitoring

## Key Engineering Concepts Demonstrated

- GitOps architecture design
- CI/CD separation (Tekton - ArgoCD)
- Kubernetes-native deployment
- Declarative infrastructure (YAML-driven)
- DevSecOps lifecycle implementation
- Enterprise-grade OpenShift patterns

## Summary

This project demonstrates a real-world production-style **DevSecOps** system:

**GitHub** → Source of truth  
**Tekton** → CI engine  
**ArgoCD** → CD engine  
**OpenShift** → Runtime platform

---
