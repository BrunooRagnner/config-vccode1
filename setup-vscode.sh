#!/bin/bash

# 1. OTIMIZAÇÃO DO SISTEMA BASE
echo "🛠️  OTIMIZANDO O SISTEMA UBUNTU..."

# Limpeza de pacotes obsoletos
sudo apt autoremove -y
sudo apt clean
sudo journalctl --vacuum-time=3d

# Desativar serviços desnecessários
sudo systemctl disable bluetooth.service
sudo systemctl disable avahi-daemon.service

# 2. CONFIGURAÇÕES DE PERFORMANCE
echo "⚡ AJUSTES DE PERFORMANCE..."

# Swap mais eficiente
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf

# Otimizar montagem de discos (SSD/HD)
if [ $(lsblk -d -o rota | grep -c 0) -gt 0 ]; then
    echo "⚡ SSD DETECTADO - Otimizando..."
    sudo systemctl enable fstrim.timer
    sudo sed -i 's/noatime/noatime,discard/' /etc/fstab
fi

# 3. KERNEL E DRIVERS
echo "🖥️  OTIMIZANDO KERNEL..."

# Instalar kernel lowlatency (para desenvolvedores)
sudo apt install -y linux-image-lowlatency linux-headers-lowlatency

# Configurar GRUB para desligar mitigações (opcional para performance)
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mitigations=off"/g' /etc/default/grub
sudo update-grub

# 4. AMBIENTE DE DESENVOLVIMENTO TURBO
echo "💻 CONFIGURAÇÃO DEVS TURBO..."

# Instalar ferramentas essenciais
sudo apt install -y \
    build-essential \
    git \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    default-jdk \
    zsh \
    neofetch \
    htop \
    ncdu

# 5. CONFIGURAÇÃO DO VS CODE ULTRA LEVE
if ! command -v code &> /dev/null; then
    echo "📟 INSTALANDO VS CODE OPTIMIZED..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y --no-install-recommends code
fi

# Configurações performance VS Code
cat <<EOF > ~/.config/Code/User/settings.json
{
    "workbench.startupEditor": "none",
    "editor.fontFamily": "'Ubuntu Mono', monospace",
    "editor.fontSize": 14,
    "editor.minimap.enabled": false,
    "files.autoSave": "afterDelay",
    "telemetry.telemetryLevel": "off",
    "update.mode": "manual",
    "extensions.autoUpdate": false,
    "python.languageServer": "Pylance",
    "python.analysis.typeCheckingMode": "off"
}
EOF

# 6. LIMPEZA E OTIMIZAÇÃO FINAL
echo "🧹 LIMPEZA FINAL..."

# Limpar cache
sudo rm -rf /var/cache/*
sudo rm -rf ~/.cache/*

# Otimizar memória
sudo apt install -y preload
sudo systemctl start preload
sudo systemctl enable preload

# 7. CONFIGURAÇÃO DO TERMINAL PRO
echo "💻 TERMINAL PRO CONFIG..."

# ZSH com Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/' ~/.zshrc
echo "plugins=(git python docker ubuntu)" >> ~/.zshrc

# Aliases úteis
cat <<EOF >> ~/.zshrc
# ALIASES DE PERFORMANCE
alias update='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt autoremove -y && sudo apt clean'
alias perf='htop'
alias diskspace='ncdu'
alias sysinfo='neofetch'
EOF

echo "🎉 OTIMIZAÇÃO COMPLETA! Reinicie o sistema."
echo "💡 Dicas:"
echo "- Use 'perf' para monitorar sistema"
echo "- 'clean' para limpeza rápida"
echo "- 'sysinfo' para ver informações"
