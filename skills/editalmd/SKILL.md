---
name: editalmd
description: Work with Brazilian public procurement (licitações, PNCP) through EditalMD (editalmd.com). Search tenders by product, service and state, read the proposal deadline and the estimated last day to challenge, see which activities (CNAE) usually win, winning prices, valid price-registration minutes (atas) and annual purchase plans. Read a tender document (edital) as Markdown with the qualification requirements and page evidence, and create alerts for new tenders and watches on a purchase. Use when a task mentions licitação, edital, pregão, PNCP, compras públicas, Lei 14.133, ata de registro de preço or selling to the Brazilian government.
license: MIT-0
compatibility: Needs HTTPS access to editalmd.com. Works with the remote MCP server or with plain HTTP calls.
---

# EditalMD

EditalMD collects the public purchases of Brazil from the national procurement portal (PNCP).
Use it to find tenders, check their deadlines and prices, and read the tender documents as Markdown.
Original files are free at `GET /api/documento/{id}/original`. PDFs open inline; other formats download.
Processed content and requirement analysis use the paid document access.

## Connect

- MCP server (preferred): `https://editalmd.com/mcp?checkout=site`. Transport: Streamable HTTP. Every MCP tool is
  free, within its free limits: no payment. Search and records need no key.
- HTTP API: base URL `https://editalmd.com`. Each MCP tool calls one route of this API.
- If the MCP tools are not available, call the HTTP routes with `curl` or with your fetch tool.
- Discovery: `GET https://editalmd.com/api/` lists the routes, prices and limits.
  `https://editalmd.com/llms-full.txt` has the full reference.

## MCP tools

Since 2026-10-15 the tool names are in English. The old Portuguese names (`buscar_licitacao`, `criar_alerta`) still
call the same tools.

| Tool | HTTP | Use it to | Cost |
|---|---|---|---|
| `consulta_cadastro` | `GET /api/consulta/cadastro/{cnpj}` | Read basic company data without contacts or live analysis. | Free, no allowance consumed |
| `consulta_endereco` | `GET /api/consulta/endereco/{cep}` | Read up to 20 addresses and 20 companies of a CEP. | Free, no allowance consumed |
| `lookup_reference` | `GET /api/ref` | Find cities and state codes, activities or legal natures. Use at least two characters in `q`. | Free |
| `search_tenders` | `GET /api/busca` | Find purchases by term (`q`) and state (`uf`). Set `abertas` to keep only open proposals. | Free |
| `get_procurement` | `GET /api/compra/{id}` | Read a purchase: object, agency, value, dates and its documents. | Free |
| `get_deadlines` | `GET /api/compra/{id}` | Read the proposal deadline and the estimated last day to challenge (Lei 14.133, art. 164). | Free |
| `who_supplies` | `GET /api/compra/{id}/cnaes` | See which activities (CNAE) usually win purchases like this one. | Free |
| `open_tenders_in_field` | `GET /api/compra/{id}/abertas` | List open tenders of the same line of business from the last 7 days. | Free |
| `awarded_prices` | `GET /api/precos` | Get the winning price of a similar item: count, median and range. | Free summary |
| `framework_agreements` | `GET /api/atas` | Find valid price-registration minutes and see if they accept adhesion. | Free |
| `procurement_plans` | `GET /api/planos` | See what agencies plan to buy before the tender opens. | Free |
| `list_examples` | `GET /api/exemplos` | Get five processed sample documents. | Free |
| `get_document` | `GET /api/documento/{id}` | Read the title, type and page count of a document. | Free |
| `generation_status` | `GET /api/documento/{id}/geracao` | Read the progress of a document and its page count. | Free |
| `get_tender_markdown` | `GET /api/documento/{id}/markdown` | Read the document as Markdown with source and hash. Send `acesso_codigo`. | With access |
| `get_qualification` | `POST /api/documento/{id}/habilitacao` | List the qualification requirements with literal excerpts. | With access |
| `get_document_dossier` | `GET /api/documento/{id}/dossie` | Read items, requirements, deadlines and obligations with page evidence. | With access |
| `create_owner` | `POST /api/dono` | Create the owner token `edm_…` for alerts and watches. You see it one time only. | Free |
| `create_alert` | `POST /api/alertas` | Create an alert for new tenders by terms and state. | First one free |
| `create_alerts_by_cnpj` | `POST /api/alertas` | Create alerts from the activities of a company (CNPJ). | First one free |
| `list_alert_matches` | `GET /api/alertas/{id}/compras` | Read the tenders that matched an alert. | Free |
| `watch_procurement` | `POST /api/vigias` | Watch one purchase for a new document, suspension, new deadline or new value. | First one free |
| `list_watch_events` | `GET /api/vigias/{id}/eventos` | Read the changes of a watched purchase. | Free |

## Rules

1. Start with the free tools: search, purchase record, deadlines, suppliers and prices.
2. Processed content needs access: one of the five samples (`list_examples`), the free evaluation below, or an
   `acesso_codigo` that the person bought on the site or the HTTP API.
