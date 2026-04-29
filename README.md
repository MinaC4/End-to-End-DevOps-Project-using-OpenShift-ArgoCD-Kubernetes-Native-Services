
---

# Netflix Clone — DevOps + GitOps (Tekton, ArgoCD, OpenShift)

## Architecture diagram

![Netflix Clone Architecture] <img width="1536" height="1024" alt="5f30f26a-127f-49b7-8a99-6b30038074b4" src="https://github.com/user-attachments/assets/d69f48ee-e2bc-412c-8562-1d8788f946b0" />


### Detailed Architecture Flow


A modern **Netflix Clone application** built with **React + TypeScript + Vite**, and deployed on **OpenShift** using a full **DevSecOps + GitOps pipeline** with **Tekton (CI)** and **ArgoCD (CD)**.


---

## What’s in this repo

### Application layer  <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 1 00 07 AM" src="https://github.com/user-attachments/assets/bade5ecc-8a30-4762-b64d-12dbe44a3fef" />


* **Frontend**: React + TypeScript + Vite (`src/`)
* Netflix UI clone (home, details, watch page, genres grid)
* TMDB API integration (movies & TV shows)

---

### GitOps layer (ArgoCD managed) <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 52 32 AM" src="https://github.com/user-attachments/assets/1a46f6f6-1633-4f6c-8b16-a3933588d3b3" />


* Kubernetes manifests (`openshift/`) <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 53 16 AM" src="https://github.com/user-attachments/assets/dba1af77-9f61-4228-85b0-db424bd0f9a5" />


  * Deployment
  * Service
  * Route
  * HPA (autoscaling)
  * PDB (resilience)
  * ResourceQuota
  * LimitRange
  * Security policies
* ArgoCD Application definition (`argocd/`) <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 55 19 AM" src="https://github.com/user-attachments/assets/03e19a53-1486-489a-a3f5-75f1bf313fcc" />


--- <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 53 29 AM" src="https://github.com/user-attachments/assets/726b80ae-adbb-4177-97cb-9967f177df40" />


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

### 2. CI Layer (Tekton Pipeline) <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 57 40 AM" src="https://github.com/user-attachments/assets/934e8cdb-fdc5-4c00-bd89-dc07b5c7929d" />


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

## CI/CD Flow (End-to-End) <img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 58 34 AM" src="https://github.com/user-attachments/assets/749870a3-90a3-41d0-b2b1-b1bb13d70aab" />


1. Developer pushes code → GitHub
2. Tekton pipeline is triggered
3. Docker image is built
4. Security scan runs (Trivy)
5. Image is pushed to registry
6. ArgoCD detects manifest changes
7. ArgoCD syncs to OpenShift
8. OpenShift updates running pods

---

## DevOps features

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

