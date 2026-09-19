import xml.etree.ElementTree as ET
import json

with open('/var/ossec/etc/rules/local_rules.xml', 'r') as f:
    contenu_original = f.read()

contenu_enveloppe = f"<root>{contenu_original}</root>"
ROOT = ET.fromstring(contenu_enveloppe)

techniques_detectees = set()

for rule in ROOT.iter('rule'):
    mitre_element = rule.find('mitre/id')
    if mitre_element is not None:
        techniques_detectees.add(mitre_element.text)

# Cas particulier : T1055, indetectable par une regle Wazuh
# (neutralisee nativement par Windows Defender avant execution)
technique_neutralisee_av = "T1055"

liste_techniques_layer = []

for technique_id in techniques_detectees:
    liste_techniques_layer.append({
        "techniqueID": technique_id,
        "color": "#4caf50",
        "comment": "Detectee via regle Wazuh personnalisee",
        "enabled": True
    })

liste_techniques_layer.append({
    "techniqueID": technique_neutralisee_av,
    "color": "#ff5722",
    "comment": "Neutralisee nativement par Windows Defender avant execution, jamais atteinte par Wazuh",
    "enabled": True
})

layer = {
    "name": "Mini-SOC as Code - Couverture MITRE ATT&CK",
    "versions": {
        "attack": "19",
        "navigator": "5.3.2",
        "layer": "4.5"
    },
    "domain": "enterprise-attack",
    "description": "Couverture de detection obtenue dans le cadre du projet Mini-SOC as Code",
    "legendItems": [
        {"label": "Detectee via regle Wazuh personnalisee", "color": "#4caf50"},
        {"label": "Neutralisee nativement par Windows Defender (jamais atteinte par Wazuh)", "color": "#ff5722"}
    ],
    "techniques": liste_techniques_layer
}

with open('mini-soc-coverage-layer.json', 'w') as f:
    json.dump(layer, f, indent=2)

print(f"Layer genere avec {len(liste_techniques_layer)} techniques.")
print("Fichier : mini-soc-coverage-layer.json")
