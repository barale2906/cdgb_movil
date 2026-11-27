#!/usr/bin/env bash
# Verificación obligatoria antes de entregar (CLAUDE.md §7). Hace de CI.
source "$(dirname "$0")/_common.sh"

info "flutter pub get"
flutter pub get >/dev/null

if [[ "${SKIP_GENERATED:-0}" != "1" ]]; then
  info "Código generado al día (build_runner)"
  generated_hash() { find lib -name '*.g.dart' -o -name '*.freezed.dart' | sort | xargs cat | sha256sum; }
  before="$(generated_hash)"
  dart run build_runner build --delete-conflicting-outputs >/dev/null
  [[ "$before" == "$(generated_hash)" ]] \
    || die "El código generado estaba desactualizado (ya se regeneró). Revise los cambios y ejecute de nuevo. SKIP_GENERATED=1 omite este paso."
fi

info "Formato (dart format)"
dart format --output=none --set-exit-if-changed lib test

info "Análisis estático (flutter analyze)"
flutter analyze --fatal-infos --fatal-warnings

info "Pruebas (flutter test)"
flutter test --coverage --reporter=failures-only "$@"

info "OK: formato, análisis y pruebas en verde."
