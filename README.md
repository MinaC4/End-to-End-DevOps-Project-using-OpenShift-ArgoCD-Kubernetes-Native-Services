<div align="center">

# 🎬 Netflix Clone — End-to-End DevOps + GitOps Platform

[![React](https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=white)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Vite](https://img.shields.io/badge/Vite-4.0-646CFF?logo=vite&logoColor=white)](https://vitejs.dev/)
[![OpenShift](https://img.shields.io/badge/OpenShift-4.x-EE0000?logo=redhatopenshift&logoColor=white)](https://www.redhat.com/en/technologies/cloud-computing/openshift)
[![Tekton](https://img.shields.io/badge/Tekton-CI-FF6600?logo=tekton&logoColor=white)](https://tekton.dev/)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo&logoColor=white)](https://argoproj.github.io/cd/)
[![Nginx](https://img.shields.io/badge/Nginx-1.24-009639?logo=nginx&logoColor=white)](https://nginx.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**A modern Netflix UI clone deployed on OpenShift using enterprise-grade DevOps + GitOps patterns**

*React + TypeScript + Vite → Tekton (CI) → ArgoCD (CD) → OpenShift (Runtime)*

</div>

---



##  Architecture Overview

<div align="center">

![Architecture Diagram]

<img width="1639" height="960" alt="ChatGPT Image May 1, 2026, 01_43_10 PM" src="https://github.com/user-attachments/assets/6911839d-5c42-4270-bec4-e81368c4132e" />


##  Table of Contents

- [Architecture Overview](#-architecture-overview)
- [Project Structure](#-project-structure)
- [Application Layer](#-application-layer)
- [CI/CD Pipeline](#-cicd-pipeline)
- [GitOps Layer](#-gitops-layer)
- [OpenShift Runtime](#-openshift-runtime)
- [Observability](#-observability)
- [Quick Start](#-quick-start)
- [Key Engineering Concepts](#-key-engineering-concepts)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)

---


**End-to-End DevOps + GitOps Architecture Flow**

</div>

### Architecture Zones

| Zone | Component | Technology | Purpose |
|------|-----------|------------|---------|
|  **Developer** | GitHub Repository | Git | Source of Truth |
|  **CI** | Tekton Pipelines | OpenShift Pipelines | Build, Scan, Deploy |
|  **Registry** | OpenShift Internal Registry | Container Storage | Image Storage |
|  **CD** | ArgoCD | OpenShift GitOps | GitOps Synchronization |
|  **Runtime** | OpenShift Cluster | Kubernetes | Application Runtime |
|  **Access** | OpenShift Route | HAProxy | External Access |
|  **Observability**  | Metrics & Logs |

### Data Flow

```
Developer pushes code → GitHub (main)
         ↓
Tekton Pipeline Triggered (openshift-pipelines)
    ├─ Task 1: clone-and-build (npm install + build)
    ├─ Task 2: build-and-push-image (Buildah → Registry)
    ├─ Task 3: trivy-image-scan (DevSecOps - HIGH severity)
    └─ Task 4: deploy-to-openshift (oc set image + rollout)
         ↓
OpenShift Internal Registry (image-registry.openshift...:5000)
         ↓
ArgoCD Watches Git Repo (openshift-gitops)
    ├─ Detects manifest changes
    ├─ Self-healing + Drift detection
    └─ Syncs to OpenShift (netflix-clone namespace)
         ↓
OpenShift Runtime
    ├─ Deployment (pods updated)
    ├─ Service (ClusterIP)
    ├─ Route (HTTPS edge termination)
    ├─ HPA (auto-scaling 1-5 pods)
    ├─ PDB (resilience)
    ├─ ResourceQuota + LimitRange (governance)
    └─ Security (ServiceAccount + SCC)
         ↓
End Users access via HTTPS Route
```

---

## 📁 Project Structure

```
End-2-End-DevOps-OpenShift-Platform/
├── 📁 app/                          # React + TypeScript Application
│   ├── 📁 src/
│   │   ├── 📁 components/           # React components (Home, Details, Watch, Genres)
│   │   ├── 📁 pages/                # Page components
│   │   ├── 📁 hooks/                # Custom React hooks
│   │   ├── 📁 services/             # API services (TMDB integration)
│   │   ├── 📁 types/                # TypeScript type definitions
│   │   ├── 📁 styles/               # CSS/SCSS styles
│   │   ├── App.tsx                  # Main application component
│   │   └── main.tsx                 # Application entry point
│   ├── 📄 index.html                # HTML template
│   ├── 📄 vite.config.ts            # Vite configuration
│   ├── 📄 tsconfig.json             # TypeScript configuration
│   └── 📄 package.json              # Dependencies & scripts
│
├── 📁 docker/                       # Container configuration
│   ├── 📄 Dockerfile                 # Multi-stage Docker build
│   └── 📄 nginx.conf                 # Nginx SPA routing + caching
│
├── 📁 tekton/                       # CI/CD Pipeline definitions
│   ├── 📄 pipeline.yaml              # Pipeline: netflix-clone-pipeline
│   ├── 📄 tasks.yaml                 # Custom + Cluster Task definitions
│   └── 📄 run.yaml                   # PipelineRun example
│
├── 📁 openshift/                    # Kubernetes/OpenShift manifests
│   ├── 📄 namespace.yaml             # netflix-clone namespace
│   ├── 📄 deployment.yaml            # Application deployment
│   ├── 📄 service.yaml               # ClusterIP service
│   ├── 📄 route.yaml                 # OpenShift Route (edge TLS)
│   ├── 📄 hpa.yaml                   # Horizontal Pod Autoscaler
│   ├── 📄 pdb.yaml                   # Pod Disruption Budget
│   ├── 📄 resource-quota.yaml        # ResourceQuota
│   ├── 📄 limit-range.yaml           # LimitRange
│   ├── 📄 security.yaml              # ServiceAccount + RoleBinding
│   └── 📄 kustomization.yaml         # Kustomize configuration
│
├── 📁 argocd/                       # GitOps configuration
│   └── 📄 application.yaml           # ArgoCD Application CR
│
├── 📁 docs/                         # Documentation & Images
│   └── 📁 images/
│       ├── architecture-diagram.svg  # Animated architecture diagram
│       ├── app-screenshot.png        # Application UI screenshot
│       ├── tekton-pipeline.png     # Tekton pipeline screenshot
│       ├── argocd-sync.png          # ArgoCD sync status
│       └── openshift-resources.png  # OpenShift resources view
│
├── 📄 README.md                     # This file
└── 📄 LICENSE                       # MIT License
```

---

##  Application Layer

### Technology Stack

| Layer | Technology | Version | Purpose |
|-------|-----------|---------|---------|
| Framework | React | 18.x | UI Library |
| Language | TypeScript | 5.x | Type Safety |
| Build Tool | Vite | 4.x | Fast bundling & HMR |
| UI Components | Material UI | 5.x | Design system |
| Data Source | TMDB API | v3 | Movies & TV shows data |
| Web Server | Nginx | stable-alpine | Static file serving |

### Key Features

- 🏠 **Home Page** — Featured content carousel with trending movies
- 🎬 **Movie/TV Details** — Comprehensive content information page
- ▶️ **Watch Page** — Streaming simulation interface
- 🎭 **Genres Grid** — Browse by category (Action, Comedy, Drama, etc.)
- 🔍 **Dynamic Content** — Real-time data from TMDB API
- 📱 **Responsive Design** — Mobile-first Material UI components

### Build Configuration

**Multi-stage Dockerfile:**

```dockerfile
# Stage 1: Builder
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ARG TMDB_V3_API_KEY
RUN npm run build

# Stage 2: Production
FROM nginxinc/nginx-unprivileged:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
USER 101
```

**Nginx Configuration Highlights:**
-  Port 8080 (OpenShift-compatible non-root)
-  SPA routing: `try_files $uri $uri/ /index.html`
-  Static assets cached 1 year (js/css/images/fonts)
-  Gzip compression enabled
-  Security headers

---

## 🔧 CI/CD Pipeline

### Tekton Pipeline: `netflix-clone-pipeline`

**Namespace:** `openshift-pipelines`

**Description:** *Netflix Clone - DevSecOps Pipeline (Build + Trivy Scan + Deploy)*

#### 4 Sequential Tasks

| # | Task | TaskRef | Purpose | Key Details |
|---|------|---------|---------|-------------|
| 1 | **clone-and-build** | `npm-build` (cluster) | Clone repo + npm install + build | Workspace: `source` (PVC 2Gi, RWO) |
| 2 | **build-and-push-image** | `buildah-build` (custom) | Build container + push to registry | `quay.io/buildah/stable:v1.35`, privileged |
| 3 | **trivy-image-scan** | `trivy-image-scan` | Security vulnerability scan | Severity: HIGH, blocks on findings |
| 4 | **deploy-to-openshift** | `openshift-client` | Update deployment + rolling restart | `oc set image`, timeout: 180s |

#### Pipeline Configuration

```yaml
# PipelineRun specs
ServiceAccount: pipeline
Workspace: PersistentVolumeClaim (2Gi, RWO)
Timeout: 1 hour
Tekton Chains: Signed (supply chain security)
Tekton Results: Stored (audit trail)
```

#### Pipeline Status Flow

```
Running 
  → clone-and-build [Succeeded] 
  → build-and-push-image [Succeeded] 
  → trivy-image-scan [Succeeded] 
  → deploy-to-openshift [Succeeded] 
  → [Completed]
```

#### DevSecOps Integration

- **Trivy Scanner** — Scans for HIGH severity vulnerabilities
- **Tekton Chains** — Signs pipeline artifacts for supply chain security
- **Tekton Results** — Stores execution logs for audit compliance

---

## GitOps Layer

### ArgoCD Application: `netflix-clone`

**Namespace:** `openshift-gitops` | **Project:** `default`

#### Source Configuration

| Property | Value |
|----------|-------|
| Repository | `https://github.com/MinaC4/netflix-clone-react-typescript.git` |
| Target Revision | `main` branch |
| Path | `openshift/` (K8s manifests directory) |

#### Destination

| Property | Value |
|----------|-------|
| Server | `https://kubernetes.default.svc` (in-cluster) |
| Namespace | `netflix-clone` (auto-created) |

#### Sync Policy (Automated GitOps)

```yaml
syncPolicy:
  automated:
    prune: true              # Remove resources not in Git
    selfHeal: true           # Auto-correct drift
    allowEmpty: false
  syncOptions:
    - CreateNamespace=true    # Auto-create namespace
    - ApplyOutOfSyncOnly=true # Only apply changed resources
    - PruneLast=true          # Prune after sync
    - ServerSideApply=true    # Use server-side apply
```

#### Ignore Differences (OpenShift-specific)

```yaml
ignoreDifferences:
  - group: route.openshift.io
    kind: Route
    jsonPointers:
      - /spec/host          # Auto-generated by OpenShift
      - /status/ingress     # Router-managed status
      - /metadata/annotations
```

#### ArgoCD Features Demonstrated

| Feature | Description |
|---------|-------------|
| 📡 **Continuous Sync** | Watches Git repo for changes every 3 minutes |
| 🛡️ **Self-Healing** | Automatically reverts manual cluster changes |
| 🔍 **Drift Detection** | Alerts when live state diverges from Git |
| 📋 **Declarative** | All config in Git = single source of truth |

#### ArgoCD UI Indicators

```
Sync Status:  Synced ✔
Health Status: Healthy ✔
```

---

## ☸️ OpenShift Runtime

### Namespace: `netflix-clone`

All resources managed by **Kustomize + ArgoCD**

### Resources Overview

| Resource | File | Purpose | Key Specs |
|----------|------|---------|-----------|
| **Namespace** | `namespace.yaml` | Project isolation | `name: netflix-clone` |
| **Deployment** | `deployment.yaml` | Application pods | 1 replica, port 8080, non-root |
| **Service** | `service.yaml` | Internal networking | ClusterIP, 80→8080 |
| **Route** | `route.yaml` | External access | Edge TLS, HTTPS redirect |
| **HPA** | `hpa.yaml` | Auto-scaling | 1-5 pods, 60% CPU target |
| **PDB** | `pdb.yaml` | Resilience | minAvailable: 1 |
| **ResourceQuota** | `resource-quota.yaml` | Resource governance | CPU: 1/2, Memory: 1Gi/2Gi |
| **LimitRange** | `limit-range.yaml` | Container limits | Default: 200m/512Mi |
| **Security** | `security.yaml` | RBAC + SCC | SA: netflix-clone-sa, SCC: anyuid |
| **Kustomization** | `kustomization.yaml` | Manifest management | namespace + commonLabels |

### Deployment Details

```yaml
name: netflix-clone
replicas: 1
serviceAccountName: netflix-clone-sa
container:
  image: image-registry.openshift-image-registry.svc:5000/netflix-clone/netflix-clone:latest
  imagePullPolicy: Always
  ports:
    - containerPort: 8080 (name: http)
  resources:
    requests:
      memory: "256Mi"
      cpu: "200m"
    limits:
      memory: "768Mi"
      cpu: "500m"
  readinessProbe:
    httpGet:
      path: /
      port: 8080
    initialDelaySeconds: 30
    periodSeconds: 10
  livenessProbe:
    httpGet:
      path: /
      port: 8080
    initialDelaySeconds: 60
    periodSeconds: 15
```

### Security Configuration

- **Non-root Container** — Nginx runs as UID 101
- **anyuid SCC** — Granted via RoleBinding for nginx compatibility
- **ServiceAccount** — Dedicated SA for pod identity
- **Edge TLS** — HTTPS termination at OpenShift router level

---

## 📊 Observability

### Cluster-Managed Components (Pre-installed)

| Component | Namespace | Purpose |
|-----------|-----------|---------|
| **OpenShift Pipelines** (Tekton Operator) | `openshift-pipelines` | CI/CD engine |
| **OpenShift GitOps** (ArgoCD Operator) | `openshift-gitops` | GitOps engine |
| **OpenShift Internal Registry** | `openshift-image-registry` | Image storage |
| **OpenShift Monitoring** | `openshift-monitoring` 
| **OpenShift Router** (HAProxy) | `openshift-ingress` | External routing |

### Key Metrics Tracked

| Metric | Source | Dashboard |
|--------|--------|-----------|
| Pod CPU/Memory utilization 
| HPA scaling events | Kubernetes Metrics | OpenShift Console |
| Deployment rollout status | OpenShift API | ArgoCD UI |
| Container vulnerability scan | Trivy | Tekton Results |
| ArgoCD sync status | ArgoCD Metrics | ArgoCD UI |
| Application request latency | Nginx logs | 

---

##  Quick Start

### Prerequisites

- OpenShift 4.x cluster with:
  - OpenShift Pipelines (Tekton) operator
  - OpenShift GitOps (ArgoCD) operator
  - OpenShift Internal Registry enabled

### 1. Clone Repository

```bash
git clone https://github.com/MinaC4/End-2-End-DevOps-OpenShift-Platform.git
cd End-2-End-DevOps-OpenShift-Platform
```

### 2. Configure TMDB API Key

```bash
# Get API key from https://www.themoviedb.org/settings/api
export TMDB_V3_API_KEY=your_api_key_here
```

### 3. Deploy ArgoCD Application

```bash
oc apply -f argocd/application.yaml
```

### 4. Trigger CI Pipeline

```bash
# Push to main branch or manually trigger:
oc create -f tekton/run.yaml
```

### 5. Verify Deployment

```bash
# Check ArgoCD sync status
argocd app get netflix-clone

# Check OpenShift resources
oc get all -n netflix-clone

# Access application
oc get route netflix-clone -n netflix-clone
```

---

##  Key Engineering Concepts

| Concept | Implementation |
|---------|---------------|
| **GitOps** | ArgoCD watches Git repo, auto-syncs, self-healing |
| **CI/CD Separation** | Tekton handles CI (build/scan) → ArgoCD handles CD (deploy/sync) |
| **DevSecOps** | Trivy security scanning integrated in pipeline |
| **Kubernetes-Native** | All manifests are standard YAML, no custom scripts |
| **Declarative Infra** | Kustomize + Git = single source of truth |
| **Auto Scaling** | HPA scales pods 1-5 based on 60% CPU utilization |
| **Resilience** | PDB ensures minimum availability during disruptions |
| **Resource Governance** | ResourceQuota + LimitRange enforce resource boundaries |
| **Non-Root Security** | Nginx runs as UID 101, anyuid SCC for compatibility |
| **Supply Chain Security** | Tekton Chains signs pipeline artifacts |
| **Edge TLS** | Route provides HTTPS termination at router level |

---

## 📸 Screenshots

<div align="center">

### Application UI
![Application Screenshot] 

<img width="1920" height="1200" alt="Screenshot 2026-04-30 at 1 00 07 AM" src="https://github.com/user-attachments/assets/f0c853a7-8857-4bb0-9660-a2c326c0e08e" />


*Netflix Clone UI — Home page with featured content carousel*

### Tekton Pipeline
![Tekton Pipeline]

<img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 57 40 AM" src="https://github.com/user-attachments/assets/7e9b4613-6b69-4290-952a-312aa334a3a8" />


*Tekton Pipeline — 4 sequential tasks: Build → Push → Scan → Deploy*

### ArgoCD Sync Status
![ArgoCD Sync]

<img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 52 32 AM" src="https://github.com/user-attachments/assets/f080a48c-cc63-4f07-92d2-c6819b8ebaba" />


*ArgoCD Application — Synced ✔ | Healthy ✔ | Self-healing enabled*

### OpenShift Resources
![OpenShift Resources]

<img width="1920" height="1200" alt="Screenshot 2026-04-30 at 12 53 16 AM" src="https://github.com/user-attachments/assets/34dcd8f4-f528-4550-a2e7-2a614eaa439c" />


*OpenShift Console — All resources in netflix-clone namespace*

</div>

---



