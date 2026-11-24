# CLAUDE.md — APP móvil SGA Bojanini

Reglas del proyecto. Se leen al iniciar cada sesión y **mandan sobre cualquier preferencia por defecto**. Si una tarea choca con estas reglas, se detiene y se consulta al usuario.

## 1. Contexto
- App Flutter (Android primero; iOS diferido) para empleados de la Clínica Bojanini. Complementa el SGA web.
- Consume la API REST del backend Laravel: `../back/sga-bojanini` (referencia viva en `../back/sga-bojanini/src/docs/app-movil/`, 342 endpoints; **el código del backend manda sobre la doc**).
- Diseño: `../front/sga-bojanini-front/docs/app.md`. Planes: `docs/plan/` (`00`–`06`). Leer el plan del módulo en `docs/plan/04-plan-modulos.md` antes de tocarlo.
- Distribución: **APK privado** descargado desde el servidor de la clínica (sin tiendas), con aviso de actualización vía `version.json`. **Nunca cambiar el keystore de firma ni bajar el `build number`**: los teléfonos dejarían de poder actualizar. Un solo desarrollador.
- Idioma: **código e identificadores en inglés; textos de UI, mensajes y documentación en español** (trato de "usted").

## 2. Políticas mínimas (obligatorias)
1. **Código profesional, limpio, reutilizable y escalable.** Funciones pequeñas, un propósito por clase, nombres claros, sin duplicación (regla de tres: a la tercera repetición se extrae), sin código muerto ni comentarios que expliquen lo obvio, sin `print`, sin números/strings mágicos, sin `dynamic` innecesario.
2. **Pruebas obligatorias.** Ninguna funcionalidad se da por terminada sin sus pruebas (ver §7). Un bug corregido lleva primero una prueba que lo reproduce.
3. **Reutilizar antes de crear.** Antes de implementar algo nuevo: buscar en `core/` y en las features existentes (widgets, repositorios, providers, modelos, utilidades). Si con extender o un ajuste básico sirve **sin romper lo que ya funciona** (pruebas verdes antes y después), se extiende. Si se crea algo nuevo, indicar en el resumen qué se revisó y por qué no bastó lo existente.
4. **Backend: solo con aprobación previa.** Si se necesita un cambio en `../back` (endpoint, campo, permiso, migración, push, idempotencia…): **no se toca** hasta presentar al usuario (a) qué cambia y por qué, (b) archivos afectados, (c) análisis de impacto sobre el frontend web, la app y datos existentes, (d) plan de pruebas y reversa. Solo se implementa tras un "sí" explícito, de forma retrocompatible (aditiva), con pruebas del backend y sin romper contratos actuales. Prohibido tocar migraciones/BD de producción por cuenta propia.

## 3. Alcance (delimitado)
- Seguir el orden de fases de `docs/plan/01-plan-maestro.md`. No adelantar fases ni añadir módulos no planificados.
- **Fuera de la app** (solo escritorio, confirmado): importaciones Excel; CRUD de almacenes/zonas/ubicaciones, catálogo (productos, variantes, presentaciones, kits, categorías, unidades, clasificaciones), proveedores, roles y usuarios, centros de costo/servicios/procedimientos/precios y plantillas clínicas; `approval-flows`; aprobadores de descuentos; listas de precios; `integrations`; catálogos de activos; sensores IoT (`readings/bulk`, `X-IoT-Token`). No implementarlos.
- Usuarios: solo empleados. No hay perfil de paciente.
- No agregar dependencias, pantallas, ni refactors "de paso" fuera de lo pedido. Hallazgos adyacentes se reportan, no se arreglan sin pedirlo.
- Cambios al plan/arquitectura/diseño: proponer y actualizar `docs/plan/` en el mismo cambio, con aprobación.

