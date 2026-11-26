# Changelog

Formato: [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). Versionado: `x.y.z+build`.

## [0.7.0+7] - 2026-11-25
### Añadido
- Fase 4 · Compras: órdenes de compra (lista con filtro por estado, detalle, enviar a aprobación, aprobar/rechazar con comentarios, enviar al proveedor, cancelar) y recepción total o parcial con lote, vencimiento y ubicación.
- Fase 4 · Órdenes de gasto: lista con filtros de estado y de pago, flujo completo, recepción con cantidades decimales, factura, envío a contabilidad y pagos (registrar y eliminar, sin superar el saldo).
- Fase 4 · Sugerencias de reorden y consolidación de órdenes recibidas por proveedor (vista previa y creación), con lista y detalle de órdenes consolidadas.
- Tras un tiempo de espera en una acción, la app vuelve a consultar la orden y pide revisarla antes de repetir (no se duplican cambios).

### Cambiado
- Selector de ubicaciones, lectura de decimales y mensaje de error de escrituras movidos a `core/` para compartirlos con inventario.

### Pendiente
- Crear y editar órdenes en borrador desde el móvil (prioridad P2).
- El menú del servidor no incluye órdenes de gasto: hace falta un ajuste de backend para que la sección aparezca a quien solo tenga ese permiso.

## [0.6.0+6] - 2026-11-25
### Añadido
- Fase 3 · Inicio con tarjetas y gráficas de inventario, compras y monitoreo (cada bloque según permisos), actividad reciente, alertas y accesos rápidos (nuevo movimiento, escanear).
- Fase 3 · Notificaciones: centro con marcar leída/todas y contador en la barra superior con actualización cada 60 s.
- Fase 3 · Monitoreo: sensores asignados, detalle con lecturas, tendencia y estadísticas, registro de lectura manual, exportación a Excel, calibraciones con certificado y reglas de alerta (consulta).
- Fase 3 · Reportes: catálogo de 7 reportes con filtros, archivo directo o exportación en segundo plano, y lista de exportaciones con descarga/compartir; informe de condiciones desde el sensor.
- Componentes reutilizables: gráficas, campos de formulario, insignia de notificaciones, escaneo de producto y envío de archivos; fechas en hora de Colombia.

### Pendiente
- Notificaciones push (FCM): requieren aprobar el cambio de backend (`auth/devices`) y crear el proyecto Firebase.

## [0.5.0+5] - 2026-11-24
### Añadido
- Cambio sencillo de servidor (flavor dev): en Acerca de se elige entre producción de la clínica, local por USB o emulador (`SERVER_PRESETS` en `env/*.json`) o una dirección propia; el login muestra el servidor activo.
- Destino `clinica` (dev contra el servidor real) y `prod` apuntando a `https://sga.ad.bojaniniexperts.co/api/v1`.
- Certificado del servidor anclado (`TLS_PINNED_CERT`): el servidor de la clínica usa un certificado autofirmado que Android no reconoce.

### Cambiado
- `env/prod.json` ya no apunta a `bojapp.gislasas.com` (dominio del web público) sino al servidor de la clínica.

## [0.4.0+4] - 2026-11-24
### Añadido
- Fase 2B · Inventario: existencias del almacén activo (con filtro "Bajo mínimo"), lotes (todos, por vencer, vencidos) y detalle de lote con ubicaciones, comprobantes, historial de movimientos y escáner de código de barras que abre el producto.
- Fase 2C · Mi firma: registro y cambio de firma en pantalla, PIN de 3 dígitos mostrado una sola vez y regeneración de PIN.
- Fase 2D/2E · Movimientos: entrada (con lote, ubicación y presentación), salida (FEFO o lote elegido, centro de costo, paciente si es externo), traslado, ajuste, devolución, baja por vencimiento y pérdida. Aviso especial ante un timeout para no duplicar movimientos.
- Fase 2E · Comprobantes: confirmar con firma registrada o en pantalla y PIN o firma de persona externa; cancelar pendientes; ver firmas.
- Fase 2F · PDF del comprobante (ver y compartir sin dejar copia en el teléfono) y envío por correo.
- Listas con scroll infinito, `SignaturePad` y visor de PDF reutilizables.

### Cambiado
- Catálogo de productos y capacidad de almacén movidos a `core/` para compartirlos con inventario.

## [0.3.0+3] - 2026-11-24
### Añadido
- Fase 2A · Almacenes: lista de almacenes asignados y detalle con capacidad de volumen y peso por zona y ubicación (barras con porcentaje y nivel en texto).
- Fase 2A · Catálogo (consulta): búsqueda de productos por nombre, código de barras o referencia; detalle con categoría, unidad base, niveles de stock, variantes, registros sanitarios (vencidos señalados) y componentes de kit; proveedores (lista y detalle) para quien tenga `proveedores.ver`.
- Componentes reutilizables: lista con búsqueda, campo de búsqueda con espera, barra de uso, fila de datos; formato es_CO de números y fechas.

### Corregido
- Los providers que fallan ya no se reintentan solos (Riverpod 3 lo hace por defecto): el error se muestra y el usuario reintenta.

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
