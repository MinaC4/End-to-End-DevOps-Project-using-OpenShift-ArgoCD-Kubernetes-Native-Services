<div align="center">
  <img src="./public/assets/netflix-logo.png" alt="Netflix Clone" width="120" />

  <h2>Netflix Clone - DevSecOps on OpenShift via GitOps</h2>

<<<<<<< HEAD
  <p>
    A modern Netflix Clone built with <b>React + TypeScript + Vite</b> and deployed on <b>OpenShift</b> using
    <b>ArgoCD GitOps (CD)</b> and <b>OpenShift Pipelines (Tekton CI)</b>.
=======
  <p align="center">
    React + TypeScript + Vite application deployed on <b>OpenShift</b> using <b>ArgoCD GitOps</b>.
>>>>>>> 23f58f0e679b1cc87dc3bb38b45ad6c72c809a6c
  </p>
</div>

---

<<<<<<< HEAD
# Project Overview

This project demonstrates a **real-world DevSecOps pipeline** using:

- GitOps for Continuous Delivery (ArgoCD)
- CI Pipelines for Build & Security (Tekton)
- OpenShift as Kubernetes runtime platform
- Full observability & cluster-level governance

---

# System Architecture

## High-Level Flow

```
Developer → GitHub → Tekton CI Pipeline → Container Registry → ArgoCD → OpenShift Cluster → Application
```

---

## Components Breakdown

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

⚠️ CI pipeline runs at **cluster level**, not inside this repo.

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

# CI/CD Flow (Detailed)

1. Developer pushes code to GitHub
2. Tekton pipeline is triggered in OpenShift
3. Application image is built
4. Security scan is executed (Trivy)
5. Image is pushed to container registry
6. ArgoCD detects updated manifests
7. ArgoCD syncs changes to OpenShift
8. OpenShift updates running application

---

# DevSecOps Features

## Security-First Approach

### GitOps-based Deployment (ArgoCD)
- **Declarative Configuration**: All infrastructure defined as code
- **Version Control**: Complete audit trail of all changes
- **Automated Sync**: Continuous reconciliation of desired state
- **Drift Detection**: Alerts for manual configuration changes
- **Rollback Capability**: Quick recovery from failed deployments

### CI Pipeline Automation (Tekton)
- **Automated Builds**: Consistent build environments
- **Security Integration**: Built-in security scanning
- **Parallel Execution**: Optimized pipeline performance
- **Failure Recovery**: Automatic retry mechanisms
- **Audit Logging**: Complete pipeline execution history

### Container Security Scanning (Trivy)
- **Vulnerability Detection**: Comprehensive security scanning
- **CVE Database**: Up-to-date vulnerability information
- **Multi-language Support**: Scan OS packages and application dependencies
- **Policy Enforcement**: Block deployment of vulnerable images
- **Reporting**: Detailed security reports and recommendations

#### Trivy Image Scan Logs
<div align="center">
  <img src="./docs/screenshots/trivy-image-scan-logs.png" alt="Trivy Image Scan Logs" width="100%" />
</div>

**Trivy Image Scan Logs** - Detailed execution logs from the `trivy-image-scan` task:
- **Scan Target**: `image-registry.openshift-image-registry.svc:5000/netflix-clone/netflix-clone:latest`
- **Severity Threshold**: Configured to fail on HIGH and above severity vulnerabilities
- **Database Update**: Automatic vulnerability database update before scanning
- **OS Detection**: Alpine Linux version 3.23.4 identified
- **Scanning Process**: 
  - Vulnerability scanning enabled
  - Secret scanning enabled
  - Artifact download completed
  - Language-specific file analysis (8 files detected)
- **Security Integration**: Automated security scanning integrated into CI/CD pipeline
- **Compliance**: Ensures container images meet security standards before deployment

## Kubernetes-Native Deployment

### Auto-scaling (Horizontal Pod Autoscaler)
```yaml
# HPA Configuration
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: netflix-clone
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

**Auto-scaling Features** - Scalability features:
- **CPU-based Scaling**: Scaling based on CPU usage
- **Memory-based Scaling**: Scaling based on memory usage
- **Custom Metrics**: Custom scaling metrics
- **Graceful Scaling**: Smooth scaling without interruption
- **Cost Optimization**: Resource cost optimization

### Resource Governance
```yaml
# ResourceQuota Example
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    limits.cpu: "4"
    limits.memory: 8Gi
    persistentvolumeclaims: "2"
    services: "5"
    
