# TeleCorp-InfraMonitoring (módulo AWS)

Módulo de **infraestructura y automatización** de PulsoRed (Red TeleCorp): recibe la telemetría de las antenas, detecta fallas, orquesta con Step Functions y envía eventos a Azure y GCP.

100 % serverless: API Gateway, Lambda, DynamoDB, SQS, Step Functions, EventBridge, Secrets Manager.

Despliegue: `sam build && sam deploy` (requiere credenciales de AWS Academy).
Contratos compartidos con Azure y GCP: `contracts/`.
