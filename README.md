<div align="center">
  <img src="./public/assets/netflix-logo.png" alt="Netflix Clone" width="120" />

  <h3 align="center">Netflix Clone (DevSecOps on OpenShift via GitOps)</h3>

  <p align="center">
    React + TypeScript + Vite application deployed on <b>OpenShift</b> using <b>ArgoCD GitOps</b>.
  </p>
</div>

---

## Table of contents

- Architecture
- CI/CD & Delivery Model
- DevSecOps Features
- What is in this repo
- What is NOT in this repo
- Repository Structure
- Deployment (GitOps with ArgoCD)
- Application Screenshots
- OpenShift / GitOps Screenshots
- Local Development
- Docker Build

---

## Architecture

### High-level system flow

GitHub → ArgoCD → OpenShift Cluster → Application Runtime

### Components

- **GitHub**
  - Source of truth for:
    - React application source code
    - Kubernetes manifests (`openshift/`)
    - ArgoCD Application definition (`argocd/`)

- **ArgoCD (GitOps Controller - Cluster Level)**
  - Continuously monitors Git repository
  - Ensures cluster state matches desired state defined in Git

- **OpenShift Cluster**
  - Runs application workloads
  - Manages:
    - Deployment
    - Service
    - Route
    - Scaling (HPA)
    - Resource control (Quota / LimitRange)
    - Resilience (PDB)

---

## CI/CD & Delivery Model

This project follows a **GitOps-based delivery model**.

### Delivery flow

1. Developer pushes code to GitHub
2. Git repository becomes the single source of truth
3. ArgoCD detects changes in manifests
4. OpenShift reconciles cluster state automatically
5. Application is deployed or updated

---

### Important clarification

- CI pipelines (build, scan, image push) are **NOT implemented in this repository as code**
- If CI is used, it is handled at **cluster level (OpenShift Pipelines / Tekton)** and is outside repository scope
- This repository focuses only on **GitOps CD (Continuous Delivery)**

---

## DevSecOps Features

- Kubernetes-native deployment:
  - Deployment
  - Service
  - Route

- GitOps (ArgoCD):
  - Automated sync
  - Self-healing
  - Drift correction

- Scaling:
  - HorizontalPodAutoscaler (CPU-based)

- Resilience:
  - PodDisruptionBudget

- Resource Governance:
  - ResourceQuota
  - LimitRange

- Security Controls:
  - ServiceAccount
  - RoleBinding (OpenShift SCC integration)

---

## What is in this repo

This repository contains only **application-owned artifacts**:

- React + TypeScript source code (`src/`)
- Kubernetes manifests (`openshift/`)
- ArgoCD Application definition (`argocd/application.yaml`)

---

## What is NOT in this repo

The following components are **external / cluster-managed** and NOT stored in this repository:

- ArgoCD Operator installation
- OpenShift cluster infrastructure
- Monitoring stack (Prometheus / Grafana)
- Image registry (Quay / DockerHub)
- Ingress / Router infrastructure
- CI pipelines (Tekton / OpenShift Pipelines)

---

## Repository Structure

```text
.
├─ argocd/
│  └─ application.yaml        # ArgoCD Application definition
├─ openshift/                # Desired cluster state (GitOps managed)
│  ├─ kustomization.yaml
│  ├─ namespace.yaml
│  ├─ security.yaml
│  ├─ deployment.yaml
│  ├─ service.yaml
│  ├─ route.yaml
│  ├─ hpa.yaml
│  ├─ pdb.yaml
│  ├─ resource-quota.yaml
│  └─ limit-range.yaml
└─ src/                      # React application
