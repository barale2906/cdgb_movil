#!/usr/bin/env bash
# Pruebas de integración contra el backend local (Docker) en un emulador o teléfono.
#   tool/integration.sh [destino] [archivo]     p. ej. tool/integration.sh local integration_test/smoke_test.dart
# Destino por defecto: local (emulador). Requiere integration_test/test_user.local.json
# (usuario de pruebas del backend local; ignorado por git).
source "$(dirname "$0")/_common.sh"

target="${1:-local}"; shift || true
file="$(env_file_for "$target")"
flavor="$(flavor_for "$file")"
[[ "$flavor" == "dev" ]] || die "Las pruebas de integración solo corren con destinos dev (no $target)."
creds="integration_test/test_user.local.json"
[[ -f "$creds" ]] || die "Falta $creds con TEST_EMAIL y TEST_PASSWORD del usuario de pruebas."

adb="$(adb_bin)"
if [[ "$target" == "usb" ]]; then "$adb" reverse tcp:8000 tcp:8000; fi
# Empieza sin sesión: borra los datos de la app de pruebas del dispositivo.
"$adb" shell pm clear co.bojanini.sga.dev >/dev/null 2>&1 || true

tests=("${@:-integration_test}")
info "flutter test ${tests[*]} --flavor $flavor ($file)"
# Usuarios por rol (opcional): integration_test/test_users_flat.local.json
roles="integration_test/test_users_flat.local.json"
extra=(); [[ -f "$roles" ]] && extra=(--dart-define-from-file="$roles")
exec flutter test "${tests[@]}" --flavor "$flavor" \
  --dart-define-from-file="$file" --dart-define-from-file="$creds" "${extra[@]}"