# LimitRange Example
spec:
  limits:
  - default:
      cpu: 500m
      memory: 512Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
    type: Container
```

**Resource Governance** - Resource management:
- **ResourceQuota**: Project-level resource quotas
- **LimitRange**: Default resource limits
- **Quality of Service**: Service quality assurance
- **Resource Isolation**: Resource isolation between applications
- **Cost Control**: Infrastructure cost control

### Pod Resilience (Pod Disruption Budget)
```yaml
# PDB Configuration
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: netflix-clone
```

**Pod Resilience** - Availability guarantee:
- **High Availability**: Application availability guarantee
- **Graceful Updates**: Smooth updates
- **Maintenance Windows**: Scheduled maintenance windows
- **Disruption Handling**: Disruption management
- **Service Continuity**: Service continuity

## 🔒 Security Context & Compliance

### OpenShift Security Contexts
```yaml
# Security Context Configuration
securityContext:
  runAsNonRoot: true
  runAsUser: 1001
  fsGroup: 1001
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    drop:
    - ALL
```

**Security Contexts** - Security configurations:
- **Non-root Execution**: Running without root privileges
- **Seccomp Profiles**: System call restrictions
- **Capability Dropping**: Removing unnecessary privileges
- **File System Permissions**: File system permissions
- **Network Policies**: Network policies

### Service Account & RBAC
```yaml
# ServiceAccount Configuration
apiVersion: v1
kind: ServiceAccount
metadata:
  name: netflix-clone-sa

# RoleBinding Configuration
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: netflix-clone-rb
subjects:
- kind: ServiceAccount
  name: netflix-clone-sa
roleRef:
  kind: ClusterRole
  name: edit
  apiGroup: rbac.authorization.k8s.io
```

**Identity and Access Management** - RBAC:
- **Service Accounts**: Dedicated service accounts
- **Least Privilege**: Least privilege principle
- **Role-based Access**: Role-based access control
- **Audit Logging**: Access logging
- **Token Management**: Secure token management

## 📊 Observability & Monitoring

### Health Checks
```yaml
# Health Check Configuration
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
  
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
```

**Health Checks** - Application monitoring:
- **Liveness Probe**: Application liveness check
- **Readiness Probe**: Application readiness check
- **Startup Probe**: Startup verification
- **Graceful Termination**: Smooth termination
- **Self-healing**: Self-healing

### Logging & Monitoring
- **Structured Logging**: تسجيل منظم للأحداث
- **Metrics Collection**: جمع مقاييس الأداء
- **Distributed Tracing**: تتبع العمليات الموزعة
- **Error Tracking**: تتبع الأخطاء
- **Performance Monitoring**: مراقبة الأداء

## 🔄 Declarative Infrastructure

### Kubernetes Manifests
- **YAML Configuration**: تكوينات YAML منظم
- **Version Control**: التحكم في إصدارات البنية التحتية
- **Immutable Infrastructure**: بنية تحتية غير قابلة للتغيير
- **Infrastructure as Code**: البنية التحتية ككود
- **GitOps Workflow**: سير عمل GitOps

### Kustomize Integration
```yaml
# Kustomization Structure
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- deployment.yaml
- service.yaml
- route.yaml
- hpa.yaml
- pdb.yaml

images:
- name: netflix-clone
  newTag: latest

replicas:
- name: netflix-clone
  count: 3
```

**Kustomize** - Configuration customization:
- **Base Configurations**: Base configurations
- **Environment Overrides**: Environment overrides
- **Patch Management**: Patch management
- **Resource Generation**: Resource generation
- **Configuration Management**: Configuration management

---

# What is in this repository

This repository contains only application-owned assets:

- React + TypeScript frontend
- Kubernetes manifests (OpenShift deployment)
- ArgoCD application definition

---

# What is NOT in this repository

These components are managed externally at cluster level:

- ArgoCD Operator installation
- Tekton Pipeline definitions (cluster-managed)
- OpenShift cluster infrastructure
- Container registry
- Prometheus / Grafana monitoring stack
- Networking / routing infrastructure

---

# Repository Structure

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
```

