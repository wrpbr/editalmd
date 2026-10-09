# EditalMD — skill and MCP server for AI agents

<img src="assets/icon.png" alt="EditalMD" width="72" align="right">

EditalMD lets an AI agent work with Brazilian public procurement. The agent searches the tenders of the national
procurement portal (PNCP) by product, service and state, reads the deadlines and the winning prices, and reads the
tender document (edital) as Markdown with its qualification requirements and page evidence. It can also create
alerts for new tenders and watch a purchase for changes. This repository packages the EditalMD skill and the
connection to its remote MCP server for Claude Code, Codex, Cursor and other agents.

**Site:** https://editalmd.com · **MCP server:** `https://editalmd.com/mcp?checkout=site` · **Prices:** https://editalmd.com/pricing ·
**API docs:** https://editalmd.com/developers

## What your agent can do

- Search tenders by term and state, and keep only the ones with open proposals.
- Read a purchase: object, agency, estimated value, documents, the proposal deadline and the estimated last day to
  challenge the tender.
- See which activities (CNAE) usually win purchases like it, the winning prices of similar items, the valid
  price-registration minutes (atas) and the annual purchase plans of the agencies.
- Read a tender document as Markdown, with the qualification requirements, items, deadlines and obligations, each
  with its page.
- Create alerts for new tenders by terms, state or company CNPJ, and watch a purchase for a new document,
  suspension, new deadline or new value.

Try: *"Find open tenders for school uniforms in São Paulo state and give me the deadlines."* or
*"What do I need to prove to take part in this tender?"*

## Install

Claude Code, as a plugin with the skill and the MCP server:

```
/plugin marketplace add wrpbr/editalmd
/plugin install editalmd@editalmd
```

Any agent that reads Agent Skills (Claude Code, Codex, Cursor, OpenCode and others):

```bash
npx skills add wrpbr/editalmd
```

Only the MCP server (remote, Streamable HTTP, no key for search and records):

```bash
claude mcp add --transport http editalmd 'https://editalmd.com/mcp?checkout=site'   # Claude Code
codex mcp add editalmd --url 'https://editalmd.com/mcp?checkout=site'               # Codex
```

```json
{ "mcpServers": { "editalmd": { "url": "https://editalmd.com/mcp?checkout=site" } } }
```

The JSON above goes in `.cursor/mcp.json` for Cursor and in the MCP settings of most other clients. In Claude.ai and
Claude Desktop, open Settings → Connectors → Add custom connector and paste the server address.

## Price

The search, the purchase record, the deadlines, the suppliers, the price summary, the minutes and the purchase plans
are free and need no key. Five sample documents are free to read. The access to a tender document is paid per page,
by each buyer, and includes the Markdown, the qualification list and the dossier. The first alert and the first watch
are free. You buy plans and prepaid credit on the site, and plans do not renew automatically. The plugin never pays:
with `checkout=site`, the MCP server has no purchase tool and no payment argument. The agent shows the price and the
link, and after your purchase it uses your credit token. The current prices are at https://editalmd.com/pricing.

## What the plugin sends

The skill tells the agent to call the EditalMD API at editalmd.com. The MCP server also runs at editalmd.com. Your
queries (search terms, states, purchase and document numbers, alert terms and the webhook address that you choose)
go to editalmd.com over HTTPS. A credit token or an owner token goes only when you give one. The plugin runs no
local program and reads no local file.

## Data and limits

The source is the PNCP. A purchase in the data can be closed already, so read its deadlines before you act. The
challenge deadline is an estimate. The Markdown comes from the original files; the automatic review has quality
indicators but does not certify that the text is identical to the original.

## Em português

O EditalMD deixa o agente de IA trabalhar com licitações. Ele busca as compras públicas do PNCP por produto, serviço
e estado, mostra os prazos e os preços que ganham, e lê o edital em Markdown, com as exigências de habilitação e a
página de cada uma. Também cria alertas de licitação nova e vigia uma compra. Este repositório traz a skill e a
conexão com o servidor MCP remoto. Instale com os comandos acima. A busca, a ficha e os prazos são grátis e não pedem
chave. A compra é sempre no site, e o plugin nunca paga sozinho. Os preços estão em https://editalmd.com/pricing.

## Files

| File | What it is |
|---|---|
| `skills/editalmd/SKILL.md` | The skill: which tool answers which question, and the rules for paid documents, alerts and tokens |
| `.mcp.json` | The remote MCP server of the plugin |
| `.claude-plugin/plugin.json` | The plugin manifest |
| `.claude-plugin/marketplace.json` | Lets Claude Code add this repository as a plugin marketplace |
| `server.json` | The manifest in the official MCP registry (`com.editalmd/editalmd`) |
| `glama.json` | The maintainer for the Glama MCP directory |

## License and contact

The files in this repository are under the MIT-0 license. The EditalMD service and its data are not part of this
license: their use follows the [terms of use](https://editalmd.com/termos) and the
[privacy policy](https://editalmd.com/privacidade). For questions or problems, open an issue here or write to
contato@editalmd.com.
