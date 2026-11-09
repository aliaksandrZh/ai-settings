Проверил, что реально стоит на машине. Вот полный разбор.

Что установлено

Claude Code (CLI, native-сборка, не npm):
- ~/.local/bin/claude → симлинк на ~/.local/share/claude/versions/2.1.319
- ~/.local/share/claude/ — сами бинарники: версии 2.1.317, 2.1.318, 2.1.319 (~950 МБ) + ClaudeCode.app
- Команды claude uninstall в этой версии нет (в claude --help есть только claude install), поэтому удалять вручную

Настройки и данные:
- ~/.claude/ — всё: settings.json, CLAUDE.md, plugins/, skills/, agents/, commands/, memory/, projects/ (история всех сессий), history.jsonl, stats-cache.json, telemetry/, shell-snapshots/, file-history/, jobs/, backups/
- ~/.claude.json — 135 КБ, глобальный конфиг (MCP-серверы, флаги, список проектов)

Ключи (Keychain):
- Claude Code-credentials — с服务вис svce, аккаунт Claude Code-credentials

Служебное:
- ~/Applications/Claude Code URL Handler.app (com.anthropic.claude-code-url-handler) — обработчик claude:// ссылок, ставится вместе с CLI
- ~/Library/Caches/claude-cli-nodejs — кэш старой npm-установки
- ~/.zshrc:18 и :306 — export PATH=...:$HOME/.local/bin... (две строки PATH)

Отдельно — Claude Desktop (это другой продукт, не Claude Code):
- /Applications/Claude.app (com.anthropic.claudefordesktop)
- ~/Library/Logs/Claude, ~/Library/Caches/com.anthropic.claudefordesktop{,.ShipIt}

Команды удаления

1. Бинарники и симлинк
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude

2. Настройки и все данные
rm -rf ~/.claude
rm -f ~/.claude.json

3. Ключи из Keychain
security delete-generic-password -s "Claude Code-credentials"

4. URL handler и кэш npm-версии
rm -rf ~/Applications/"Claude Code URL Handler.app"
rm -rf ~/Library/Caches/claude-cli-nodejs

5. PATH в zshrc (две строки — export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin:$PATH на строке 18 и export PATH="$HOME/.local/bin:$PATH" на 306) — удалить вручную или оставить, если ~/.local/bin используется чем-то ещё.

6. Отдельно и по желанию — Desktop-приложение
rm -rf /Applications/Claude.app
rm -rf ~/Library/Logs/Claude
rm -rf ~/Library/Caches/com.anthropic.claudefordesktop*

Что останется (нужно решить самому)

В каждом git-репо лежат свои .claude/ (например ~/Programming/net-study/.claude, ~/Programming/rbac/.claude и ещё ~20 штук) — там локальные settings.local.json, разрешения на команды. Это часть репозиториев, а не приложения. Встроенная команда claude purge [path] удаляет данные проекта (транскрипты, tasks, file history и запись в ~/.claude.json) для конкретной папки.

Ещё: ~/.claude/ внутри ~/Programming/claude/ — это ваши собственные проекты с таким же именем, не данные приложения.