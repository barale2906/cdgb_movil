# SGA Bojanini — App móvil

App Flutter (Android) para empleados de la Clínica Bojanini. Consume la API del SGA (`back/sga-bojanini`).
Reglas de desarrollo: [`CLAUDE.md`](CLAUDE.md).

## Requisitos
- Flutter 3.38.x / Dart 3.10.x, Android SDK con licencias aceptadas (`flutter doctor`).
- Backend local en Docker: `cd ../back/sga-bojanini && docker compose up -d` (API en `:8000`).
- Para builds release: keystore en `~/.android-keys/sga-bojanini/` (fuera del repo) o variable `SGA_KEY_PROPERTIES`.

## Destinos (`env/*.json`)
| Destino | Flavor | Servidor |
|---|---|---|
| `local` | dev | Emulador → `http://10.0.2.2:8000/api/v1` |
| `usb` | dev | Teléfono por USB (`adb reverse`) → `http://localhost:8000/api/v1` |
| `lan` | dev | Teléfono por Wi-Fi → copiar `env/lan.example.json` a `env/lan.json` y poner la IP LAN |
| `prod` | prod | Servidor de la clínica (HTTPS, por VPN) |

Cambiar de servidor = usar otro archivo; nunca se escriben URLs en el código.

## Comandos
```bash
tool/run.sh usb            # ejecutar en teléfono por USB contra el backend local
tool/run.sh local          # ejecutar en emulador
tool/check.sh              # formato + análisis + pruebas (obligatorio antes de entregar)
tool/build_apk.sh prod     # APK de producción firmado + version.json en dist/
tool/build_apk.sh lan      # APK dev para teléfonos de prueba
```
Regenerar marca provisional: `dart run flutter_launcher_icons` y `dart run flutter_native_splash:create`.
