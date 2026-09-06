import requests

r = requests.get("https://editalmd.com/api/busca", params={"q": "merenda escolar", "uf": "GO"}, timeout=30).json()
for c in r["itens"][:5]:
    print(c["pncp"], c["modalidade"], c["uf"], c["objeto"][:80])