=======
>>>>>>> 23f58f0e679b1cc87dc3bb38b45ad6c72c809a6c
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
<<<<<<< HEAD
└─ src/                             # React application
```

## Deploy on OpenShift (GitOps)

### Prerequisites

- **OpenShift cluster** (CRC / dev cluster is fine)
- **OpenShift GitOps (ArgoCD)** installed (usually via Operator)
- **Access** to create an ArgoCD `Application` in `openshift-gitops`

### Steps

1. **Push this repository** to your GitHub (or any git server ArgoCD can reach).
2. **Update the repo URL** in `argocd/application.yaml`:
   - `spec.source.repoURL`: point to your fork/repo
   - `spec.source.targetRevision`: branch (e.g. `main`)
3. **Apply the ArgoCD Application** (example):

```bash
oc apply -f argocd/application.yaml
```

4. Open ArgoCD UI and confirm the app becomes **Synced** and **Healthy**.
5. The app is exposed via **OpenShift Route** (`openshift/route.yaml`).

# Screenshots

## Application UI

### Home Page
<div align="center">
  <img src="./public/assets/home-page.png" alt="Home Page" width="100%" />
</div>

**Home Page** - Main user interface of the Netflix Clone application displaying:
- List of popular movies and TV shows
- Modern design similar to Netflix
- Smooth user interaction
- Dynamic content display from TMDB API

---

### Mini Portal
<div align="center">
  <img src="./public/assets/mini-portal.png" alt="Mini Portal" width="100%" />
</div>

**Mini Portal** - Dedicated interface for displaying:
- Curated and categorized content
- Quick access to different sections
- Responsive design working on all devices
- Enhanced user experience for quick browsing

---

### Detail View
<div align="center">
  <img src="./public/assets/detail-modal.png" alt="Detail Modal" width="100%" />
</div>

**Detail View** - Modal window displaying:
- Complete information about movie or TV show
- Rating, date, and duration
- Cast and director list
- Story description and official poster
- Option to add to watchlist

---

### Genre Grid
<div align="center">
  <img src="./public/assets/grid-genre.png" alt="Grid Genre Page" width="100%" />
</div>

**Genre Grid** - Content classification page:
- Display all movies by genre (Action, Comedy, Drama, etc.)
- Organized grid design for easy searching
- Advanced filtering by year and rating
- Dynamic content loading on scroll

---

### Watch Page
<div align="center">
  <img src="./public/assets/watch.png" alt="Watch Page" width="100%" />
</div>

**Watch Page** - Content playback interface:
- Integrated video player
- Movie information during playback
- Playback quality control
- Auto-play queue
- Subtitle and audio options

## OpenShift & GitOps

> These screenshots were captured from OpenShift + ArgoCD UI to document the real platform workflow.

### Installed Operators
<div align="center">
  <img src="./docs/screenshots/01-openshift-installed-operators.png" alt="Installed Operators" width="100%" />
</div>

**Installed Operators** - Display of installed operators in OpenShift:
- **OpenShift GitOps**: ArgoCD operator for continuous deployment (GitOps)
- **OpenShift Pipelines**: Tekton operator for continuous integration (CI)
- Ensure operators are installed in ready and stable state

---

### ArgoCD Application Details
<div align="center">
  <img src="./docs/screenshots/10-argocd-app-details.png" alt="ArgoCD Application details" width="100%" />
</div>

**ArgoCD Application Details** - Comprehensive application information:
- Sync Status: Synced
- Health Status: Healthy
- Source information: GitHub repository URL
- Target: OpenShift cluster namespace
- Last sync timestamp and configuration details

---

### ArgoCD Application Tree
<div align="center">
  <img src="./docs/screenshots/06-argocd-app-tree.png" alt="ArgoCD app tree" width="100%" />
</div>

**ArgoCD Application Tree** - Hierarchical resource view:
- **Deployment**: Application replica management
- **Service**: Internal cluster routing
- **Route**: External access via URL
- **HPA**: Horizontal auto-scaling
- **PDB**: Pod disruption budget
- **ResourceQuota**: Resource quotas
- **LimitRange**: Resource limits

---

### OpenShift PipelineRun Logs
<div align="center">
  <img src="./docs/screenshots/openshift-pipelinerun-logs.png" alt="OpenShift PipelineRun Logs" width="100%" />
</div>

**OpenShift PipelineRun Logs** - Detailed execution logs from the `netflix-clone-devsecops-run-004524` PipelineRun:
- **PipelineRun Status**: Succeeded
- **Task Focus**: `trivy-image-scan` task logs displayed
- **Security Scan Execution**:
  - Trivy Image Security Scan (DevSecOps) initiated
  - Target image: `image-registry.openshift-image-registry.svc:5000/netflix-clone/netflix-clone:latest`
  - Severity threshold: HIGH and above
- **Database Operations**:
  - Vulnerability database update completed
  - Artifacts downloaded successfully
- **Scanning Configuration**:
  - Vulnerability scanning enabled
  - Secret scanning enabled
- **OS Detection**: Alpine Linux version 3.23.4 identified
- **File Analysis**: 8 language-specific files detected for vulnerability scanning
- **Pipeline Integration**: Security scanning seamlessly integrated into CI/CD workflow

---

### OpenShift Project Overview
<div align="center">
  <img src="./docs/screenshots/08-openshift-project-overview.png" alt="OpenShift project overview" width="100%" />
</div>

**OpenShift Project Overview** - Project control panel:
- Pod status and distribution
- Resource usage (CPU/Memory/Storage)
- Network and Routes information
- Events and alerts list
- Applications and services statistics

---

### Pod Metrics
<div align="center">
  <img src="./docs/screenshots/02-openshift-pod-metrics.png" alt="Pod metrics" width="100%" />
</div>

**Pod Metrics** - Performance monitoring of pods:
- **CPU Usage**: Real-time processor usage
- **Memory Usage**: Memory usage and distribution
- **Network I/O**: Data transfer over network
- **Storage I/O**: Read and write operations
- Interactive performance graphs

---

### Tekton PipelineRun Details
<div align="center">
  <img src="./docs/screenshots/11-tekton-pipelinerun-details.png" alt="Tekton PipelineRun details" width="100%" />
</div>

**Tekton PipelineRun Details** - CI workflow:
- **clone-and-build**: Repository clone and application build
- **build-and-push-image**: Container image build and push
- **trivy-image-scan**: Security scan with Trivy
- **deploy-to-openshift**: Deployment to OpenShift
- Execution duration and task status

---

### Tekton Clone and Build
<div align="center">
  <img src="./docs/screenshots/04-tekton-clone-and-build.png" alt="Tekton clone and build logs" width="100%" />
</div>

**Tekton Clone and Build Logs** - First task details:
- Pull source code from GitHub
- Install dependencies (npm ci)
- Build application (npm run build)
- Code quality and tests verification
- Environment variables setup

---

### Tekton Build and Push Image Logs
<div align="center">
  <img src="./docs/screenshots/tekton-build-and-push-image-logs.png" alt="Tekton Build and Push Image Logs" width="100%" />
</div>

**Tekton Build and Push Image Logs** - Detailed container image creation and registry operations:
- **Build Process**:
  - Multi-stage Docker build execution
  - Optimized layer caching for faster builds
  - Security context application during build
- **Image Creation**:
  - Application containerization
  - Dependency layer optimization
  - Runtime environment preparation
- **Registry Operations**:
  - Image push to OpenShift internal registry
  - Tag management and versioning
  - Authentication and authorization
- **Build Configuration**:
  - Build context and Dockerfile processing
  - Build arguments and environment variables
  - Target platform specification
- **Security Integration**:
  - Build-time security scanning preparation
  - Image signing and integrity verification
  - Compliance with container security policies
- **Performance Metrics**:
  - Build duration and resource usage
  - Image size optimization results
  - Registry transfer statistics

---

### Tekton Build and Push Image
<div align="center">
  <img src="./docs/screenshots/09-tekton-build-and-push-image.png" alt="Tekton build and push logs" width="100%" />
</div>

**Tekton Build and Push Image Logs** - Container creation:
- Build multi-stage Docker image
- Optimize image size (multi-stage build)
- Push image to Container Registry
- Apply automatic tagging
- Verify deployment success

---

### Tekton Trivy Security Scan
<div align="center">
  <img src="./docs/screenshots/03-tekton-trivy-image-scan.png" alt="Tekton Trivy image scan logs" width="100%" />
</div>

**Tekton Trivy Security Scan Logs** - Vulnerability scanning:
- Scan container image for vulnerabilities
- Detailed security risk report
- Vulnerability classification (Critical/High/Medium/Low)
- Remediation and update recommendations
- Security policy integration

---

### Tekton Deploy to OpenShift
<div align="center">
  <img src="./docs/screenshots/07-tekton-deploy-to-openshift.png" alt="Tekton deploy logs" width="100%" />
</div>

**Tekton Deploy to OpenShift Logs** - Actual deployment:
- Update Kubernetes manifests
- Apply changes to OpenShift
- Wait for new pods readiness
- Verify services and Routes health
- Complete deployment successfully

---

### Tekton Pipelines Overview
<div align="center">
  <img src="./docs/screenshots/05-tekton-pipelines-overview.png" alt="Tekton pipelines overview" width="100%" />
</div>

**Tekton Pipelines Overview** - Control panel:
- List of defined pipelines
- Previous runs status
- Success and failure statistics
- Execution times and comparisons
- Failed runs retry capability

---

### Deployed Application UI
<div align="center">
  <img src="./docs/screenshots/12-app-ui.png" alt="Deployed app UI" width="100%" />
</div>

**Deployed Application UI** - Final result:
- Application running on OpenShift
- Access via OpenShift Route
- Application functionality verification
- Performance and responsiveness in production
- External services integration

---

### OpenShift Project Details

<div align="center">
  <img src="./docs/screenshots/openshift-project-details.png" alt="OpenShift Project Details" width="100%" />
</div>

**Project Overview** - Complete OpenShift project information:
- **Project Name**: netflix-clone
- **Status**: Active
- **Labels**: Kubernetes metadata and OpenShift Pipelines configuration
- **Inventory**: 1 Deployment, 1 Pod running
- **Resource Utilization**: Real-time CPU, Memory, and Network metrics

**Utilization Metrics** (Last Hour):
- **CPU**: 0.116m used (out of 200m limit)
- **Memory**: 7.84 MiB used (out of 200 MiB limit)
- **Filesystem**: 260 KiB used (out of 200 KiB limit)
- **Network**: 98.13 Bps in, 312.8 Bps out
- **Pod Count**: 1 active pod

**Activity Timeline** - Recent events:
- Image pulls and container creation
- Pod lifecycle events (start/stop/delete)
- Network interface configuration
- Automatic scaling and restart events

---

### ArgoCD Application Management

<div align="center">
  <img src="./docs/screenshots/argocd-application-management.png" alt="ArgoCD Application Management" width="100%" />
</div>

**Application Status** - Real-time ArgoCD information:
- **Health Status**: Healthy
- **Sync Status**: Synced to main (bf0793e)
- **Auto-sync**: Enabled
- **Last Sync**: Sync OK to a844d31 (17 hours ago)
- **Author**: Mina George Razk

**Application Tree** - Hierarchical resource view:
- **netflix-clone**: Main application deployment
- **netflix-clone-hpa**: Horizontal Pod Autoscaler
- **netflix-clone-pdb**: Pod Disruption Budget
- **Replica Sets**: Multiple replica sets for rolling updates
- **Pods**: Individual pod instances with health status

**Sync Statistics**:
- **Synced Items**: 4 resources synchronized
- **Out of Sync**: 0 resources
- **Healthy Resources**: 16 healthy components
- **Failed Resources**: 0 failures

**Recent Commit Activity**:
- "fix: update kustomization.yaml for Argo CD compatibility (remove namespace.yaml)"
- Author: MinaC4
- Timestamp: 20 hours ago
- Auto-sync applied successfully

---

### OpenShift Pod Metrics

<div align="center">
  <img src="./docs/screenshots/openshift-pod-metrics.png" alt="OpenShift Pod Metrics" width="100%" />
</div>

**Pod Metrics Overview** - Real-time resource utilization for `netflix-clone-654c78cfd9-sg2ff`:
- **Memory Usage**: Current usage against allocated limits (e.g., 500 MiB)
- **CPU Usage**: Current CPU consumption in millicores (e.g., 200m)
- **Filesystem**: Disk I/O and storage usage (e.g., 200 KiB)
- **Network In**: Incoming network traffic in Bps

**Key Observations**:
- Consistent resource usage patterns over time
- Metrics indicate stable performance within allocated limits
- No significant spikes or anomalies observed
- Development cluster warning displayed (not for production use)

---

### OpenShift PipelineRun Details

<div align="center">
  <img src="./docs/screenshots/openshift-pipelinerun-details.png" alt="OpenShift PipelineRun Details" width="100%" />
</div>

**PipelineRun Details** - Comprehensive view of the CI/CD pipeline execution:
- **PipelineRun Name**: `netflix-clone-devsecops-run-004524`
- **Status**: Succeeded
- **Namespace**: `openshift-pipelines`
- **Pipeline**: `netflix-clone-pipeline`
- **Start Time**: Apr 30, 2026, 12:45 AM
- **Completion Time**: 7 minutes ago
- **Duration**: 5 minutes 12 seconds

**Pipeline Tasks Overview**:
- **clone-and-build**: Successfully cloned the repository and built the application
- **build-and-push-image**: Successfully built and pushed the Docker image to the registry
- **trivy-image-scan**: Successfully scanned the image for vulnerabilities using Trivy
- **deploy-to-openshift**: Successfully deployed the application to OpenShift

---

### OpenShift PipelineRun Logs

<div align="center">
  <img src="./docs/screenshots/openshift-pipelinerun-logs.png" alt="OpenShift PipelineRun Logs" width="100%" />
</div>

**PipelineRun Logs** - Detailed execution logs for the `clone-and-build` task:
- **Build Process**: 
  - npm run build execution
  - TypeScript compilation with Vite
  - Asset generation and optimization
- **Output Artifacts**:
  - JavaScript and CSS bundles generated
  - Asset sizes reported (e.g., index-abc123.js 45.2KB)
  - Source maps and chunk splitting
- **Build Warnings**:
  - Large chunk size warnings after minification
  - Recommendations for dynamic imports or chunk size limit adjustments
- **Final Status**: "Build completed successfully!"

---

# Architecture Diagram

## C4 Model: System Context

```mermaid
graph TB
    subgraph "Development Layer"
        Dev[Developer]
    end
    
    subgraph "Source Control"
        GitHub[GitHub Repository<br/>Source of Truth]
    end
    
    subgraph "CI Layer"
        Tekton[Tekton CI Pipeline<br/>OpenShift Pipelines]
    end
    
    subgraph "Container Registry"
        Registry[Container Registry<br/>Image Storage]
    end
    
    subgraph "CD Layer"
        ArgoCD[ArgoCD<br/>GitOps Controller]
    end
    
    subgraph "Runtime Platform"
        OpenShift[OpenShift Cluster<br/>Kubernetes Runtime]
    end
    
    subgraph "Observability"
        Prometheus[Prometheus<br/>Metrics]
        Grafana[Grafana<br/>Dashboards]
    end
    
    Dev -->|Push Code| GitHub
    GitHub -->|Trigger| Tekton
    Tekton -->|Build & Scan| Registry
    Registry -->|Image Update| ArgoCD
    GitHub -->|Manifest Sync| ArgoCD
    ArgoCD -->|Deploy| OpenShift
    OpenShift -->|Metrics| Prometheus
    Prometheus -->|Data| Grafana
    
    style Dev fill:#e1f5fe
    style GitHub fill:#f3e5f5
    style Tekton fill:#e8f5e8
    style Registry fill:#fff3e0
    style ArgoCD fill:#fce4ec
    style OpenShift fill:#f1f8e9
    style Prometheus fill:#e0f2f1
    style Grafana fill:#e0f2f1
