# Changelog

Formato: [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). Versionado: `x.y.z+build`.

## [0.2.0+2] - 2026-11-24
### Añadido
- Fase 1 · Fundaciones: acceso con correo y contraseña, restauración de sesión y cierre seguro (token en almacenamiento cifrado).
- Teléfonos compartidos: bloqueo por inactividad (15 min o segundo plano), "Cambiar de usuario" y cierre automático del turno (12 h). Sin biometría.
- Menú y permisos: Inicio, barra inferior (máx. 5 destinos) y "Más" según el menú del servidor **y** los permisos del usuario; secciones futuras muestran "Próximamente".
- Perfil, cambio de contraseña, selector de almacén activo y "Acerca de" (versión, ambiente; en dev, cambio de servidor).
- Manejo uniforme de errores (401/403/409/422/429/red) con aviso de VPN en producción; aviso "sin conexión".
- Aviso de actualización por `version.json` (inactivo mientras `UPDATE_URL` esté vacío).
- Componentes base (`BojaniButton`, campos, chips, estados vacío/error/carga, avisos, diálogos) con pruebas y goldens.

### Notas
- `device_name` del token usa un identificador de instalación; el modelo del teléfono requiere aprobar `device_info_plus`.
- Mi firma y PIN llegan en la Fase 2 (plan maestro).

## [0.1.0+1] - 2026-11-24
### Añadido
- Fase 0: proyecto Flutter Android (`co.bojanini.sga`), flavors `dev`/`prod`, destinos `env/*.json`.
- Scripts `tool/run.sh`, `tool/check.sh`, `tool/build_apk.sh`; firma release desde keystore externo.
- Tokens de diseño, tema Material 3 con Montserrat, colores de estado (AA), marca provisional, icono y splash.
- Pantalla "Acerca de" con ambiente y servidor activos.
