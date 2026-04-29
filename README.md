<div align="center">
  <img src="./public/assets/netflix-logo.png" alt="Netflix Clone" width="120" />

  <h2>Netflix Clone - DevSecOps on OpenShift via GitOps</h2>

  <p>
    A modern Netflix Clone built with <b>React + TypeScript + Vite</b> and deployed on <b>OpenShift</b> using
    <b>ArgoCD GitOps (CD)</b> and <b>OpenShift Pipelines (Tekton CI)</b>.
  </p>
</div>

---

#  Project Overview

This project demonstrates a **real-world DevSecOps pipeline** using:

- GitOps for Continuous Delivery (ArgoCD)
- CI Pipelines for Build & Security (Tekton)
- OpenShift as Kubernetes runtime platform
- Full observability & cluster-level governance

---

#  System Architecture

##  High-Level Flow


---

##  Components Breakdown

### 1. GitHub (Source of Truth)
- Contains:
  - React application source code (`src/`)
  - Kubernetes manifests (`openshift/`)
  - ArgoCD Application definition (`argocd/`)

---

### 2. CI Layer (OpenShift Pipelines - Tekton)

Responsible for:

- Cloning source code
- Building Docker image
- Running security scans (Trivy)
- Pushing image to container registry

 CI pipeline runs at **cluster level**, not inside this repo.

---

### 3. CD Layer (ArgoCD GitOps)

- Continuously monitors GitHub repository
- Applies desired state to OpenShift cluster
- Ensures:
  - Self-healing
  - Drift correction
  - Declarative deployment

---

### 4. OpenShift Cluster (Runtime)

Handles application execution:

- Deployments
- Services
- Routes
- Auto Scaling (HPA)
- Resource control (Quota / LimitRange)
- Reliability (PDB)

---

#  CI/CD Flow (Detailed)

1. Developer pushes code to GitHub
2. Tekton pipeline is triggered in OpenShift
3. Application image is built
4. Security scan is executed (Trivy)
5. Image is pushed to container registry
6. ArgoCD detects updated manifests
7. ArgoCD syncs changes to OpenShift
8. OpenShift updates running application

---

#  DevSecOps Features

- GitOps-based deployment (ArgoCD)
- CI pipeline automation (Tekton)
- Container security scanning (Trivy)
- Kubernetes-native deployment
- Auto-scaling (HPA)
- Resource limits (Quota / LimitRange)
- Pod resilience (PDB)
- Declarative infrastructure

---

#  What is in this repository

This repository contains only application-owned assets:

- React + TypeScript frontend
- Kubernetes manifests (OpenShift deployment)
- ArgoCD application definition

---

#  What is NOT in this repository

These components are managed externally at cluster level:

- ArgoCD Operator installation
- Tekton Pipeline definitions (cluster-managed)
- OpenShift cluster infrastructure
- Container registry
- Prometheus / Grafana monitoring stack
- Networking / routing infrastructure

---

#  Repository Structure

```text
.
├─ argocd/
│  └─ application.yaml        # ArgoCD GitOps application definition
│
├─ openshift/                 # Kubernetes desired state (GitOps)
│  ├─ deployment.yaml
│  ├─ service.yaml
│  ├─ route.yaml
│  ├─ hpa.yaml
│  ├─ pdb.yaml
│  ├─ resource-quota.yaml
│  ├─ limit-range.yaml
│  ├─ security.yaml
│  └─ kustomization.yaml
│
└─ src/                       # React application source code



 Deployment (GitOps - ArgoCD)
Prerequisites
OpenShift cluster (CRC or production cluster)
OpenShift GitOps Operator installed
Access to ArgoCD UI
Steps
1. Apply ArgoCD Application
oc apply -f argocd/application.yaml
2. Configure Repository

Update:

spec:
  source:
    repoURL: YOUR_REPOSITORY_URL
    targetRevision: main
3. Verify Deployment
Open ArgoCD UI
Check:
Sync Status → ✔ Synced
Health Status → ✔ Healthy
 Screenshots
 Application UI
Home Page
Mini Portal
Detail View
Genre Grid
Watch Page
☁ OpenShift & GitOps
ArgoCD Application Tree
Pod Metrics
OpenShift Project Overview
Tekton Pipeline Execution
⚙ Local Development
npm ci
npm run dev
 Docker Build
docker build --build-arg TMDB_V3_API_KEY=YOUR_KEY -t netflix-clone .
docker run -p 8080:8080 netflix-clone
 Key Engineering Concepts Demonstrated
GitOps architecture design
CI/CD separation (Tekton vs ArgoCD)
Kubernetes-native application deployment
Cluster-level vs repo-level responsibilities
DevSecOps lifecycle implementation
 Summary

This project demonstrates a production-style DevSecOps system where:

GitHub = Source of truth
Tekton = CI engine
ArgoCD = CD engine
OpenShift = Runtime platform


---

#  Architecture Diagram Prompt (جاهز لأي AI / diagrams.net / Mermaid / Lucidchart)

```text
Create a DevSecOps + GitOps architecture diagram for a Netflix Clone application deployed on OpenShift.

The system should follow a real-world enterprise CI/CD + GitOps model.

Include the following components:

1. Developer
- Pushes code changes to GitHub

2. GitHub Repository (Source of Truth)
- Contains:
  - React application source code
  - Kubernetes manifests (Deployment, Service, Route, HPA, PDB)
  - ArgoCD Application definition

3. CI Layer (OpenShift Pipelines - Tekton)
- Triggered on code push
- Responsibilities:
  - Clone repository
  - Build Docker image
  - Run security scan (Trivy)
  - Push image to container registry

4. Container Registry
- Stores built container images

5. CD Layer (ArgoCD GitOps Controller)
- Continuously monitors GitHub repository
- Applies Kubernetes manifests to OpenShift
- Ensures desired state reconciliation
- Handles drift correction and self-healing

6. OpenShift Cluster (Runtime Environment)
- Runs application workloads
- Includes:
  - Deployments
  - Services
  - Routes
  - Horizontal Pod Autoscaler (HPA)
  - Pod Disruption Budget (PDB)
  - ResourceQuota / LimitRange

7. Observability Layer (Optional but recommended)
- Prometheus for metrics
- Grafana for dashboards
- OpenShift monitoring stack

Show clearly:

- CI vs CD separation
- GitOps loop between GitHub and ArgoCD
- Deployment flow into OpenShift
- Image flow via container registry

Style:
- Use C4 model architecture style
- Clean enterprise DevSecOps diagram
- Separate layers: Dev / CI / CD / Runtime / Observability
- Use directional arrows for data flow
