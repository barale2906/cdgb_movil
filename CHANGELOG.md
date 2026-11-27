# Changelog

Formato: [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). Versionado: `x.y.z+build`.

## [1.3.0+14] - 2026-11-27
### Añadido
- Activos: registrar un activo nuevo (botón «+» en la lista, con el permiso de crear) y editar sus datos generales. El código lo genera el servidor; la ubicación y el estado iniciales se eligen solo al registrar.
- Activos: editar la hoja de vida técnica de equipos biomédicos y de cómputo (se conservan las especificaciones y licencias que ya tenga). La ficha ahora muestra con texto claro la forma de adquisición, la clasificación de riesgo, la clase biomédica y la fuente de energía.
- Activos: eliminar un activo registrado por error (borrado lógico). Si ya tiene mantenimientos o traslados el servidor lo rechaza y se debe dar de baja.
- Mantenimientos: programar un mantenimiento puntual desde la ficha (el correctivo exige describir la falla), reprogramar uno programado y crear o editar planes periódicos. Los planes no se eliminan: se desactivan.

### Cambiado
- Órdenes de servicio: anular una orden **devuelve los insumos al inventario** (mismo lote y ubicación) y solo se permite en órdenes sin facturar. Anular requiere el permiso de editar órdenes (superusuarios y coordinadores). **Requiere el backend actualizado.**

### Corregido
- El calendario de los formularios ya no falla al abrirse con una fecha anterior a la mínima permitida (por ejemplo, al reprogramar un mantenimiento vencido).

### Backend (desplegar antes que la app)
- `POST /service-orders/{n}/cancel` devuelve los insumos y exige `ordenes_servicio.editar`; una orden facturada responde 409.
- Nuevos o mejorados, aún sin uso en la app: `Idempotency-Key` en movimientos y órdenes (requiere `php artisan migrate`), `GET /service-orders` paginado y paginación opcional en `GET /patient-procedure-records`. El menú de Catálogo del web usa ahora `generic-products.*`.

### Pendiente
- Firebase (avisos push), aviso de actualización y pruebas en teléfono real. Usar `Idempotency-Key` y `GET /service-orders` en la app. Lista completa en `docs/plan/08-pendientes.md`.

## [1.2.0+13] - 2026-11-26
### Añadido
- Compras: crear, editar y eliminar borradores de **órdenes de compra** (proveedor, almacén, centro de costo y fecha opcionales, y líneas de producto con variante, presentación, cantidad, valor e IVA) y de **órdenes de gasto** (proveedor habilitado para gastos y conceptos con descripción, unidad, cantidad, valor e IVA). Se guardan con un solo envío y sin reintentos; tras un tiempo de espera agotado el reenvío queda bloqueado hasta que la persona revise la lista. Los botones de editar y eliminar aparecen en el detalle de un borrador, con el permiso de crear.

### Cambiado
- El proveedor y las presentaciones de producto pasan a `core` para que catálogo, inventario y compras los compartan (sin cambios para la persona usuaria).
- Una sola función para mostrar números en campos de edición (`AppFormat.plain`).

### Pendiente
- Crear proveedores de gasto, adjuntar la factura, crear/editar activos y programar mantenimientos, avisos push (Firebase), aviso de actualización y pruebas en teléfono real. Lista completa en `docs/plan/08-pendientes.md`.

## [1.1.0+12] - 2026-11-26
### Añadido
- Sin conexión: almacenes, productos, proveedores, centros de costo y servicios se guardan al consultarlos y, sin red, se muestra la última copia. Se borra al cerrar sesión (teléfonos compartidos). Las búsquedas con texto y todas las escrituras siguen siendo en línea.
- Registros clínicos: eliminar un registro de procedimiento (permiso eliminar, con confirmación y aviso si pertenece a una orden).
- Monitoreo: crear reglas de alerta de un sensor (condición, valor límite, lecturas seguidas y canales), activarlas o desactivarlas y eliminarlas, cada acción con su permiso.
- Activos: firmas opcionales (entrega con la firma registrada y recibe con PIN o firma en pantalla) al registrar la ejecución de un mantenimiento.
- Catálogo: la ficha de un kit muestra cuántos se pueden armar con el stock del almacén activo (con permiso de stock).
- Auditoría: filtro por tipo de elemento (las opciones salen de los registros del periodo).

### Cambiado
- Una sola función para las fechas `AAAA-MM-DD` (antes había cinco copias) y un solo lugar para los permisos de las acciones rápidas de Inicio.
- Pruebas de interfaz (*goldens*) de `PatientSelector` (también con el texto al 200 %), `BillingChip` e `InlineError`.

### Pendiente
- Borradores de compra y gasto; crear/editar activos y programar mantenimientos; avisos push (Firebase); aviso de actualización; pruebas en teléfono real. Lista completa en `docs/plan/08-pendientes.md`.

## [1.0.0+11] - 2026-11-26
Primera versión completa: cierra las 8 fases del plan (0 a 7).

### Añadido
- Fase 7 · Auditoría (solo consulta): totales del periodo, filtros por periodo (hoy, 7 y 30 días) y acción (creación, modificación, eliminación, acceso), lista paginada y detalle con los cambios campo por campo. Los valores sensibles (contraseñas, tokens, PIN, firmas) se muestran ocultos.
- Prueba de accesibilidad: las pantallas principales se verifican con el texto al 200 % en un teléfono de 360 dp (inicio, registros clínicos, venta, órdenes, consumos y auditoría).

### Cambiado
- El selector de paciente de los formularios de venta y de orden es un componente compartido y el botón «Cambiar paciente» va debajo del nombre: con el texto al 200 % no cabía a un lado y el formulario fallaba al dibujarse.
- Las listas con la forma `data: {items, meta}` (consumos y auditoría) se leen con un único método compartido.

### Revisión de seguridad
- Sin `print`/`debugPrint`; registros de red apagados fuera de `dev`; copia de seguridad del sistema desactivada; HTTP sin cifrar solo en el sabor `dev`; certificado del servidor anclado en `prod`; ocultamiento en apps recientes y bloqueo de capturas en las compilaciones de producción; APK ofuscado.

### Backend (desplegar antes que la app)
- `ConsumptionRecordResource` ya devuelve `product_id`, `product_code` y `product_name` (antes salían siempre vacíos).
- Ya están en `main` del backend: búsqueda de pacientes con permisos de registro y órdenes, y creación de órdenes atómica.

### Pendiente (no bloquea la 1.0)
- Firebase / push: falta el proyecto, los `google-services.json` por sabor, `FIREBASE_CREDENTIALS` y `php artisan migrate` en el servidor.
- Aviso de actualización: inactivo mientras `UPDATE_URL` esté vacío (decisión de dónde publicar el APK).
- Pruebas manuales en teléfonos reales (lista de verificación en el manual de instalación).
- Crear borradores de compra y gasto; crear/editar activos y programar mantenimientos; editar y eliminar registros de procedimientos y eliminar evoluciones; `scheduling/*`.

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
