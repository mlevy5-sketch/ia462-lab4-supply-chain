IA 462 Lab 4 - Supply Chain Security
Overview 
This repository contains a flask web application used to demonstrate software supply chain security controls. 
The project implements dependency management,container security, github security features, CI/CD scanning, dependency review gates,
and SBOM generation. 
Supply chain controls implemented
1. Pinning vs. Floating Dependencies
To prevent unexpected dependency changes, all Python packages are pinned to versions in requirements.txt.
 requirements.txt contained flask==3.0.3, werkzeug==3.0.3
A hash-locked requirements.lock file was generated using pip-compile to ensure reproducible builds
The Docker base image is also pinned rather than using a floating tag
2. GitHub Dependency Security Tools
The following GitHub security features were enabled: Dependency graph, Dependabot alerts, Dependabot security updates,
secret scanning, and push protection.
These features provide visibility into dependencies and vulnerability alerts
3. Dependency Confusion & Supply Chain Attacks
Mitigations include exact version pinning, hash verified dependency installation, dependabot monitoring,
protected branch policies, and pull request requirements
These controls reduce the risk of introducing malicious packages
4. Securing Dependencies in GitHub Actions
All third party Github actions are pinned to full commit shas rather than floating version tags
examples include actions/checkout, docker/setup-buildx-action, actions/upload-artifact, actions/setup-python,
aquasecurity/trivy-action
This reduces the risk of upstream action tampering
5. Software Bill of Materials (SBOM)
SBOMs are generated suing Syft in multiple formats
The formats include SPDX JSON, CycloneDX JSON, and a readable table format
SBOM snapshots are stored in sboms/ directory and can be exported from Github's dependency graph
6. Integrating Dependency Scanning into CI/CD
The security pipeline performs docker image build validation, trivy container vulnerability scanning, syft sbom generation,
and python dependency auditing using pip audit
7. GitHub's Dependency Review Action
A dependency review workflow evaluates pull requests and blocks dependency changes that have high severity vulnerabilities,
 restricted licenses, and unsafe updates
This provides automated supply chain protection before code can be merged


Vulnerable Dependency Demonstration
To demonstrate the effectiveness of the security controls follow this demo
step 1: create a branch named test
step 2: modify the requirements.txt file to have flask==2.0.0, werkzeug==2.0.0
step 3: regenerate the requirements.lock file 
step 4: push the test branch and open a pull request
step 5: observe the failing security checks
step 6: close the pull request without merging and reset the requirements.txt file 
This demo demonstrates that the controls will prevent a vulnerable dependency from being merged into main







