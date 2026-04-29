---

<div align="center">
  <img src="./public/assets/netflix-logo.png" alt="Netflix Clone" width="120" />
  <h2>Netflix Clone - DevSecOps on OpenShift via GitOps</h2>
  <p>
    React + TypeScript + Vite application deployed on <b>OpenShift</b> using <b>ArgoCD GitOps</b>.
  </p>
</div>

---

# Architecture Diagram

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

---

# What's in this Repo

### Application Services
- **Frontend**: React + TypeScript + Vite (`src/`)
- **Kubernetes Manifests**: OpenShift-specific configurations (`openshift/`)
- **GitOps Configuration**: ArgoCD Application definition (`argocd/`)

### DevSecOps & GitOps Features
- **GitOps** continuous delivery using ArgoCD
- **Security Scanning** with Trivy integrated in Tekton
- **Kubernetes-native** deployment with best practices
- **Resource Governance**: ResourceQuota, LimitRange, HPA, PDB
- **Security Controls**: SecurityContext, ServiceAccount, RoleBinding

## Repository Structure
```text
.
├─ argocd/
│   └─ application.yaml          # ArgoCD Application
├─ openshift/                    # Desired State (GitOps)
│   ├─ kustomization.yaml
│   ├─ namespace.yaml
│   ├─ security.yaml
│   ├─ deployment.yaml
│   ├─ service.yaml
│   ├─ route.yaml
│   ├─ hpa.yaml
│   ├─ pdb.yaml
│   ├─ resource-quota.yaml
│   └─ limit-range.yaml
└─ src/                          # React + TypeScript Application
```

---

# GitOps Delivery with Argo CD

The file `argocd/application.yaml` defines an Argo CD Application named `netflix-clone` that:

- Syncs Kubernetes manifests from the `openshift/` directory
- Deploys into the target namespace
- Enables **automated sync** with:
  - `prune: true` — removes resources deleted from Git
  - `selfHeal: true` — automatically fixes configuration drift

---

# Kubernetes Deployment

The manifests in `openshift/` include:

- **Deployment** with replica management
- **Service** for internal communication
- **Route** for external access (OpenShift Router)
- **HorizontalPodAutoscaler (HPA)**
- **PodDisruptionBudget (PDB)**
- **ResourceQuota** and **LimitRange**
- **Security configurations** (ServiceAccount + SCC)

### Quick Deploy (GitOps)
```bash
oc apply -f argocd/application.yaml
```

---

# Run Locally

### Development
```bash
npm ci
npm run dev
```

### Docker
```bash
docker build --build-arg TMDB_V3_API_KEY=your_key -t netflix-clone .
docker run -p 8080:8080 netflix-clone
```

---

# Tooling Screenshots

### Application UI

**Home Page**  
![Home Page](./public/assets/home-page.png)

**Mini Portal**  
![Mini Portal](./public/assets/mini-portal.png)

**Detail Modal**  
![Detail View](./public/assets/detail-modal.png)

**Genre Grid**  
![Genre Grid](./public/assets/grid-genre.png)

**Watch Page**  
![Watch Page](./public/assets/watch.png)

### OpenShift & GitOps

**Installed Operators**  
![Installed Operators](./docs/screenshots/01-openshift-installed-operators.png)

**ArgoCD Application Details**  
![ArgoCD Application Details](./docs/screenshots/10-argocd-app-details.png)

**ArgoCD Application Tree**  
![ArgoCD Application Tree](./docs/screenshots/06-argocd-app-tree.png)

**OpenShift Project Overview**  
![OpenShift Project Overview](./docs/screenshots/08-openshift-project-overview.png)

**Tekton PipelineRun Details**  
![Tekton PipelineRun](./docs/screenshots/11-tekton-pipelinerun-details.png)

**Trivy Security Scan**  
![Trivy Image Scan](./docs/screenshots/03-tekton-trivy-image-scan.png)

**Deployed Application**  
![Deployed Application](./docs/screenshots/12-app-ui.png)

---

# Security Note (Important)

This project demonstrates DevSecOps practices including:

- **Trivy** vulnerability scanning in the CI pipeline
- **Non-root** containers with dropped capabilities
- **RBAC** with least privilege
- Resource isolation and governance

**For production use, ensure**:
- Proper secret management (Secrets / External Secrets Operator / Vault)
- Image signing and verification
- NetworkPolicies
- Regular updates and patching

---
؟
