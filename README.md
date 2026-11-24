# SGA Bojanini — App móvil

App Flutter (Android) para empleados de la Clínica Bojanini. Consume la API del SGA (`back/sga-bojanini`).
Reglas de desarrollo: [`CLAUDE.md`](CLAUDE.md).

## Requisitos
- Flutter 3.38.x / Dart 3.10.x, Android SDK con licencias aceptadas (`flutter doctor`).
- Backend local en Docker: `cd ../back/sga-bojanini && docker compose up -d` (API en `:8000`).
- Para builds release: keystore en `~/.android-keys/sga-bojanini/` (fuera del repo) o variable `SGA_KEY_PROPERTIES`.

## Servidores: producción de la clínica y local
El servidor real es la VM 103 (`192.168.81.93`, Docker, solo por VPN). Se accede por su **nombre**, no por la IP (el nginx enruta por dominio y por IP HTTPS responde otra aplicación):
`https://sga.ad.bojaniniexperts.co/api/v1`. Su certificado es **autofirmado**, por eso la app lo trae anclado (`assets/certs/sga_clinica.pem`, clave `TLS_PINNED_CERT`).

### Destinos (`env/*.json`)
| Destino | Flavor | Servidor inicial | Uso |
|---|---|---|---|
| `usb` | dev | `http://localhost:8000/api/v1` | Teléfono por USB (`adb reverse`) → backend local |
| `local` | dev | `http://10.0.2.2:8000/api/v1` | Emulador Android → backend local |
| `lan` | dev | tu IP LAN (copiar `env/lan.example.json` a `env/lan.json`) | Teléfono por Wi-Fi → backend local |
| `clinica` | dev | `https://sga.ad.bojaniniexperts.co/api/v1` | App de pruebas contra el servidor real (VPN activa) |
| `prod` | prod | `https://sga.ad.bojaniniexperts.co/api/v1` | App de producción: solo HTTPS, URL fija |

### Cambiar de servidor sin recompilar (solo flavor dev)
En **Perfil → Acerca de → Cambiar servidor** se elige entre los servidores del archivo de destino (`SERVER_PRESETS`: producción de la clínica, local por USB y emulador) o se escribe otra dirección. Al cambiar se cierra la sesión (el token pertenece al servidor anterior). La pantalla de login muestra siempre el servidor activo para no operar sin querer sobre datos reales. "Usar el servidor original" vuelve al del archivo de destino.

Para agregar un servidor: editar `SERVER_PRESETS` (`Etiqueta|URL;Etiqueta|URL`) en `env/*.json`; nunca se escriben URLs en el código. El flavor `prod` no permite cambiarlo.

> Certificado: si el servidor renueva su certificado hay que actualizar `assets/certs/sga_clinica.pem` y publicar un APK nuevo (huella SHA-256 vigente: `74:C5:D9:C8:…:7D:57`, vence 02/08/2028). Lo recomendable a mediano plazo es que el servidor use un certificado con SAN emitido por una CA interna.

## Comandos
```bash
tool/run.sh usb            # ejecutar en teléfono por USB contra el backend local
tool/run.sh local          # ejecutar en emulador
tool/run.sh clinica        # dev contra el servidor real de la clínica (VPN activa)
tool/check.sh              # formato + análisis + pruebas (obligatorio antes de entregar)
tool/build_apk.sh prod     # APK de producción firmado + version.json en dist/
tool/build_apk.sh lan      # APK dev para teléfonos de prueba (cambio de servidor en Acerca de)
tool/build_apk.sh clinica  # APK dev apuntando al servidor real
```
Regenerar marca provisional: `dart run flutter_launcher_icons` y `dart run flutter_native_splash:create`.
