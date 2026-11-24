#!/usr/bin/env bash
# Verificación obligatoria antes de entregar (CLAUDE.md §7). Hace de CI.
source "$(dirname "$0")/_common.sh"

info "flutter pub get"
flutter pub get >/dev/null

info "Formato (dart format)"
dart format --output=none --set-exit-if-changed lib test

info "Análisis estático (flutter analyze)"
flutter analyze --fatal-infos --fatal-warnings

info "Pruebas (flutter test)"
flutter test --coverage --reporter=failures-only "$@"

info "OK: formato, análisis y pruebas en verde."
