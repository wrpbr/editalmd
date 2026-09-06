---
type: "Dataset"
title: "Acervo PNCP extraído"
description: "Compras públicas do PNCP com o texto dos documentos já extraído e normalizado, servido em markdown com procedência e hash."
resource: "https://editalmd.com/api/health"
license: "Dados públicos do PNCP (pncp.gov.br)"
source: "https://pncp.gov.br/"
---

# Acervo

Compras e documentos do PNCP — dado público — com o texto extraído e normalizado. Cada
documento sai com front-matter de procedência (número PNCP, órgão, unidade, UF, modalidade,
valor, data, páginas, motor de extração) e o SHA-256 do conteúdo entregue.

Números ao vivo: https://editalmd.com/api/health

Limite honesto: o acervo servível é o que já foi extraído; documento sem texto responde 409
e **não é cobrado**.
