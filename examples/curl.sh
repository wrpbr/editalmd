#!/usr/bin/env bash
# EditalMD — free calls, no account. Chamadas grátis, sem cadastro.
set -euo pipefail

# Busca de compras por termo e UF (sempre grátis)
curl -s 'https://editalmd.com/api/busca?q=merenda%20escolar&uf=GO'

# Lista de CNAE como o alerta por CNPJ a lê
curl -s https://editalmd.com/api/cnaes

# Índice auto-descrito, com regime de cobrança e preços
curl -s https://editalmd.com/api/
