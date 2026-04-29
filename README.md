
---

# Netflix Clone — DevSecOps + GitOps (Tekton, ArgoCD, OpenShift)

## Architecture diagram

![Netflix Clone Architecture](docs/architecture-diagram.png)

### Detailed Architecture Flow

![Netflix Clone - DevSecOps on OpenShift via GitOps](docs/architecture-diagram.png)

A modern **Netflix Clone application** built with **React + TypeScript + Vite**, and deployed on **OpenShift** using a full **DevSecOps + GitOps pipeline** with **Tekton (CI)** and **ArgoCD (CD)**.

This project simulates a **production-grade Kubernetes deployment strategy** with separation between CI and CD layers.

---

## What’s in this repo

### Application layer

* **Frontend**: React + TypeScript + Vite (`src/`)
* Netflix UI clone (home, details, watch page, genres grid)
* TMDB API integration (movies & TV shows)

---

### GitOps layer (ArgoCD managed)

* Kubernetes manifests (`openshift/`)

  * Deployment
  * Service
  * Route
  * HPA (autoscaling)
  * PDB (resilience)
  * ResourceQuota
  * LimitRange
  * Security policies
* ArgoCD Application definition (`argocd/`)

---

### CI layer (OpenShift Pipelines - Tekton)

* Triggered on GitHub push
* Builds container image
* Runs security scans (Trivy)
* Pushes image to container registry

> CI is cluster-managed and NOT stored in this repo (only referenced)

---

### Runtime layer (OpenShift Cluster)

* Runs the application workload
* Handles:

  * Pods & Deployments
  * Services & Routes
  * Auto scaling (HPA)
  * Resource governance (Quota / LimitRange)
  * Pod resilience (PDB)

---

## Repository structure

```text
.
├─ argocd/
│  └─ application.yaml        # ArgoCD GitOps application
│
├─ openshift/                 # Kubernetes desired state
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
├─ src/                       # React + TypeScript app
├─ public/                    # Static assets (images, logos)
└─ package.json
```

---

## CI/CD pipeline (DevSecOps flow)

### 1. Developer workflow

* Developer pushes code to GitHub

---

### 2. CI Layer (Tekton Pipeline)

Pipeline steps:

* Clone repository
* Build Docker image (React app)
* Run security scan (Trivy)
* Push image to container registry

---

### 3. CD Layer (ArgoCD GitOps)

* Watches GitHub repository continuously
* Detects changes in manifests
* Syncs desired state to OpenShift
* Ensures:

  * Self-healing
  * Drift correction
  * Declarative deployment

---

### 4. OpenShift Runtime

* Pulls updated container image
* Applies Kubernetes manifests
* Manages scaling and availability

---

## CI/CD Flow (End-to-End)

1. Developer pushes code → GitHub
2. Tekton pipeline is triggered
3. Docker image is built
4. Security scan runs (Trivy)
5. Image is pushed to registry
6. ArgoCD detects manifest changes
7. ArgoCD syncs to OpenShift
8. OpenShift updates running pods

---

## DevSecOps features

* GitOps deployment (ArgoCD)
* CI automation (Tekton)
* Container security scanning (Trivy)
* Kubernetes-native infrastructure
* Auto scaling (HPA)
* Resource control (Quota / LimitRange)
* Pod resilience (PDB)
* Declarative infrastructure (YAML-based)

---

## Observability (optional layer)

* Prometheus → metrics collection
* Grafana → dashboards & visualization
* OpenShift Monitoring Stack → cluster insights

---

## Local development

```bash
npm install
npm run dev
```

App runs on:

```
http://localhost:5173
```

---

## Docker build & run

```bash
docker build --build-arg TMDB_V3_API_KEY=YOUR_KEY -t netflix-clone .
docker run -p 8080:8080 netflix-clone
```

---

## Deployment (GitOps via ArgoCD)

### 1. Apply ArgoCD application

```bash
oc apply -f argocd/application.yaml
```

---

### 2. Configure repository

Update:

```yaml
spec:
  source:
    repoURL: YOUR_REPOSITORY_URL
    targetRevision: main
```

---

### 3. Verify deployment

Open ArgoCD UI:

* Sync Status → Synced ✔
* Health Status → Healthy ✔

---

## What is NOT in this repo

These components are cluster-managed:

* Tekton pipeline definitions
* OpenShift cluster setup
* ArgoCD operator installation
* Container registry configuration
* Monitoring stack (Prometheus / Grafana)

---

## Key engineering concepts demonstrated

* GitOps architecture design
* CI/CD separation (Tekton vs ArgoCD)
* Kubernetes-native deployment
* Declarative infrastructure (YAML-driven)
* DevSecOps lifecycle implementation
* Enterprise-grade OpenShift patterns

---

## Summary

This project demonstrates a real-world production-style DevSecOps system:

* **GitHub → Source of truth**
* **Tekton → CI engine**
* **ArgoCD → CD engine**
* **OpenShift → Runtime platform**

---

## Architecture Diagram Prompt

```text
Create a DevSecOps + GitOps architecture diagram for a Netflix Clone application deployed on OpenShift.

Include:

1. Developer → GitHub (source code)
2. GitHub repository (React app + Kubernetes manifests + ArgoCD app)
3. Tekton CI pipeline (build, test, Trivy scan, push image)
4. Container Registry
5. ArgoCD (GitOps controller)
6. OpenShift cluster (deployments, services, routes, HPA, PDB)
7. Observability stack (Prometheus + Grafana)

Show:
- CI vs CD separation
- GitOps loop (GitHub ↔ ArgoCD ↔ OpenShift)
- Image flow via registry
- Enterprise DevSecOps structure

Style: clean C4 model architecture, layered (Dev / CI / CD / Runtime / Observability)
```
