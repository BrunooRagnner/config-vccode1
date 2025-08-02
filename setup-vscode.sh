# setup-dev.ps1

Write-Host "🛠️  CONFIGURANDO AMBIENTE DE DESENVOLVIMENTO NO WINDOWS..." -ForegroundColor Cyan

# 1. CRIAR PASTAS DE PROJETOS
$devFolder = "$HOME\Projetos"
if (-not (Test-Path $devFolder)) {
    New-Item -ItemType Directory -Path $devFolder
    Write-Host "📁 Pasta de projetos criada em: $devFolder"
}

# 2. INSTALAR CHOCOLATEY (gerenciador de pacotes)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "✅ Chocolatey já está instalado."
}

# 3. INSTALAR PROGRAMAS ESSENCIAIS
$apps = @(
    "git",
    "python",
    "nodejs",
    "jdk11",
    "vscode",
    "windows-terminal",
    "7zip",
    "neofetch"
)

foreach ($app in $apps) {
    Write-Host "📦 Instalando: $app"
    choco install $app -y --ignore-checksums
}

# 4. EXTENSÕES VS CODE
Write-Host "🔧 Instalando extensões do VS Code..."
$extensions = @(
    "ms-python.python",
    "ms-toolsai.jupyter",
    "esbenp.prettier-vscode",
    "ritwickdey.LiveServer",
    "dbaeumer.vscode-eslint"
)

foreach ($ext in $extensions) {
    code --install-extension $ext
}

# 5. CONFIGURAÇÃO DO VS CODE
Write-Host "📝 Aplicando configurações no VS Code..."
$vsSettingsPath = "$env:APPDATA\Code\User\settings.json"

@"
{
    "workbench.startupEditor": "none",
    "editor.fontSize": 14,
    "editor.minimap.enabled": false,
    "files.autoSave": "afterDelay",
    "telemetry.telemetryLevel": "off",
    "update.mode": "manual",
    "extensions.autoUpdate": false,
    "python.analysis.typeCheckingMode": "off"
}
"@ | Set-Content -Path $vsSettingsPath -Encoding utf8

# 6. CONFIGURAÇÃO DE TERMINAL PERSONALIZADO (ZSH não funciona nativamente no Windows, mas...)
Write-Host "💻 Terminal moderno instalado (Windows Terminal)"

Write-Host "`n🎉 AMBIENTE CONFIGURADO COM SUCESSO!"
Write-Host "📌 VS Code: digite 'code .' na pasta do projeto"
Write-Host "📌 Git: digite 'git config --global user.name \"Seu Nome\"' para configurar"
