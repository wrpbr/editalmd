# EditalMD

> Editais do PNCP em markdown com procedência, prazos no relógio, alertas e vigias — para gente e para agentes.

**In English.** EditalMD reads Brazil's national public procurement portal (PNCP: 2.6 million purchases, 521 thousand documents) and returns each tender as markdown with a provenance front-matter (source URL, SHA-256, extraction date), the proposal and challenge deadlines computed, the qualification requirements extracted with the literal excerpt, alerts for new purchases by term or CNAE and change watches. Search, records and documents published 30+ days ago are free, no account; responses in Portuguese; remote MCP server.

**No ar:** https://editalmd.com · **Índice da API:** https://editalmd.com/api/ · **OpenAPI:** https://editalmd.com/openapi.json · **Servidor MCP:** https://editalmd.com/mcp · **Docs para agentes:** https://editalmd.com/llms.txt

## O que faz

O EditalMD transforma o edital do PNCP no formato que gente e agente leem: markdown com procedência.

O que faz: busca por termo, UF e modalidade; a ficha da compra com os prazos de proposta e impugnação no relógio (art. 164 da Lei 14.133); o documento em markdown com front-matter (URL de origem, hash, data, páginas, extrator); a lista de habilitação por família (jurídica, fiscal, econômico-financeira, técnica) com o trecho literal e um recibo verificável; alertas de compra nova por termos ou pelo CNAE da empresa a cada 30 minutos; vigias que avisam quando uma compra muda, a cada hora — por e-mail ou webhook.

## Começo rápido (sem cadastro)

Busca de compras por termo e UF (sempre grátis):

```bash
curl -s 'https://editalmd.com/api/busca?q=merenda%20escolar&uf=GO'
```

Lista de CNAE como o alerta por CNPJ a lê:

```bash
curl -s https://editalmd.com/api/cnaes
```

Índice auto-descrito, com regime de cobrança e preços:

```bash
curl -s https://editalmd.com/api/
```

## Servidor MCP (remoto, sem instalar nada)

Streamable HTTP sobre a mesma API pública. Cada tool é uma chamada nesta API; o `operationId` do OpenAPI é o nome da tool. Cartão do servidor: `GET https://editalmd.com/mcp`.

Claude Code:

```bash
claude mcp add --transport http editalmd https://editalmd.com/mcp
```

Cursor (`.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "editalmd": {
      "url": "https://editalmd.com/mcp"
    }
  }
}
```

Tools principais: `get_api_busca`, `get_api_compra_by_id`, `get_api_documento_by_id_markdown`, `post_api_documento_by_id_habilitacao`, `get_api_cnaes`, `post_api_alertas`, `post_api_vigias`, `get_api_recibo_by_id`.

## Preço

**Grátis.** Busca, ficha com prazos, documento de compra publicada há 30 dias ou mais, o primeiro alerta e a primeira vigia, sem cadastro.

**Pago.** Por requisição (x402) ou crédito pré-pago: documento recente US$ 0,01; alerta a mais US$ 0,10 por 30 dias; vigia a mais US$ 0,05; lista de habilitação de documento recente US$ 0,05.

## O que não é

Não é o PNCP (é uma leitura dele, com a procedência escrita em cada arquivo) e não substitui a leitura jurídica do edital.

## Arquivos deste repositório

| | |
|---|---|
| `README.md` | esta página |
| `openapi.json` | documento OpenAPI 3; `operationId` = nome da tool MCP |
| `llms.txt` | guia curto para agentes (rotas, auth, preço, MCP) |
| `llms-full.txt` | referência completa: parâmetros, corpo, resposta campo a campo, erros (quando publicada) |
| `apis.json` | índice APIs.json (APIs.io) |
| `mcp/server.json` | manifesto publicado no registro oficial de MCP (`com.editalmd/editalmd`) |
| `okf/` | bundle OKF: markdown com front-matter (índice, sobre, API, FAQ) |
| `examples/` | `curl.sh` e `python.py` com as chamadas grátis acima |

## Sobre este repositório

Este repositório espelha as superfícies públicas e legíveis por máquina do EditalMD, como servidas em https://editalmd.com: o documento OpenAPI, o guia `llms.txt`, o manifesto do registro MCP, o bundle OKF e o índice APIs.json. O produto em si não é código aberto; o espelho existe para a API e o servidor MCP poderem ser encontrados, lidos e linkados daqui. Os arquivos são regenerados das superfícies no ar (última sincronização: 2026-09-05); se algo aqui divergir do site, vale o site.

Issues e sugestões são bem-vindas aqui. Contato: contato@editalmd.com. Autor: Wendel ([@wrpbr](https://github.com/wrpbr)).