3. An `acesso_codigo` is private. Keep it and send it to the reading tools. With it, you open the document again at
   no cost.
4. On the HTTP API, if `POST /api/documento/{id}/geracao` returns HTTP 202, wait for the time in `Retry-After`. Then
   read `generation_status` (GET). Do not send the POST again to check the progress.
5. Alerts and watches need the owner token. Create it once with `create_owner` and keep it secret.
   Send it as header `Authorization: Bearer edm_…` (HTTP request or MCP connection header).
6. If an MCP tool answers `free_limit`, tell the user that the free limit for that action is used up. Never pay by
   yourself. On the HTTP API, a paid route returns HTTP 402: show the price and https://editalmd.com/pricing to the
   user. The person buys on the site. Then send the same call again with the person's prepaid credit token in the
   header `X-Credito: cred_…`, with the same `idempotencia` value.
7. Keep tokens (`cred_…`, `edm_…`, `whsec_…`) and access codes secret. Do not write them in files, logs or
   answers unless the user asks you to save them.
8. The challenge deadline is an estimate: 3 business days before the session, with national holidays only.
   Tell the user to confirm it in the tender document.
9. A missing or partial dossier does not mean that the tender has no requirements. Read its coverage fields.
10. Lists return up to 20 items per page. Follow the next-page links. Do not scrape HTML pages.
11. If you get HTTP 429 or 503, wait for the time in `Retry-After` and try once more.

## Organize alerts and choose recipients

Create and edit alerts with the optional fields `nome`, `organizacao_id` and
`destinatarios: {para: [], cc: [], bcc: []}`.
Use up to 100 characters for the name and ten distinct email addresses in total.
If `para` is empty, the verified account email is the primary recipient.
CC addresses are visible. BCC addresses are hidden from recipients.
Email delivery requires the account session. Organization selection requires membership.
The organization groups the creator's personal alerts. It does not share them with other members.
Use `GET /api/me/empresas` to read the organizations available to the account.

Use `lookup_reference` or `GET /api/ref?tipo=municipio&q=Campinas` to find city names and state codes.
Send the city name in `filtros.municipios` and the state in `uf`.
The reference returns Receita codes, which are not IBGE codes.
`POST /api/alertas/previa` reads up to 20 matching tenders from the last seven days without saving the alert.

## Free evaluation for agents

An agent can test the document service without payment: one sponsored premium document and up to 100 basic
reads, up to 50 pages each, for a limited time. The guide is https://editalmd.com/avaliacao.md.
The tools are `evaluation_quota`, `evaluation_premium` and `evaluation_basic`.

## Paid features (site and HTTP API)

- The person buys on the site: https://editalmd.com/pricing shows the plans and the prepaid credit, with the
  prices. Pay as you go has no monthly fee. Basic includes 1,000 units for R$ 97 (`pro-paginas`).
  Professional includes 10,000 for R$ 797 (`profissional-paginas`).
  Enterprise includes 100,000 for R$ 5,997 (`empresarial-paginas`).
  Each paid plan includes requirements, deadlines, obligations, company-document comparison and processed reading.
  Card subscriptions renew monthly only after explicit consent. Pix, USDC and balance purchases last 30 days without renewal. Unused units expire
  at the end of the period. Each document can have up to 200 pages. Original PDFs remain free.
- The allowance uses 1 unit per page, 25 per price report, 5 per alert and 3 per tender watch.
  The first alert and watch remain free. Human services and API access packages are separate.
  `GET /api/plans` returns `account.active.usage` with total, used and remaining units.
  A signed-in person opens a report with `POST /api/precos/detalhe` and CSRF protection.
  The server uses allowance before prepaid credit. Reopening the same report in the period uses no more units.
- `GET /api/pricing` and `generation_status` read the prices and the quote. They do not charge.
- The HTTP API also supports CNPJ and address lookup purchases without an account through x402 v1 or v2.
  The paying wallet owns the package. Its `mmw_…` credential comes from
  `/api/auth/wallet/agent/start` and `/api/auth/wallet/agent/token`.
  The MCP connection above never charges.
- A prepaid credit gives a `cred_…` token one time only. The same token works in EditalMD, Radar CNPJ and
  PontoFato.

## Examples

```bash
# Tenders for school uniforms in São Paulo state (free)
curl -s 'https://editalmd.com/api/busca?q=uniforme%20escolar&uf=SP'

# Purchase record with deadlines and documents (free)
curl -s https://editalmd.com/api/compra/28870493

# Winning price summary of a similar item (free)
curl -s 'https://editalmd.com/api/precos?q=papel%20A4'
```

## Limits

- Read [procurement news](https://editalmd.com/en/noticias/index.md).
  Use the [free feed](https://editalmd.com/en/noticias/feed.json). Cite the article date and original sources.


- The source is PNCP. A purchase in the data can be closed already: read `get_deadlines` before you act.
- The Markdown comes from the original files. Automatic review has quality indicators but does not certify
  that the text is identical to the original.
- Terms: https://editalmd.com/termos. Privacy: https://editalmd.com/privacidade.
  Contact: contato@editalmd.com.