```

## Component Breakdown

### 1. Developer Workflow
- **Local Development**: React + TypeScript + Vite
- **Code Push**: Git commits to GitHub
- **Branch Strategy**: Feature branches → Main branch

### 2. Source Control (GitHub)
- **Application Code**: React frontend (`src/`)
- **Infrastructure as Code**: Kubernetes manifests (`openshift/`)
- **GitOps Configuration**: ArgoCD Application (`argocd/`)
- **Version Control**: Complete traceability of changes

### 3. CI Pipeline (Tekton)
```yaml
Pipeline Tasks:
  - clone-repository: Git checkout
  - build-application: npm build
  - build-image: Docker build
  - security-scan: Trivy vulnerability scan
  - push-image: Container registry push
  - update-manifest: Image tag update
```

### 4. Container Registry
- **Image Storage**: Built container images
- **Versioning**: Semantic tags and digests
- **Security**: Image signing and scanning
- **Distribution**: Pull access for clusters

### 5. CD Pipeline (ArgoCD)
```yaml
GitOps Features:
  - Continuous Sync: Git → Cluster
  - Health Monitoring: Application status
  - Drift Detection: Manual changes alert
  - Self-Healing: Automatic reconciliation
  - Rollback: Previous version restore
```

### 6. Runtime (OpenShift)
```yaml
Kubernetes Resources:
  - Deployment: Pod management
  - Service: Internal networking
  - Route: External access
  - HPA: Auto-scaling
  - PDB: Availability guarantee
  - ResourceQuota: Resource limits
  - LimitRange: Default constraints
