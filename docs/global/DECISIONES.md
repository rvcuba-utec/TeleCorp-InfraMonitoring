# Decisiones por acordar (para cerrar antes de repartir el trabajo)

Contexto: unifiqué tu README (módulos AWS, Azure y GCP) con mi propuesta en `REQUISITOS.md`. El reparto de nubes coincide con el tuyo. Quedan **4 puntos** por decidir y **1 hueco** por cerrar. Marca tu elección en cada uno.

## Decisiones

### 1. IA generativa (Gemini) en GCP — *bloquea trabajo en paralelo*
Tu GCP hace predicción y analítica. Yo añado una API de IA generativa en GCP que Azure llama para:
- clasificar el texto de cada reporte (categoría, urgencia, menciona hospital/colegio/industria);
- resumir una incidencia para el operador.

Si falla, Azure clasifica por reglas y sigue funcionando.
- [ ] **A.** Sí, se incluye (suma a la rúbrica de IA; Azure llama a GCP; requerimientos RF-AZ-30/31 y RF-GCP-11…13).
- [ ] **B.** No, GCP queda solo con predicción y analítica.

### 2. Definición de "reportes relacionados" (regla de 10 usuarios)
Tu RF-AZ-06 pide misma ubicación + mismo tipo de problema + cercanía temporal. El enunciado solo dice "un inconveniente relacionado con el servicio" en la misma zona.
- [ ] **A.** Misma zona + tiempo, cualquier tipo; el tipo queda como modo configurable (mi propuesta).
- [ ] **B.** Misma zona + mismo tipo + tiempo.

### 3. Tipos de evento que AWS envía a Azure — *bloquea trabajo en paralelo*
Tu RF-AZ-10: fallas, degradaciones, saturaciones y recuperaciones. AWS además emitiría: **preventiva** (predicción de GCP), **estructural** (antena reincidente) y **prolongada** (no se recupera en mucho tiempo).
- [ ] **A.** Azure acepta los 7 tipos (mi propuesta).
- [ ] **B.** Solo los 4 originales; lo preventivo y estructural se ve solo en AWS/GCP.

### 4. Quién hace qué con la recurrencia
- AWS la **detecta** cada noche (≥3 episodios en 7 días o ≥5 en 30) y emite el evento "estructural".
- GCP la **analiza y visualiza** (tu RF-GCP-09).
- [ ] **A.** Así dividido (mi propuesta).
- [ ] **B.** Solo GCP, sin evento operativo.

## Hueco por cerrar
Tu RF-GCP-01 dice que GCP recibe métricas de AWS, pero ningún requisito de tu módulo AWS las envía. Añadí **RF-AWS-19** (lotes cada 5 min, idempotentes). Confirma que te parece bien.

## Cosas que añadí y necesitan tu visto bueno (no contradicen nada)
- **Sobre común de eventos** (`event_id`, `type`, `schema_version`, `occurred_at`, `correlation_id`) con entrega idempotente.
- **`GET /config` en AWS** con los umbrales globales; Azure y GCP la leen con caché y valores por defecto.
- **4 máquinas de Step Functions** en AWS (`antenna-incident-lifecycle`, `preventive-alert`, `recurrence-analysis`, `event-redelivery`).
- **Picos de reportes en Azure** (cola que absorbe y responde 202).
- **Catálogo de zonas único** en el repo (`zones.json`) para los tres módulos.

## Pregunta sobre tecnología
En tu repo vi `reference/` con módulos de Terraform de *data mesh* y *secured data warehouse*. ¿Los vas a usar? Por lo que sé, suelen asumir una organización de GCP y servicios con costo (Dataflow, KMS, VPC Service Controls). Mi propuesta para GCP es más simple: BigQuery, BigQuery ML y Cloud Run con comandos `gcloud`. ¿Cuál prefieres?
