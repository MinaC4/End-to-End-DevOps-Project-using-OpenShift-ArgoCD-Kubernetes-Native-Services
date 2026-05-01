<div align="center">
Netflix Clone — End-to-End DevOps + GitOps Platform
https://react.dev/
https://www.typescriptlang.org/
https://vitejs.dev/
https://www.redhat.com/en/technologies/cloud-computing/openshift
https://tekton.dev/
https://argoproj.github.io/cd/
https://nginx.org/
LICENSE
A modern Netflix UI clone deployed on OpenShift using enterprise-grade DevOps + GitOps patterns
React + TypeScript + Vite → Tekton (CI) → ArgoCD (CD) → OpenShift (Runtime)
</div>

Table of Contents
Architecture Overview
Project Structure
Application Layer
CI/CD Pipeline
GitOps Layer
OpenShift Runtime
Observability
Quick Start
Key Engineering Concepts
Screenshots

Architecture Overview
<div align="center">
End-to-End DevOps + GitOps Architecture Flow
</div>

Architecture Zones

Zone | Component | Technology | Purpose  
Developer | GitHub Repository | Git | Source of Truth  
CI | Tekton Pipelines | OpenShift Pipelines | Build, Scan, Deploy  
Registry | OpenShift Internal Registry | Container Storage | Image Storage  
CD | ArgoCD | OpenShift GitOps | GitOps Synchronization  
Runtime | OpenShift Cluster | Kubernetes | Application Runtime  
Access | OpenShift Route | HAProxy | External Access  
Observability | Prometheus + Grafana | Monitoring Stack | Metrics & Logs  

Data Flow

Developer pushes code → GitHub (main)  
↓  
Tekton Pipeline Triggered (openshift-pipelines)  
├─ Task 1: clone-and-build (npm install + build)  
├─ Task 2: build-and-push-image (Buildah → Registry)  
├─ Task 3: trivy-image-scan (DevSecOps - HIGH severity)  
└─ Task 4: deploy-to-openshift (oc set image + rollout)  
↓  
OpenShift Internal Registry  
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

Project Structure

End-2-End-DevOps-OpenShift-Platform/  
├── app/  
├── docker/  
├── tekton/  
├── openshift/  
├── argocd/  
├── docs/  
├── README.md  
└── LICENSE  

Application Layer

Technology Stack

Layer | Technology | Version | Purpose  
Framework | React | 18.x | UI Library  
Language | TypeScript | 5.x | Type Safety  
Build Tool | Vite | 4.x | Fast bundling  
UI Components | Material UI | 5.x | Design system  
Data Source | TMDB API | v3 | Movies & TV shows  
Web Server | Nginx | stable-alpine | Static serving  

Key Features

Home Page — Featured content carousel  
Movie/TV Details — Content info page  
Watch Page — Streaming simulation  
Genres Grid — Browse categories  
Dynamic Content — TMDB API  
Responsive Design — Mobile-first  

CI/CD Pipeline

Tekton Pipeline: netflix-clone-pipeline  
Namespace: openshift-pipelines  

Tasks:

1. clone-and-build  
2. build-and-push-image  
3. trivy-image-scan  
4. deploy-to-openshift  

GitOps Layer

ArgoCD Application: netflix-clone  

Features:

Continuous Sync  
Self-Healing  
Drift Detection  
Declarative Configuration  

OpenShift Runtime

Namespace: netflix-clone  

Resources:

Namespace  
Deployment  
Service  
Route  
HPA  
PDB  
ResourceQuota  
LimitRange  
Security  

Observability

Components:

OpenShift Pipelines  
OpenShift GitOps  
Internal Registry  
Monitoring (Prometheus + Grafana)  
Router (HAProxy)  

Quick Start

1. Clone repo  
2. Configure TMDB API  
3. Deploy ArgoCD  
4. Trigger pipeline  
5. Verify deployment  

Key Engineering Concepts

GitOps  
CI/CD Separation  
DevSecOps  
Kubernetes-Native  
Declarative Infrastructure  
Auto Scaling  
Resilience  
Resource Governance  
Non-Root Security  
Supply Chain Security  
Edge TLS  

Screenshots

<div align="center">
Application UI  
Tekton Pipeline  
ArgoCD Sync Status  
OpenShift Resources  
</div>
