#!/usr/bin/env bash
# Instala (opcional) el hook pre-push: ejecuta tool/check.sh antes de cada push
# y lo cancela si algo falla. Es local; no se versiona dentro de .git/.
#   tool/install_hooks.sh            instala
#   tool/install_hooks.sh --remove   quita el hook
source "$(dirname "$0")/_common.sh"

hook=".git/hooks/pre-push"
if [[ "${1:-}" == "--remove" ]]; then
  rm -f "$hook"; info "Hook pre-push eliminado."; exit 0
fi
cat > "$hook" <<'HOOK'
#!/usr/bin/env bash
# Instalado por tool/install_hooks.sh
exec "$(git rev-parse --show-toplevel)/tool/check.sh"
HOOK
chmod +x "$hook"
info "Hook pre-push instalado: tool/check.sh se ejecutará antes de cada push (SKIP con git push --no-verify)."
