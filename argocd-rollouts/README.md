# Argo Rollouts - StayHub

Argo Rollouts provides advanced Kubernetes deployment strategies for the
StayHub application.

StayHub uses a **Blue-Green deployment strategy**.

## Architecture

```text
                    Argo CD
                       |
                       v
                 StayHub Rollout
                       |
              +--------+--------+
              |                 |
              v                 v
        Active Service    Preview Service
              |                 |
              v                 v
        Current Version    New Version