```

### 7. Observability Stack
- **Metrics Collection**: Prometheus scraping
- **Visualization**: Grafana dashboards
- **Alerting**: Threshold-based notifications
- **Logging**: Centralized log aggregation

## Data Flow Analysis

### CI Flow
1. **Code Commit** → GitHub webhook triggers Tekton
2. **Build Process** → Creates optimized container image
3. **Security Scan** → Trivy analyzes for vulnerabilities
4. **Image Push** → Stores in container registry
5. **Manifest Update** → Updates image tag in Git

### CD Flow
1. **Git Change Detection** → ArgoCD monitors repository
2. **Sync Process** → Applies desired state to cluster
3. **Health Check** → Validates deployment success
4. **Monitoring** → Tracks application performance

## Security Considerations

### CI Security
- **Image Scanning**: Trivy vulnerability detection
- **Secret Management**: OpenShift Secrets integration
- **Access Control**: RBAC for pipeline execution
- **Audit Trail**: Complete pipeline logging

### CD Security
- **GitOps Verification**: Signed commits verification
- **Network Policies**: Restrict pod communication
- **Pod Security**: SCC and security contexts
- **Resource Isolation**: Namespace separation

## Performance Optimizations

### Build Optimization
- **Multi-stage Builds**: Reduce image size
- **Layer Caching**: Speed up builds
- **Parallel Execution**: Tekton task parallelization
- **Resource Limits**: Controlled resource usage

### Runtime Optimization
- **Horizontal Pod Autoscaler**: Scale based on demand
- **Resource Requests/Limits**: Efficient resource allocation
- **Pod Disruption Budget**: High availability
- **Health Checks**: Proactive monitoring

---

# Deployment (GitOps - ArgoCD)

## Prerequisites
- **OpenShift cluster** (CRC or production cluster)
- **OpenShift GitOps Operator** installed
- **Access to ArgoCD UI**

## Steps

### 1. Apply ArgoCD Application
```bash
oc apply -f argocd/application.yaml
```

### 2. Configure Repository

Update:
```yaml
spec:
  source:
    repoURL: YOUR_REPOSITORY_URL
    targetRevision: main
