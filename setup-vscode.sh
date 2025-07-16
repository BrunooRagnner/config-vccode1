#!/bin/bash

echo "🚀 Iniciando configuração do VS Code para desenvolvedor Full Stack..."

# 1. Atualiza o sistema
sudo apt update && sudo apt upgrade -y

# 2. Instala o VS Code (se ainda não tiver)
if ! command -v code &> /dev/null; then
    echo "🧩 Instalando VS Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install code -y
fi

# 3. Instala extensões essenciais
echo "🔌 Instalando extensões VS Code..."
EXTENSIONS=(
  ritwickdey.LiveServer
  esbenp.prettier-vscode
  dbaeumer.vscode-eslint
  bradlc.vscode-tailwindcss
  pranaygp.vscode-css-peek
  Zignd.html-css-class-completion
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  ecmel.vscode-html-css
  mgmcdermott.vscode-language-babel
  xabikos.JavaScriptSnippets
  ms-vscode.vscode-typescript-next
  ms-python.python
  ms-python.vscode-pylance
  bmewburn.vscode-intelephense-client
  vscjava.vscode-java-pack
  humao.rest-client
  mtxr.sqltools
  alexcvzz.vscode-sqlite
  ms-azuretools.vscode-cosmosdb
  mtxr.sqltools-driver-mysql
  mtxr.sqltools-driver-pg
  eamodio.gitlens
  github.vscode-pull-request-github
  donjayamanne.githistory
  ms-azuretools.vscode-docker
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-wsl
  formulahendry.terminal
  usernamehw.errorlens
  oderwat.indent-rainbow
  CoenraadS.bracket-pair-colorizer-2
  visualstudioexptteam.vscodeintellicode
  pkief.material-icon-theme
  vscode-icons-team.vscode-icons
  shd101wyy.markdown-preview-enhanced
  dracula-theme.theme-dracula
  zhuangtongfa.material-theme
  GitHub.github-vscode-theme
)

for extension in "${EXTENSIONS[@]}"; do
  code --install-extension $extension
done

# 4. Cria settings.json com configurações ideais
echo "⚙️ Aplicando configurações no settings.json..."
mkdir -p ~/.config/Code/User

cat << EOF > ~/.config/Code/User/settings.json
{
  "workbench.colorTheme": "Dracula",
  "workbench.iconTheme": "vscode-icons",
  "editor.fontSize": 14,
  "editor.fontFamily": "Fira Code, Consolas, 'Courier New', monospace",
  "editor.fontLigatures": true,
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  "eslint.alwaysShowStatus": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.fixAll.eslint": true
  },
  "prettier.singleQuote": true,
  "prettier.trailingComma": "es5",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.fontSize": 13,
  "python.languageServer": "Pylance",
  "python.formatting.provider": "black",
  "python.linting.enabled": true,
  "python.linting.flake8Enabled": true,
  "liveServer.settings.port": 5500,
  "liveServer.settings.donotShowInfoMsg": true,
  "git.autofetch": true,
  "git.confirmSync": false,
  "editor.suggestSelection": "first",
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  },
  "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue"
}
EOF

echo "✅ Configuração do VS Code concluída com sucesso!"
