# Changelog

Formato: [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). Versionado: `x.y.z+build`.

## [0.10.0+10] - 2026-11-26
### Añadido
- Fase 6 · Registros clínicos: lista de los últimos 30 días con filtro por documento, detalle del registro, ficha del paciente (resumen, citas activas e historial) y búsqueda de pacientes de MedSys por documento o nombre.
- Fase 6 · Registrar venta: paciente de MedSys, fecha, vendedor, remitente y uno o más servicios con cantidad y valor. Un registro por servicio, enviados uno por uno y sin reintentos automáticos: lo ya registrado se bloquea y un tiempo de espera agotado deja la línea «sin confirmar» hasta que la persona revise.
- Fase 6 · Evoluciones clínicas: listar, agregar (con la plantilla del servicio precargada) y editar, y medicamentos aplicados en el detalle del registro.
- Fase 6 · Órdenes de servicio: búsqueda por número, descuentos por aprobar, detalle con aprobar descuento, facturar y anular (con confirmación), y nueva orden con paciente de MedSys, procedimientos, descuento por línea, insumos desde un almacén y evolución clínica obligatoria por procedimiento (como el web).
- Fase 6 · Consumos: lista con filtro por estado de sincronización, detalle, registro de un consumo (almacén, centro de costo, insumos, cita y paciente opcionales) y reintento de sincronización; con permiso de integraciones, proyección de consumo por servicio según las citas futuras de MedSys.
- Fase 6 · Centros de costo y servicios: centros de costo, árbol de servicios y procedimientos, y tarifas (solo lectura).
- Accesos rápidos en Inicio: «Registrar venta» y «Nueva orden».
- Seguridad: en las compilaciones de producción la app se oculta en la vista de aplicaciones recientes y bloquea capturas de pantalla (los datos de pacientes no quedan visibles en un teléfono compartido).

### Cambiado
- La búsqueda de pacientes de MedSys la habilitan también `registros_procedimientos.crear` y `ordenes_servicio.crear` (requiere el backend con la rama `feature/medsys-permisos-clinicos`).
- Los modelos y selectores compartidos entre registros clínicos y órdenes pasaron a `core` (sin cambios para la persona usuaria).

### Requiere el backend
- **Desplegar primero el backend** (ramas `feature/medsys-permisos-clinicos` y `feature/ordenes-servicio-atomicas`): sin la primera, los roles que no tienen `integraciones.ver` verían la pestaña de pacientes con un error de permiso; sin la segunda, una orden que falla a la mitad puede quedar guardada parcialmente (la app lo advierte).

### Notas
- Las evoluciones se muestran como texto simple y se guardan como párrafos: la app no tiene editor de texto enriquecido; editar una evolución con negritas o listas las pierde.
- Los consumos muestran «Insumo» cuando el backend no envía el nombre del producto (el recurso `ConsumptionRecordResource` lee campos que el modelo no tiene).
- Anular una orden no devuelve al inventario los insumos que ya salieron (límite del backend); el diálogo lo advierte.

### Pendiente
- Editar y eliminar registros de procedimientos; eliminar evoluciones.
- Citas y análisis de demanda de `scheduling/*`: dependen de una integración externa y por defecto devuelven datos simulados; se dejan fuera hasta definir su fuente real.

## [0.9.0+9] - 2026-11-25
### Añadido
- Fase 5 · Activos: lista con indicadores, búsqueda y filtros; ficha con datos, perfil técnico, historial de ubicaciones y bitácora, comentarios, planes de mantenimiento y hoja de vida en PDF; escáner de la etiqueta; cambio de estado.
- Fase 5 · Traslados: lista y detalle, solicitud según el tipo (traslado interno, reparación externa, préstamo, devolución y baja), confirmación con firmas o PIN, cancelación con motivo y acta en PDF. Un activo fuera de las instalaciones solo admite devolución o baja.
- Fase 5 · Mantenimientos: sección con programados, vencidos, en curso y realizados; iniciar, registrar la ejecución (técnico o proveedor, resultado, repuestos y costo), cancelar y reporte en PDF.
- Fase 5 · Documentos: ver y compartir, subir con cámara, galería o archivo (hasta 10 MB; las fotos se reducen) y eliminar.
- Componentes compartidos: formulario de firmas de confirmación, vista previa de PDF y diálogo de texto.

### Cambiado
- La confirmación de comprobantes de inventario usa el formulario de firmas compartido (sin cambios para la persona usuaria).
- El escáner de código acepta también el permiso de activos.

### Dependencias nuevas
- `image_picker ^1.2.3` y `file_picker ^13.4.1`.

### Pendiente
- Crear y editar activos, y programar mantenimientos o planes: se dejan para el escritorio.
- Firmas opcionales al completar un mantenimiento.

## [0.8.0+8] - 2026-11-25
### Añadido
- Avisos push (FCM): al iniciar sesión el teléfono se vincula con el usuario; al cerrar sesión o cambiar de usuario se desvincula antes de revocar la sesión. Tocar un aviso abre la sección correspondiente (espera al desbloqueo si la sesión está bloqueada) y, con la app abierta, actualiza el contador de notificaciones.
- El permiso de notificaciones se pide al iniciar sesión (Android 13+).
- `tool/build_apk.sh` avisa si falta `google-services.json` del sabor.

### Notas
- Sin `google-services.json` la app funciona igual, sin push. Pasos de activación en `docs/plan/02-arquitectura.md` §10.2.
- Requiere desplegar la migración `user_devices` del backend (rama `feature/push-dispositivos`).

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
