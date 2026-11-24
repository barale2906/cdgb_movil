#!/usr/bin/env bash
# Ejecuta la app contra un destino.
#   tool/run.sh usb     teléfono por USB (adb reverse al backend local :8000)
#   tool/run.sh local   emulador Android
#   tool/run.sh lan     teléfono por Wi-Fi (requiere env/lan.json)
#   tool/run.sh clinica app dev contra el servidor real de la clínica (VPN activa)
#   tool/run.sh prod    flavor prod (HTTPS, URL fija) — modo release no recomendado aquí
# Argumentos extra se pasan a `flutter run` (p. ej. -d <dispositivo>).
source "$(dirname "$0")/_common.sh"

target="${1:-usb}"; shift || true
file="$(env_file_for "$target")"
flavor="$(flavor_for "$file")"

if [[ "$target" == "usb" ]]; then
  info "adb reverse tcp:8000 -> backend local"
  "$(adb_bin)" reverse tcp:8000 tcp:8000
fi

info "flutter run --flavor $flavor ($file)"
exec flutter run --flavor "$flavor" --dart-define-from-file="$file" "$@"