## 4. Arquitectura (resumen; detalle en `docs/plan/02-arquitectura.md`)
- **Feature-first + capas**: `features/<x>/{data,domain,application,presentation}`; lo compartido en `core/`. **Una feature no importa de otra**; se comunican vía providers de `core`.
- Dependencias: `presentation → application → data`. La UI nunca llama a Dio ni a modelos JSON directamente; pasa por repositorios/notifiers.
- Estado: **Riverpod**. Navegación: **go_router** con guardas. HTTP: **Dio** único con interceptores. Modelos: **freezed + json_serializable**. Token: **flutter_secure_storage**.
- Dependencias nuevas: justificar (mantenimiento, licencia, tamaño, alternativa en stdlib/existente) y pedir aprobación. Versiones fijadas con `flutter pub add`; sin `any`.
- Flavors `dev` (`co.bojanini.sga.dev`, HTTP permitido) y `prod` (`co.bojanini.sga`, solo HTTPS). El servidor se elige con un archivo de destino `env/<destino>.json` (`local`, `usb`, `lan`, `prod`) vía `--dart-define-from-file`; **nunca** se escribe una URL en el código. Cambiar de servidor = otro JSON. Las URLs pueden versionarse (salvo `env/lan.json`, local); **secretos, keystore, `key.properties`, `google-services.json` y `.deploy.env` nunca**. Detalle: `docs/plan/02-arquitectura.md` §8.

## 5. Reglas de negocio y API que no se negocian
- Envoltorio `{success, message, data, meta?, errors?}` parseado en un único lugar; paginación `page`/`per_page` (máx. 100).
- Manejo uniforme de errores: 401 → login; 403 → mensaje (cuenta desactivada → cerrar sesión); 409 → mostrar `message`; 422 → mapear `errors` a campos; 429 → reintentar luego; red/5xx → reintento manual.
- **Permisos por `user.permissions`**, nunca por nombre de rol. Ocultar acciones sin permiso (`PermissionGate`). `GET /auth/menu` decide qué secciones se ven, pero **cada ruta y acción valida además su propio permiso** (el menú del backend tiene inconsistencias, p. ej. `productos.ver`).
- **Escrituras jamás se reintentan automáticamente** (API sin idempotencia): botón bloqueado en vuelo; tras timeout, consultar antes de reintentar.
- Stock cambia solo al confirmar el comprobante; firmas y PIN según `docs/plan/02` §5. Offline: solo lectura de catálogos en caché; escrituras siempre online.
- Zona horaria Colombia (UTC-5); fechas `DD/MM/AAAA`, hora 12 h, moneda COP.
- **Teléfonos de la clínica (compartidos):** bloqueo por inactividad, "Cambiar de usuario", cierre por turno; sin biometría. Al cerrar sesión no queda ningún dato del usuario anterior.
- **Producción por VPN:** los errores de red en `prod` deben orientar a revisar la VPN.
- **Push:** contenido sin datos sensibles; el detalle se carga dentro de la app.

## 6. Diseño y UX (detalle en `docs/plan/03-sistema-de-diseno.md`)
- Tipografía: **Montserrat** empaquetada (no `google_fonts` en tiempo de ejecución). Marca: **provisional** (`AppBrandMark` + `assets/brand/`); no hay logo oficial y no se debe inventar ni imitar uno.
- Todo color, tipografía, espaciado, radio y sombra sale de `core/theme/tokens.dart`. **Prohibido hardcodear** colores/medidas en pantallas.
- Usar los componentes de `core/widgets`; si falta uno, crearlo ahí (reutilizable), no en la pantalla.
- Una acción principal (amarilla) por pantalla; sobre amarillo siempre texto oscuro; el rosa nunca es color de estado; el estado nunca depende solo del color.
- Estados obligatorios en toda pantalla de datos: cargando (esqueletos), vacío, error con acción de reintento, sin conexión.
- Accesibilidad: objetivo táctil ≥ 44 pt, contraste AA, `Semantics`/tooltips en iconos, texto escalable hasta 200 %, respetar "reducir movimiento".
- Textos de UI en español, sin códigos técnicos; mensajes que digan qué pasó y cómo seguir. Cadenas centralizadas (l10n `es`), no sueltas en widgets.

## 7. Pruebas (obligatorias)
| Nivel | Qué | Mínimo |
|---|---|---|
| Unitarias | repositorios (Dio mockeado), notifiers, validadores, formateadores, mapeo de errores, permisos | ≥ 80 % en `core/` y `application/` |
| Contrato | parseo de cada modelo con fixtures JSON reales en `test/fixtures/` | todo modelo nuevo |
| Widget | pantallas y componentes nuevos; goldens en componentes de `core/widgets` | flujos P0 |
| Integración | flujos críticos contra el backend local en Docker (`integration_test`) | humo por fase |
- Herramientas: `flutter_test` (goldens con `matchesGoldenFile`), `mocktail`, `integration_test`. Fixtures siempre anonimizados. Pruebas deterministas: sin red real, sin `sleep`, relojes inyectados.
- **Antes de entregar cualquier cambio** deben pasar: `dart format --set-exit-if-changed .`, `flutter analyze` (0 advertencias) y `flutter test`. Si algo falla y no se arregla, informarlo con la salida; nunca declarar "listo" sin haberlo ejecutado.
- No desactivar, borrar ni relajar pruebas o lints para que pasen.

