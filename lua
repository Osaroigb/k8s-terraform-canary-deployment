k8s-terraform-canary-deployment/
│
├── .github/
│   └── workflows/
│       └── deployment.yml
|
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── secgrp.tf
│   └── provider.tf
|
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── canary-deployment.yaml
│   └── canary-service.yaml
|
└── README.md
