---
type: "API"
title: "API do EditalMD"
description: "Superfície HTTP e MCP do EditalMD, com o modelo de cobrança."
resource: "https://editalmd.com/api/"
---

# API do EditalMD

Base: https://editalmd.com

## Como pagar

Busca e ficha da compra: **grátis**. Documento de compra publicada há 30+ dias: **grátis**.
Publicação recente: **$0.01 por requisição**, de duas formas:

1. **x402** — peça sem token, receba `HTTP 402` com `accepts[]`, pague e repita com `X-PAYMENT`.
2. **Crédito pré-pago** — `POST https://editalmd.com/api/credito?usd=10` devolve um token `cred_…`; mande
   `Authorization: Bearer cred_…` nas rotas pagas. O mesmo token vale em todos os produtos da casa.

Nunca cobra: documento inexistente (404), documento sem texto neste acervo (409), compra sem data.

**Segundo andar** (mesmas duas portas): `POST /api/dono` cria o token `edm_…` sem cadastro; o 1º alerta e a 1ª vigia
são grátis, os seguintes custam $0.10 por alerta (30 dias) e $0.05 por vigia;
a habilitação do edital (`POST /api/documento/{id}/habilitacao`) custa $0.05 em compra recente,
é grátis com 30+ dias e sai do cache sem cobrar quando o texto é o mesmo.

## Endpoints

* `GET /api/` — Índice auto-descrito: rotas, regime de cobrança, preço e MCP.
* `GET /api/health` — Saúde da origem e tamanho do acervo.
* `POST /mcp` — MCP Streamable HTTP — as tools deste catálogo, despachadas neste mesmo Worker.
* `GET /okf/:arquivo` — Bundle OKF (Open Knowledge Format v0.1): markdown com frontmatter para o agente ler o produto inteiro sem parsear HTML.
* `GET /.well-known/:arquivo` — Descoberta de máquina antes da home: `api-catalog` (RFC 9727, linkset com a API e o MCP), `security.txt` (RFC 9116) e `mcp-registry-auth` (chave do registro oficial de MCP).
* `GET /apis.json` — APIs.json (apisjson.org, 0.19): o índice que o APIs.io colhe — a API, o MCP, OpenAPI, guia e bundle OKF num arquivo só. Também em `/.well-known/apis.json`.
* `GET /feed.xml` — RSS 2.0 das compras publicadas mais recentemente no acervo.
* `GET /feed.json` — JSON Feed 1.1 das compras publicadas mais recentemente — o mesmo stream do RSS.
* `GET /api/busca` — Busca compras do PNCP por termo. Sempre grátis — é a descoberta.
* `GET /api/cnaes` — A lista de CNAE como o alerta por CNPJ a lê: descrição oficial (IBGE), família e termos do dicionário, e fornecedores ativos no SICAF. Grátis.
* `GET /api/compra/:id` — Ficha da compra com prazos de proposta e impugnação, documentos e o regime de cobrança de cada um.
* `GET /api/documento/:id/markdown` — Documento em markdown com front-matter de procedência e hash. Grátis se a compra tem 30+ dias; pago se é recente.
* `POST /api/documento/:id/habilitacao` — Lista de habilitação do edital: cada exigência com o trecho literal de onde saiu. Pago por documento; mesmo texto não paga de novo.
* `POST /api/dono` — Cria o token de dono que abre alertas e vigias, e o segredo que assina os webhooks. Sem cadastro.
* `GET /api/dono` — O estado do dono: e-mail confirmado, franquia e o segredo que assina os webhooks.
* `POST /api/dono/segredo` — Rotaciona o segredo do webhook. O anterior ainda assina por 24 h, para trocar sem janela de falha.
* `POST /api/dono/confirmar-email` — Confirma o e-mail de destino dos alertas com o código de 6 dígitos recebido.
* `POST /api/alertas` — Cria alertas de compra nova: por termos do objeto e UF, ou pelo CNPJ da empresa (um alerta por família de atividade), entregues por pull, webhook ou e-mail.
* `GET /api/alertas` — Lista os alertas deste dono, os mais novos primeiro.
* `GET /api/alertas/:id` — Um alerta do dono, com o cursor da última verificação do cron.
* `GET /api/alertas/:id/compras` — As compras que já casaram com o alerta — é o canal pull, e a prova do que foi entregue.
* `PATCH /api/alertas/:id` — Pausa, reativa ou muda termos, UF, canal e destino de um alerta.
* `DELETE /api/alertas/:id` — Apaga o alerta e o histórico de compras casadas. Sem volta.
* `POST /api/vigias` — Vigia uma compra: fotografa agora e avisa quando mudar — documento novo, suspensão, prazo adiado, valor — e nos prazos.
* `GET /api/vigias` — Lista as vigias deste dono, as mais novas primeiro.
* `GET /api/vigias/:id` — Uma vigia do dono com a fotografia mais recente da compra.
* `GET /api/vigias/:id/eventos` — O que mudou na compra vigiada, evento a evento — é a série temporal e o canal pull.
* `DELETE /api/vigias/:id` — Apaga a vigia e seus eventos. Sem volta.
* `POST /api/credito` — Recarrega crédito pré-pago: paga uma vez com x402 e recebe o token que desconta em qualquer API da casa.
* `GET /api/credito` — Saldo e extrato do crédito — as últimas movimentações, sem devolver o token.
* `POST /api/visit` — Ping da interface que incrementa a visita do dia no painel do operador. Agente não precisa chamar.
* `GET /api/metrics` — Métricas dos últimos 7 dias para o painel do operador; com o token, inclui os pagamentos.
* `GET /api/recibo/:id` — Recibo de uma entrega — a prova de o que saiu, quanto custou e com qual hash.

Catálogo completo: https://editalmd.com/llms-full.txt · OpenAPI: https://editalmd.com/openapi.json
