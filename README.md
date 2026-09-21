# Mini-SOC as Code

Projet de portfolio cybersécurité : SIEM Wazuh avec détection personnalisée,
simulations d'attaques MITRE ATT&CK (Atomic Red Team), et génération
automatisée de rapports d'incidents.

## Architecture actuelle

- **Manager Wazuh** (`mini-soc-lab`, Oracle Cloud, Ubuntu 24.04 ARM64) :
  indexer, manager, dashboard, en installation single-node
- **Agent Linux** (`mini-soc`, Ubuntu) : détection via auditd
- **Agent Windows** (`pc-windows-wilfried`) : détection via journaux
  d'événements natifs et Sysmon
- 10 techniques MITRE ATT&CK couvertes, dont 1 neutralisée nativement
  par Windows Defender (documentée séparément)

## Structure du dépôt

- `wazuh-rules/` : règles de détection personnalisées (copie versionnée
  de local_rules.xml, à resynchroniser manuellement après modification)
- `scripts/` : scripts d'automatisation (export MITRE ATT&CK Navigator, etc.)
- `docs/` : documentation complémentaire

## Prérequis pour reproduire l'environnement

- Instance Oracle Cloud (ou équivalent), Ubuntu 24.04+
- Wazuh 4.14+ (installation via script officiel)
- Python 3.12+ pour les scripts d'automatisation
- Atomic Red Team (PowerShell Core sur Linux, PowerShell natif sur Windows)

## Roadmap / perspectives assumées

Choix de priorisation documentés dans le cahier des charges du projet :

- [ ] Infrastructure as Code (Terraform), actuellement provisionnée manuellement
- [ ] Générateur automatique de rapports d'incidents (application Django),
      en cours de conception
- [ ] Conteneurisation de l'application via Docker
- [ ] Pipeline CI/CD (GitLab) pour le déploiement automatisé
- [ ] Haute disponibilité du cluster Wazuh (perspective long terme,
      hors scope du sprint actuel)
