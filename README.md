# Kubernetes T-Pot

A Kubernetes deployment configuration for T-Pot honeypot.

## Overview

This repository contains Kubernetes manifests and configurations for deploying T-Pot, a multi-honeypot platform.

## Prerequisites

- Kubernetes cluster (1.19+)
- kubectl configured to access your cluster
- Sufficient cluster resources for honeypot deployment

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd kubernetes-tpot
   ```

2. Apply the Kubernetes manifests:
   ```bash
   kubectl apply -f .
   ```

3. Monitor the deployment:
   ```bash
   kubectl get pods -n tpot
   ```

## Configuration

Configuration files are located in the root directory. Modify the YAML files to adjust:
- Resource limits
- Network policies
- Service configurations
- Storage requirements

## Security Considerations

- Ensure proper network isolation for honeypot services
- Review and adjust security policies before production deployment
- Monitor logs and alerts regularly

## License

See LICENSE file for details.