## 8. Calidad de código (Dart/Flutter)
- Lints estrictos (`very_good_analysis` o equivalente), `const` donde aplique, null-safety sin `!` salvo justificación.
- Archivos < ~300 líneas; widgets pequeños y componibles; `build()` sin lógica de negocio ni I/O; `dispose` de controladores.
- Modelos inmutables (freezed); errores tipados (`ApiException`), no `catch (e)` genéricos que tragan fallas.
- Sin lógica duplicada entre features: subir a `core/`. Sin dependencias circulares.
- Archivos generados (`*.g.dart`, `*.freezed.dart`) **no se editan a mano**; se regeneran con `dart run build_runner build --delete-conflicting-outputs`.
- Rendimiento: listas con `ListView.builder`/paginación, imágenes redimensionadas, sin trabajo pesado en el hilo de UI (`compute`/isolates para PDF/base64 grandes).

## 9. Seguridad y privacidad
- Token solo en secure storage; PII, tokens, contraseñas, PIN y firmas **nunca** en logs, analítica, crash reports ni notificaciones. Logs de red apagados en `prod`.
- HTTPS obligatorio fuera de `dev`. Release con `--obfuscate --split-debug-info`.
- Datos de pacientes: mostrar lo mínimo, ocultar en vista previa de apps recientes; cumplir Ley 1581 (Habeas Data).
- No commitear: `.env`, keystores (`*.jks`, `*.keystore`), `key.properties`, `google-services.json` real, fixtures con datos reales de personas (anonimizar).
- Validar y sanear toda entrada del usuario antes de enviarla; confiar en el servidor para autorización, no en la UI.

## 10. Flujo de trabajo
- **Git** (repositorio local por ahora, sin remoto ni CI: `tool/check.sh` hace de CI): ramas `main` (estable, siempre compila y pasa pruebas) / `develop` / `feature/<modulo>-<tema>`. Commits pequeños, **Conventional Commits** en español o inglés consistente (`feat(inventory): ...`, `fix:`, `test:`, `refactor:`, `docs:`, `chore:`). Sin commits ni push sin que el usuario lo pida.
- **Antes de implementar una funcionalidad**: (1) leer su sección en `docs/plan/04`, (2) buscar lo existente reutilizable, (3) revisar el endpoint en la doc del back **y** confirmar en el código del back si hay duda, (4) listar archivos que se tocarán. Para cambios amplios, proponer plan breve y esperar visto bueno.
- **Definición de terminado** (por funcionalidad): permisos aplicados · estados cargando/vacío/error/offline · errores 401/403/409/422 manejados · pruebas escritas y verdes · format+analyze limpios · sin hardcodeos de tema · docs del plan actualizadas si cambió algo.
- Al terminar, informar: qué se hizo, qué se reutilizó, qué pruebas se agregaron y su resultado real, y cualquier pendiente o riesgo.
- Cambios de versión (`pubspec.yaml: x.y.z+build`) y `CHANGELOG.md` en cada entrega a usuarios.

## 11. Entorno
- Flutter 3.38.9 / Dart 3.10.8 (Linux). Android: aceptar licencias con `flutter doctor --android-licenses`.
- iOS: **diferido** (sin Mac ni cuenta Apple). Mantener el código multiplataforma y evitar APIs solo-Android; no añadir configuración iOS hasta decidirlo, pero no romper la compilación iOS potencial.
- Backend de pruebas: Docker local en `../back/sga-bojanini` (`docker compose up -d`, nginx en `:8000`). No hay staging.
- Comandos habituales: `tool/run.sh usb|local|lan` (ejecutar contra el backend local) · `tool/check.sh` (format + analyze + test, obligatorio antes de entregar) · `tool/build_apk.sh prod|lan` (APK en `dist/`) · `dart run build_runner build --delete-conflicting-outputs` · `flutter test --coverage`.

## 12. Cosas que NUNCA se hacen sin pedir permiso
Modificar el backend o su BD · añadir dependencias · cambiar la arquitectura o el sistema de diseño · borrar o reescribir módulos existentes · commit/push · subir algo fuera del equipo · saltarse pruebas o lints · usar datos reales de pacientes en pruebas.
