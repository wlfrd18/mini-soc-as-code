#!/bin/bash
# Installation des regles auditd personnalisees pour le projet Mini-SOC as Code
# A executer sur l'agent Linux, avec sudo

set -e

RULES_FILE="/etc/audit/rules.d/mini-soc-custom.rules"

echo "Installation des regles auditd personnalisees..."

cat > "$RULES_FILE" << 'RULES'
# T1087.001 - Account Discovery
-w /etc/passwd -p r -k passwd_acces

# T1059.004 - Unix Shell
-a always,exit -F arch=b64 -S execve -F path=/bin/bash -F key=bash_exec

# T1082 - System Information Discovery
-w /usr/lib/os-release -p r -k os_discovery

# T1547.006 - Kernel Modules and Extensions
-a always,exit -F arch=b64 -S init_module -F key=kernel_module_load
-a always,exit -F arch=b64 -S finit_module -F key=kernel_module_load

# T1036.003 - Masquerading
-a always,exit -F arch=b64 -S execve -F dir=/tmp -F key=masquerade_tmp_exec

# T1555.003 - Credentials from Web Browsers
-a always,exit -F arch=b64 -S execve -F path=/usr/bin/python3.10 -F key=credential_dump_tool

# T1497.001 - Virtualization/Sandbox Evasion
-a always,exit -F arch=b64 -S execve -F path=/usr/bin/systemd-detect-virt -F key=sandbox_evasion_check
-a always,exit -F arch=b64 -S execve -F path=/usr/sbin/dmidecode -F key=sandbox_evasion_check
RULES

augenrules --load
echo "Regles installees et chargees avec succes."
auditctl -l