```

### 3. Verify Deployment

Open ArgoCD UI and check:
- **Sync Status** → ✔ Synced
- **Health Status** → ✔ Healthy

---

# Local Development

## TMDB API key

- Create an account on [TMDB](https://www.themoviedb.org/)
- Create an API key following the [TMDB docs](https://developers.themoviedb.org/3/getting-started/introduction)
- Create `.env` based on `.env.example` and set `TMDB_V3_API_KEY`

## Run locally
```bash
npm ci
npm run dev
```

## Docker Build
```bash
docker build --build-arg TMDB_V3_API_KEY=YOUR_KEY -t netflix-clone .
docker run -p 8080:8080 netflix-clone
```

---

# Key Engineering Concepts Demonstrated

- **GitOps architecture design**
- **CI/CD separation** (Tekton vs ArgoCD)
- **Kubernetes-native application deployment**
- **Cluster-level vs repo-level responsibilities**
- **DevSecOps lifecycle implementation**

---

# Summary

This project demonstrates a production-style DevSecOps system where:

- **GitHub** = Source of truth
- **Tekton** = CI engine
- **ArgoCD** = CD engine
- **OpenShift** = Runtime platform

### TMDB API key

- Create an account on [TMDB](https://www.themoviedb.org/)
- Create an API key following the [TMDB docs](https://developers.themoviedb.org/3/getting-started/introduction)
- Create `.env` based on `.env.example` and set `TMDB_V3_API_KEY`

### Run locally

```bash
npm ci
npm run dev
```

## Build & run with Docker (optional)

```bash
docker build --build-arg TMDB_V3_API_KEY=your_api_key_here -t netflix-clone .
docker run --name netflix-clone-website --rm -d -p 8080:8080 netflix-clone
```
=======
└─ src/                      # React application
>>>>>>> 23f58f0e679b1cc87dc3bb38b45ad6c72c809a6c
