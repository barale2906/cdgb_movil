#!/usr/bin/env bash
# Utilidades compartidas por los scripts de tool/. No ejecutar directamente.
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

die() { echo "ERROR: $*" >&2; exit 1; }
info() { echo "==> $*"; }

# Destino (env/<destino>.json) -> ruta del archivo, validando que exista.
env_file_for() {
  local target="$1"
  local file="env/${target}.json"
  if [[ ! -f "$file" ]]; then
    if [[ "$target" == "lan" ]]; then
      die "Falta env/lan.json. Cópielo de env/lan.example.json y ponga la IP LAN de su equipo."
    fi
    die "No existe $file. Destinos disponibles: $(ls env/*.json | xargs -n1 basename | sed 's/\.json$//' | grep -v example | tr '\n' ' ')"
  fi
  echo "$file"
}

# Flavor según el ENV declarado en el archivo de destino.
flavor_for() {
  local file="$1"
  local env
  env="$(grep -oE '"ENV"[[:space:]]*:[[:space:]]*"[a-z]+"' "$file" | grep -oE '"[a-z]+"$' | tr -d '"')"
  [[ "$env" == "dev" || "$env" == "prod" ]] || die "ENV inválido en $file"
  echo "$env"
}

adb_bin() {
  if command -v adb >/dev/null 2>&1; then
    echo adb
  elif [[ -x "${ANDROID_HOME:-$HOME/Android/Sdk}/platform-tools/adb" ]]; then
    echo "${ANDROID_HOME:-$HOME/Android/Sdk}/platform-tools/adb"
  else
    die "No se encontró adb (Android SDK platform-tools)."
  fi
}
