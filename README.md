# 🚀 Configuração do VS Code para Desenvolvedor Full Stack (Linux Mint)

Este script instala e configura o Visual Studio Code com extensões e ajustes ideais para desenvolvimento Full Stack (HTML, CSS, JavaScript, Python, PHP, Banco de Dados, Docker etc.).

---

## 🧰 Requisitos

- Linux Mint (ou qualquer distro baseada em Debian/Ubuntu)
- Conexão com a internet
- Terminal com permissões `sudo`

---

## 📦 Extensões que serão instaladas

- **Frontend**: Live Server, Tailwind, Prettier, ESLint, Auto Rename Tag
- **Backend**: Python, PHP, Node.js, REST Client
- **Banco de dados**: SQLTools, SQLite, PostgreSQL
- **Git e DevOps**: GitLens, Docker, Remote SSH/WSL/Containers
- **Produtividade**: Error Lens, Bracket Pair, Material Icons
- **Temas**: Dracula, Material, GitHub

---

## 📜 Script de Instalação

Crie um arquivo chamado `setup-vscode.sh`:

```bash
#nano setup-vscode.sh
`chmod +x setup-vscode.sh
./setup-vscode.sh

# Antes e depois da otimização
time python3 -c "print('Performance Test')"
htop
systemd-analyze startup


