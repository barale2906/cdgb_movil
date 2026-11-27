#!/usr/bin/env bash
# Copia el keystore de firma y su key.properties a otra ubicación (p. ej. una
# memoria USB cifrada o un disco externo) y verifica que la copia es idéntica.
# Si el keystore se pierde, ningún teléfono podrá actualizar la app (plan 06 §5).
#   tool/backup_keystore.sh /ruta/de/destino
# No imprime secretos: solo nombres y huellas SHA-256.
source "$(dirname "$0")/_common.sh"

dest="${1:?Uso: tool/backup_keystore.sh <carpeta-de-destino>}"
src_dir="${SGA_KEY_DIR:-$HOME/.android-keys/sga-bojanini}"
[[ -f "$src_dir/key.properties" ]] || die "No se encontró $src_dir/key.properties"

real_src="$(realpath "$src_dir")"; mkdir -p "$dest"; real_dest="$(realpath "$dest")"
[[ "$real_dest" != "$real_src" && "$real_dest" != "$real_src"/* ]] \
  || die "El destino no puede estar dentro de la carpeta original (no sería una copia aparte)."
[[ "$real_dest" != "$PROJECT_ROOT"* ]] \
  || die "El destino no puede estar dentro del repositorio: el keystore nunca se versiona."

shopt -s nullglob
files=("$src_dir"/key.properties "$src_dir"/*.jks "$src_dir"/*.keystore)
for f in "${files[@]}"; do
  cp -p "$f" "$dest/"; chmod 600 "$dest/$(basename "$f")"
  a="$(sha256sum "$f" | awk '{print $1}')"; b="$(sha256sum "$dest/$(basename "$f")" | awk '{print $1}')"
  [[ "$a" == "$b" ]] || die "La copia de $(basename "$f") no coincide con el original."
  echo "  ok  $(basename "$f")  sha256:${a:0:16}…"
done
info "Respaldo verificado en $dest. Guarde otra copia en un segundo lugar seguro."
