#!/usr/bin/env bash
# Compila un APK release para un destino y lo deja listo en dist/.
#   tool/build_apk.sh prod   APK de producción firmado + version.json + sha256
#   tool/build_apk.sh lan    APK dev (pruebas en teléfonos por Wi-Fi)
# Requiere el keystore fuera del repo: ~/.android-keys/sga-bojanini/key.properties
# (o la variable SGA_KEY_PROPERTIES). Ver docs/plan/05-calidad-y-despliegue.md §5.
source "$(dirname "$0")/_common.sh"

target="${1:?Uso: tool/build_apk.sh <destino>}"
file="$(env_file_for "$target")"
flavor="$(flavor_for "$file")"

key_props="${SGA_KEY_PROPERTIES:-$HOME/.android-keys/sga-bojanini/key.properties}"
[[ -f "$key_props" ]] || die "No se encontró $key_props: sin keystore no se genera un APK distribuible."

version_line="$(grep -E '^version:' pubspec.yaml | awk '{print $2}')"
version="${version_line%%+*}"
build="${version_line##*+}"

"$(dirname "$0")/check.sh"

info "Compilando APK $flavor $version+$build ($file)"
flutter build apk --release \
  --flavor "$flavor" \
  --dart-define-from-file="$file" \
  --obfuscate --split-debug-info="build/symbols/$flavor-$version+$build"

suffix=""; [[ "$flavor" == "prod" ]] || suffix="-$target"
out_dir="dist/$version+$build$suffix"
apk_name="sga-bojanini-$version$suffix.apk"
mkdir -p "$out_dir"
cp "build/app/outputs/flutter-apk/app-$flavor-release.apk" "$out_dir/$apk_name"
cp -r "build/symbols/$flavor-$version+$build" "$out_dir/symbols"
sha="$(sha256sum "$out_dir/$apk_name" | awk '{print $1}')"

# UPDATE_BASE: carpeta pública donde se publicará el APK (decisión D pendiente).
update_base="${UPDATE_BASE:-}"
cat > "$out_dir/version.json" <<JSON
{
  "latest": "$version",
  "build": $build,
  "min_build": ${MIN_BUILD:-$build},
  "url": "${update_base:+$update_base/}$apk_name",
  "sha256": "$sha",
  "notes": "${NOTES:-}"
}
JSON

info "Listo: $out_dir"
ls -l "$out_dir"
