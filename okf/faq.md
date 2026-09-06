---
type: "FAQ"
title: "FAQ — EditalMD"
description: "Perguntas e respostas sobre o EditalMD, as mesmas publicadas na página."
resource: "https://editalmd.com/"
---

# Perguntas frequentes — EditalMD

## O que vem no markdown do edital?

O texto extraído do documento publicado no PNCP, com front-matter de procedência: número PNCP, órgão, unidade, UF, modalidade, valor estimado, data de publicação, páginas, motor de extração e o SHA-256 do conteúdo.

## Quando é grátis e quando cobra?

Buscar, abrir a ficha da compra e ver os prazos é sempre grátis. O documento de uma compra publicada há 30 dias ou mais sai completo, de graça. Só a publicação com menos de 30 dias custa US$ 0,01 por requisição. O primeiro alerta e a primeira vigia são grátis; os seguintes custam US$ 0,10 por alerta (30 dias) e US$ 0,05 por vigia. A lista de habilitação custa US$ 0,05 por documento recente.

## Como funcionam os alertas e as vigias?

Um token de dono, criado sem cadastro, abre alertas e vigias. O alerta procura compras novas por termos do objeto e UF a cada 30 minutos e avisa por webhook assinado, por e-mail confirmado ou só na API. A vigia fotografa uma compra e registra o que mudou: situação, prazo adiado, valor, documento novo ou removido, além dos avisos de prazo.

## Como funciona o alerta pelo CNPJ?

Informe o CNPJ e o produto consulta as atividades (CNAE) da empresa na base da Receita. Cada CNAE que está no dicionário vira uma família de termos do objeto, e sai um alerta por família, a atividade principal primeiro. O dicionário começa pelos CNAEs com mais fornecedores ativos no SICAF e cada família teve a cobertura medida no acervo; a lista oficial de CNAE (IBGE) e a contagem de fornecedores são atualizadas todo dia. CNAE fora do dicionário não vira alerta e é apontado na resposta, para você criar por termos.

## O que é a lista de habilitação?

É a lista de exigências do edital, extraída por modelo de linguagem e ancorada no texto: cada item traz o trecho literal de onde saiu, por família (jurídica, fiscal, econômico-financeira, técnica). Grátis com 30 dias ou mais, US$ 0,05 em documento recente, e sai do cache sem cobrar quando o texto é o mesmo.

## Por que o prazo de impugnação é estimado?

Porque o PNCP publica a data da sessão, não a da impugnação. O art. 164 da Lei 14.133/2021 dá três dias úteis antes da sessão para impugnar; o EditalMD conta esses dias com os feriados nacionais e marca o prazo como estimado. Feriado estadual ou municipal pode mudar o dia — confira no edital.

## O acervo cobre todas as compras?

Cobre o que está publicado no PNCP: 2,6 milhões de compras em setembro de 2026, com 521 mil documentos já extraídos. O documento de uma compra é baixado e extraído na primeira vez que alguém pede; se o PNCP ainda não tem o arquivo, a resposta diz isso e não cobra. Os números do acervo estão em /api/health.

## Preciso criar conta?

Não. O pagamento é por requisição via x402 (HTTP 402), ou por crédito pré-pago: você põe saldo uma vez e apresenta o token no cabeçalho. Documento inexistente ou sem texto disponível não é cobrado.
