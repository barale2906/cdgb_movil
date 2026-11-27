// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SGA Bojanini';

  @override
  String get brandSubtitle => 'SISTEMA DE GESTIÓN DE ALMACÉN';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutEnvironment => 'Ambiente';

  @override
  String get aboutServer => 'Servidor';

  @override
  String get aboutUpdates => 'Actualizaciones';

  @override
  String get aboutUpdatesDisabled => 'Desactivadas (ruta del APK pendiente)';

  @override
  String aboutSessionPolicy(int minutes, int hours) {
    return 'Bloqueo por inactividad: $minutes min · Cierre de sesión: $hours h';
  }

  @override
  String get envDev => 'Desarrollo';

  @override
  String get envProd => 'Producción';

  @override
  String get actionRetry => 'Reintentar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionAccept => 'Aceptar';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionBack => 'Volver';

  @override
  String get loading => 'Cargando…';

  @override
  String get errorNetworkProd =>
      'No se pudo conectar con el servidor. Verifique que la VPN de la clínica esté activa e intente de nuevo.';

  @override
  String get errorNetwork =>
      'No se pudo conectar con el servidor. Revise su conexión a internet e intente de nuevo.';

  @override
  String get errorTimeout =>
      'El servidor tardó demasiado en responder. Intente de nuevo.';

  @override
  String get errorServer =>
      'El servidor no pudo completar la solicitud. Intente de nuevo en unos minutos.';

  @override
  String get errorRateLimited =>
      'Demasiados intentos. Espere un momento e intente de nuevo.';

  @override
  String get errorForbidden => 'No tiene permiso para realizar esta acción.';

  @override
  String get errorNotFound => 'No se encontró la información solicitada.';

  @override
  String get errorUnauthenticated =>
      'Su sesión terminó. Inicie sesión de nuevo.';

  @override
  String get errorGeneric => 'Ocurrió un error inesperado. Intente de nuevo.';

  @override
  String get offlineBanner =>
      'Sin conexión. Las acciones que guardan datos están deshabilitadas.';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get loginSubtitle => 'Ingrese con su cuenta de la clínica.';

  @override
  String get fieldEmail => 'Correo electrónico';

  @override
  String get fieldPassword => 'Contraseña';

  @override
  String get loginButton => 'Ingresar';

  @override
  String get validationEmailRequired => 'Ingrese su correo electrónico.';

  @override
  String get validationEmailInvalid => 'Ingrese un correo válido.';

  @override
  String get validationPasswordRequired => 'Ingrese su contraseña.';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get sessionEndedExpired => 'Su sesión expiró. Inicie sesión de nuevo.';

  @override
  String get sessionEndedAccountDisabled =>
      'Su cuenta fue desactivada. Comuníquese con el administrador.';

  @override
  String get sessionEndedShift =>
      'Su turno terminó y la sesión se cerró por seguridad. Inicie sesión de nuevo.';

  @override
  String get restoreFailedTitle => 'No se pudo verificar su sesión';

  @override
  String get lockedTitle => 'Sesión bloqueada';

  @override
  String lockedSubtitle(String name) {
    return 'Se bloqueó por inactividad. $name, ingrese su contraseña para continuar.';
  }

  @override
  String get lockedUnlock => 'Desbloquear';

  @override
  String get lockedWrongPassword => 'La contraseña no es correcta.';

  @override
  String get switchUser => 'Cambiar de usuario';

  @override
  String get switchUserConfirmTitle => '¿Cambiar de usuario?';

  @override
  String get switchUserConfirmBody =>
      'Se cerrará la sesión actual en este equipo.';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get logoutConfirmBody =>
      'Deberá ingresar de nuevo para usar la aplicación.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navMore => 'Más';

  @override
  String get navInventory => 'Inventario';

  @override
  String get navPurchasing => 'Compras';

  @override
  String get navAssets => 'Activos';

  @override
  String get navMaintenance => 'Mantenimientos';

  @override
  String get navWarehouses => 'Almacenes';

  @override
  String get navCatalog => 'Catálogo';

  @override
  String get navServiceOrders => 'Órdenes de servicio';

  @override
  String get navClinicalRecords => 'Registros clínicos';

  @override
  String get navCostCenters => 'Centros de costo';

  @override
  String get navMonitoring => 'Monitoreo';

  @override
  String get navConsumptions => 'Consumos';

  @override
  String get navReports => 'Reportes';

  @override
  String get navAudit => 'Auditoría';

  @override
  String homeGreeting(String name) {
    return 'Hola, $name';
  }

  @override
  String get homeModules => 'Módulos disponibles';

  @override
  String get homeNoModules =>
      'Su usuario no tiene módulos habilitados. Comuníquese con el administrador.';

  @override
  String get comingSoonTitle => 'Próximamente';

  @override
  String get comingSoonBody =>
      'Este módulo estará disponible en una próxima versión de la aplicación.';

  @override
  String get menuLoadError => 'No se pudieron cargar sus módulos.';

  @override
  String get moreTitle => 'Más opciones';

  @override
  String get openProfile => 'Abrir perfil';

  @override
  String get profileTitle => 'Mi perfil';

  @override
  String get profileRoles => 'Roles';

  @override
  String get profileWarehouses => 'Almacenes asignados';

  @override
  String get profileNoWarehouses => 'Sin almacenes asignados';

  @override
  String get profileChangePassword => 'Cambiar contraseña';

  @override
  String get changePasswordTitle => 'Cambiar contraseña';

  @override
  String get fieldCurrentPassword => 'Contraseña actual';

  @override
  String get fieldNewPassword => 'Nueva contraseña';

  @override
  String get fieldConfirmPassword => 'Confirmar nueva contraseña';

  @override
  String validationPasswordMinLength(int min) {
    return 'Use al menos $min caracteres.';
  }

  @override
  String get validationPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get validationPasswordSame =>
      'La nueva contraseña debe ser distinta de la actual.';

  @override
  String get passwordChanged => 'Contraseña actualizada.';

  @override
  String get warehouseSelectTitle => 'Almacén activo';

  @override
  String get warehouseNone => 'Seleccionar almacén';

  @override
  String get warehouseEmpty => 'No tiene almacenes asignados.';

  @override
  String get warehouseLoadError => 'No se pudieron cargar los almacenes.';

  @override
  String get warehouseSelectorHint => 'Cambiar almacén activo';

  @override
  String get updateAvailableTitle => 'Hay una versión nueva';

  @override
  String updateAvailableBody(String version) {
    return 'La versión $version ya está disponible.';
  }

  @override
  String get updateRequiredTitle => 'Actualice la aplicación';

  @override
  String updateRequiredBody(String version) {
    return 'Esta versión ya no es compatible. Descargue la versión $version para continuar.';
  }

  @override
  String get updateDownload => 'Descargar';

  @override
  String get updateLater => 'Más tarde';

  @override
  String get aboutVersion => 'Versión';

  @override
  String get aboutChangeServer => 'Cambiar servidor';

  @override
  String get aboutChangeServerHint => 'Dirección del servidor';

  @override
  String get aboutChangeServerInvalid =>
      'Ingrese una dirección válida, p. ej. http://192.168.1.10:8000/api/v1';

  @override
  String get aboutChangeServerNotice =>
      'Se cerrará la sesión y la aplicación se reiniciará con el nuevo servidor.';

  @override
  String get aboutUseDefaultServer => 'Usar el servidor original';

  @override
  String get aboutLicenses => 'Licencias';

  @override
  String get statusActive => 'Activo';

  @override
  String get statusInactive => 'Inactivo';

  @override
  String get warehouseDetailTitle => 'Almacén';

  @override
  String get warehouseCode => 'Código';

  @override
  String get warehouseAddress => 'Dirección';

  @override
  String get warehouseDescription => 'Descripción';

  @override
  String get capacityTitle => 'Capacidad';

  @override
  String get capacityVolume => 'Volumen';

  @override
  String get capacityWeight => 'Peso';

  @override
  String capacityUsedOfMax(String used, String max, String unit) {
    return '$used de $max $unit';
  }

  @override
  String capacityUsedOnly(String used, String unit) {
    return 'En uso: $used $unit (sin límite definido)';
  }

  @override
  String get capacityLevelLow => 'Disponible';

  @override
  String get capacityLevelMedium => 'Moderado';

  @override
  String get capacityLevelHigh => 'Casi lleno';

  @override
  String get capacityZones => 'Zonas';

  @override
  String get capacityNoZones => 'Este almacén no tiene zonas registradas.';

  @override
  String capacityLocationCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ubicaciones',
      one: '1 ubicación',
      zero: 'Sin ubicaciones',
    );
    return '$_temp0';
  }

  @override
  String get unitLiters => 'L';

  @override
  String get unitKg => 'kg';

  @override
  String get searchHint => 'Buscar';

  @override
  String get searchClear => 'Borrar búsqueda';

  @override
  String get noResults => 'No se encontraron resultados.';

  @override
  String get catalogTabProducts => 'Productos';

  @override
  String get catalogTabSuppliers => 'Proveedores';

  @override
  String get catalogSearchProducts => 'Buscar por nombre o código de barras';

  @override
  String get catalogSearchSuppliers => 'Buscar por nombre o NIT';

  @override
  String get catalogEmptyProducts => 'No hay productos para mostrar.';

  @override
  String get catalogEmptySuppliers => 'No hay proveedores para mostrar.';

  @override
  String get productDetailTitle => 'Producto';

  @override
  String get productTypeSimple => 'Simple';

  @override
  String get productTypeKit => 'Kit';

  @override
  String get productColdChain => 'Cadena de frío';

  @override
  String get productBarcode => 'Código de barras';

  @override
  String get productCategory => 'Categoría';

  @override
  String get productClassification => 'Clasificación';

  @override
  String get productBaseUnit => 'Unidad base';

  @override
  String get productPharmaceuticalForm => 'Forma farmacéutica';

  @override
  String get productConcentration => 'Concentración';

  @override
  String get productStockLevels => 'Niveles de stock';

  @override
  String get productMinStock => 'Mínimo';

  @override
  String get productMaxStock => 'Máximo';

  @override
  String get productReorderPoint => 'Punto de reorden';

  @override
  String get productReorderQuantity => 'Cantidad de reorden';

  @override
  String get productVariants => 'Variantes';

  @override
  String get productNoVariants => 'Sin variantes registradas.';

  @override
  String get variantBrand => 'Marca';

  @override
  String get variantSku => 'Referencia';

  @override
  String get variantRisk => 'Riesgo';

  @override
  String get variantSanitaryRegistration => 'Registro sanitario';

  @override
  String get sanitaryExpired => 'Vencido';

  @override
  String sanitaryExpiresOn(String date) {
    return 'Vence $date';
  }

  @override
  String get productKitComponents => 'Componentes del kit';

  @override
  String productKitQuantity(String quantity) {
    return 'x$quantity';
  }

  @override
  String get supplierDetailTitle => 'Proveedor';

  @override
  String get supplierTaxId => 'NIT';

  @override
  String get supplierContact => 'Contacto';

  @override
  String get supplierPhone => 'Teléfono';

  @override
  String get supplierEmail => 'Correo';

  @override
  String get supplierAddress => 'Dirección';

  @override
  String get supplierNotes => 'Notas';

  @override
  String get supplierTypeInventory => 'Inventario';

  @override
  String get supplierTypeExpense => 'Gasto';

  @override
  String get notAvailable => '—';

  @override
  String get variantPresentation => 'Presentación comercial';

  @override
  String get inventoryTabStock => 'Existencias';

  @override
  String get inventoryTabBatches => 'Lotes';

  @override
  String get inventoryTabDocuments => 'Comprobantes';

  @override
  String get inventoryTabHistory => 'Historial';

  @override
  String get inventorySelectWarehouse =>
      'Seleccione un almacén activo en la barra superior para ver el inventario.';

  @override
  String get stockEmpty => 'No hay existencias registradas en este almacén.';

  @override
  String get stockLowFilter => 'Bajo mínimo';

  @override
  String get stockLowEmpty =>
      'Ningún producto está por debajo del punto de reorden.';

  @override
  String stockAvailable(String quantity) {
    return 'Disponible: $quantity';
  }

  @override
  String stockTotals(String total, String reserved) {
    return 'Total: $total · Reservado: $reserved';
  }

  @override
  String get batchFilterAll => 'Todos';

  @override
  String get batchFilterExpiring => 'Por vencer';

  @override
  String get batchFilterExpired => 'Vencidos';

  @override
  String get batchesEmpty => 'No hay lotes para mostrar.';

  @override
  String batchLot(String lot) {
    return 'Lote $lot';
  }

  @override
  String batchExpires(String date) {
    return 'Vence $date';
  }

  @override
  String batchExpiresInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días',
      one: '1 día',
      zero: 'hoy',
    );
    return 'Vence en $_temp0';
  }

  @override
  String get batchStatusActive => 'Vigente';

  @override
  String get batchStatusExpired => 'Vencido';

  @override
  String get batchStatusDepleted => 'Agotado';

  @override
  String get batchDetailTitle => 'Lote';

  @override
  String get batchQuantity => 'Cantidad disponible';

  @override
  String get batchManufacturing => 'Fabricación';

  @override
  String get batchLocations => 'Ubicaciones';

  @override
  String get batchNoLocations => 'Sin ubicaciones con saldo.';

  @override
  String get documentsEmpty => 'No hay comprobantes para mostrar.';

  @override
  String get documentFilterAll => 'Todos';

  @override
  String get documentFilterPending => 'Pendientes';

  @override
  String get documentFilterConfirmed => 'Confirmados';

  @override
  String get documentStatusPending => 'Pendiente de firma';

  @override
  String get documentStatusConfirmed => 'Confirmado';

  @override
  String get historyEmpty => 'No hay movimientos registrados.';

  @override
  String get movementEntry => 'Entrada';

  @override
  String get movementExit => 'Salida';

  @override
  String get movementTransfer => 'Traslado';

  @override
  String get movementAdjustment => 'Ajuste';

  @override
  String get movementReturn => 'Devolución';

  @override
  String get movementWriteOff => 'Baja por vencimiento';

  @override
  String get movementLoss => 'Pérdida';

  @override
  String get movementEntryHint => 'Ingreso de mercancía con lote y ubicación.';

  @override
  String get movementExitHint => 'Despacho a un centro de costo o paciente.';

  @override
  String get movementTransferHint => 'Envío de stock a otro almacén.';

  @override
  String get movementAdjustmentHint => 'Corrección de cantidad con motivo.';

  @override
  String get movementReturnHint => 'Reingreso de producto devuelto.';

  @override
  String get movementWriteOffHint => 'Baja de un lote vencido.';

  @override
  String get movementLossHint => 'Rotura, extravío u otra pérdida.';

  @override
  String get scanAction => 'Escanear código';

  @override
  String get newMovementAction => 'Nuevo movimiento';

  @override
  String get scanTitle => 'Escanear producto';

  @override
  String get scanHint => 'Apunte la cámara al código de barras del producto.';

  @override
  String get scanPermissionDenied =>
      'Sin acceso a la cámara. Habilítelo en los ajustes del teléfono.';

  @override
  String scanNotFound(String code) {
    return 'No se encontró un producto con el código $code.';
  }

  @override
  String get scanTorch => 'Linterna';

  @override
  String get newMovementTitle => 'Nuevo movimiento';

  @override
  String get newMovementChoose => '¿Qué desea registrar?';

  @override
  String get newMovementNone =>
      'Su usuario no tiene permisos para registrar movimientos.';

  @override
  String get fieldWarehouse => 'Almacén';

  @override
  String get fieldReason => 'Motivo';

  @override
  String get fieldReasonOptional => 'Motivo (opcional)';

  @override
  String get fieldNotes => 'Notas (opcional)';

  @override
  String get fieldQuantity => 'Cantidad';

  @override
  String get fieldLot => 'Número de lote';

  @override
  String get fieldExpiration => 'Fecha de vencimiento';

  @override
  String get fieldManufacturing => 'Fecha de fabricación (opcional)';

  @override
  String get fieldLocation => 'Ubicación';

  @override
  String get fieldLocationOptional => 'Ubicación (opcional)';

  @override
  String get fieldCostCenter => 'Centro de costo';

  @override
  String get fieldPatientDocument => 'Documento del paciente (opcional)';

  @override
  String get fieldInvoice => 'Factura (opcional)';

  @override
  String get fieldTemperature => 'Temperatura de entrada, °C (opcional)';

  @override
  String get fieldProduct => 'Producto';

  @override
  String get fieldVariant => 'Variante';

  @override
  String get fieldBatch => 'Lote';

  @override
  String get fieldBatchFefo => 'Automático (primero en vencer)';

  @override
  String get fieldDestinationWarehouse => 'Almacén destino';

  @override
  String get fieldPresentation => 'Presentación';

  @override
  String get fieldBaseUnitDirect => 'Unidad base';

  @override
  String get fieldSignedQuantity => 'Cantidad (negativa para restar)';

  @override
  String get itemsTitle => 'Productos';

  @override
  String get addItem => 'Agregar producto';

  @override
  String get removeItem => 'Quitar';

  @override
  String get itemsRequired => 'Agregue al menos un producto.';

  @override
  String get selectProduct => 'Seleccionar producto';

  @override
  String get selectOption => 'Seleccionar';

  @override
  String get pickDate => 'Elegir fecha';

  @override
  String get submitRegister => 'Registrar';

  @override
  String get validationRequired => 'Este campo es obligatorio.';

  @override
  String get validationPositive => 'Ingrese una cantidad mayor que cero.';

  @override
  String get validationNonZero => 'Ingrese una cantidad distinta de cero.';

  @override
  String get validationNumber => 'Ingrese un número válido.';

  @override
  String movementRegisteredDoc(String number) {
    return 'Comprobante $number registrado.';
  }

  @override
  String get movementRegistered => 'Movimiento registrado.';

  @override
  String get movementPendingSignNote =>
      'Quedó pendiente de firma: el stock cambia al confirmarlo.';

  @override
  String get movementTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, revise el historial: es posible que sí se haya registrado.';

  @override
  String get movementNeedsCostCenters =>
      'Para registrar salidas se necesita poder consultar centros de costo.';

  @override
  String get noProductsFound => 'No se encontraron productos.';

  @override
  String get noVariants => 'Este producto no tiene variantes.';

  @override
  String get noLocations => 'Este almacén no tiene ubicaciones.';

  @override
  String get noBatchesAvailable => 'No hay lotes disponibles.';

  @override
  String get confirmTitle => 'Confirmar comprobante';

  @override
  String get confirmDelivered => 'Entrega';

  @override
  String get confirmUseMySignature => 'Usar mi firma registrada';

  @override
  String get confirmNoSignature =>
      'Aún no tiene firma registrada. Regístrela para poder entregar.';

  @override
  String get confirmRegisterSignature => 'Registrar mi firma';

  @override
  String get confirmReceived => 'Recibe';

  @override
  String get confirmModePin => 'Usuario del sistema';

  @override
  String get confirmModeExternal => 'Persona externa';

  @override
  String get fieldPin => 'PIN de 3 dígitos';

  @override
  String get validationPin => 'Ingrese los 3 dígitos del PIN.';

  @override
  String get fieldSignerName => 'Nombre completo';

  @override
  String get fieldSignerDocument => 'Documento';

  @override
  String get signHere => 'Firme aquí';

  @override
  String get clearSignature => 'Borrar firma';

  @override
  String get signatureRequired => 'La firma es obligatoria.';

  @override
  String get confirmAction => 'Confirmar y firmar';

  @override
  String get confirmedMessage => 'Comprobante confirmado.';

  @override
  String get cancelPendingAction => 'Cancelar comprobante';

  @override
  String get cancelPendingTitle => '¿Cancelar este comprobante?';

  @override
  String get cancelPendingBody => 'Quedará anulado y el stock no cambiará.';

  @override
  String get cancelledMessage => 'Comprobante cancelado.';

  @override
  String get documentDetailTitle => 'Comprobante';

  @override
  String get documentWarehouse => 'Almacén';

  @override
  String get documentDestination => 'Almacén destino';

  @override
  String get documentCreatedBy => 'Registrado por';

  @override
  String get documentDate => 'Fecha';

  @override
  String get documentCostCenter => 'Centro de costo';

  @override
  String get documentReason => 'Motivo';

  @override
  String get documentLines => 'Líneas';

  @override
  String get documentSignatures => 'Firmas';

  @override
  String get signatureDelivered => 'Entrega';

  @override
  String get signatureReceived => 'Recibe';

  @override
  String get viewSignature => 'Ver firma';

  @override
  String documentLineQuantity(String product, String quantity) {
    return '$product · $quantity';
  }

  @override
  String get pdfView => 'Ver PDF';

  @override
  String get pdfShare => 'Compartir PDF';

  @override
  String get pdfTitle => 'Comprobante en PDF';

  @override
  String get pdfError => 'No se pudo cargar el PDF.';

  @override
  String get sendEmailAction => 'Enviar por correo';

  @override
  String get fieldRecipients => 'Correos (separados por coma)';

  @override
  String get validationEmails => 'Ingrese correos válidos separados por comas.';

  @override
  String get emailSent => 'Correo enviado.';

  @override
  String get signatureTitle => 'Mi firma';

  @override
  String get signatureIntro =>
      'Su firma se usa al entregar comprobantes. Necesita su contraseña para guardarla.';

  @override
  String get fieldDocumentType => 'Tipo de documento';

  @override
  String get fieldDocumentNumber => 'Número de documento';

  @override
  String get validationDocumentNumber => 'Use entre 4 y 20 letras o números.';

  @override
  String get signatureSave => 'Guardar firma';

  @override
  String get signatureSaved => 'Firma guardada.';

  @override
  String get signatureNone => 'Aún no ha registrado su firma.';

  @override
  String get signaturePinTitle => 'Anote su PIN';

  @override
  String get signaturePinBody =>
      'Este PIN de 3 dígitos permite recibir comprobantes con su firma. Se muestra una sola vez.';

  @override
  String get signaturePinConfirm => 'Ya anoté mi PIN';

  @override
  String get signaturePinRegenerate => 'Generar PIN nuevo';

  @override
  String get signaturePinRegenerateBody =>
      'El PIN anterior dejará de funcionar. ¿Generar uno nuevo?';

  @override
  String signatureRegisteredOn(String date) {
    return 'Registrada el $date';
  }

  @override
  String get signatureHasPin => 'PIN activo';

  @override
  String get signatureNoPin => 'Sin PIN';

  @override
  String get docTypeCC => 'Cédula de ciudadanía';

  @override
  String get docTypeCE => 'Cédula de extranjería';

  @override
  String get docTypeTI => 'Tarjeta de identidad';

  @override
  String get docTypePA => 'Pasaporte';

  @override
  String get docTypePPT => 'Permiso por protección temporal';

  @override
  String get profileMySignature => 'Mi firma';

  @override
  String get clearField => 'Borrar';

  @override
  String get lineAdded => 'Agregar';

  @override
  String get aboutServerPresets => 'Servidores disponibles';

  @override
  String get aboutServerCustom => 'Otra dirección';

  @override
  String get aboutServerCurrent => 'En uso';

  @override
  String get aboutServerRestartNote =>
      'Al cambiar de servidor se cierra la sesión.';

  @override
  String loginServerLabel(String name) {
    return 'Servidor: $name';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsOpen => 'Abrir notificaciones';

  @override
  String notificationsUnreadCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notificaciones sin leer',
      one: '1 notificación sin leer',
      zero: 'Sin notificaciones nuevas',
    );
    return '$_temp0';
  }

  @override
  String get notificationsEmpty => 'No tiene notificaciones.';

  @override
  String get notificationsEmptyUnread => 'No tiene notificaciones sin leer.';

  @override
  String get notificationsFilterAll => 'Todas';

  @override
  String get notificationsFilterUnread => 'Sin leer';

  @override
  String get notificationsMarkAllRead => 'Marcar todas como leídas';

  @override
  String get notificationsAllRead =>
      'Todas las notificaciones quedaron leídas.';

  @override
  String get severityCritical => 'Crítica';

  @override
  String get severityWarning => 'Advertencia';

  @override
  String get severityInfo => 'Información';

  @override
  String get severitySuccess => 'Listo';

  @override
  String get notificationUnread => 'Sin leer';

  @override
  String get dashInventory => 'Inventario';

  @override
  String get dashProducts => 'Productos';

  @override
  String get dashUnits => 'Unidades en stock';

  @override
  String get dashStockHealth => 'Estado del stock';

  @override
  String get dashStockOk => 'Suficiente';

  @override
  String get dashStockLow => 'Bajo reorden';

  @override
  String get dashStockCritical => 'Crítico';

  @override
  String get dashExpiring => 'Vencimientos de lotes';

  @override
  String get dashExpiringToday => 'Hoy';

  @override
  String get dashExpiring7 => '7 días';

  @override
  String get dashExpiring30 => '30 días';

  @override
  String get dashMovementsToday => 'Movimientos hoy';

  @override
  String get dashTopConsumed => 'Más consumidos (30 días)';

  @override
  String get dashPurchasing => 'Compras';

  @override
  String get dashPendingOrders => 'Órdenes por aprobar';

  @override
  String get dashApprovedOrders => 'Órdenes aprobadas';

  @override
  String get dashMonthTotal => 'Compras del mes';

  @override
  String get dashMonitoring => 'Monitoreo';

  @override
  String get dashActiveSensors => 'Sensores activos';

  @override
  String get dashAlertsToday => 'Alertas hoy';

  @override
  String get dashReadingsToday => 'Lecturas hoy';

  @override
  String get dashAlerts => 'Alertas recientes';

  @override
  String get dashNoAlerts => 'Sin alertas pendientes.';

  @override
  String get dashActivity => 'Actividad reciente';

  @override
  String get dashNoActivity => 'Sin actividad reciente.';

  @override
  String get dashQuickActions => 'Accesos rápidos';

  @override
  String get dashScan => 'Escanear';

  @override
  String get dashNewMovement => 'Nuevo movimiento';

  @override
  String get dashBlockError => 'No se pudo cargar este bloque.';

  @override
  String get auditCreated => 'Creó';

  @override
  String get auditUpdated => 'Modificó';

  @override
  String get auditDeleted => 'Eliminó';

  @override
  String get auditUnknown => 'Acción';

  @override
  String get monitoringEmpty => 'No tiene sensores asignados.';

  @override
  String get sensorTypeTemperature => 'Temperatura';

  @override
  String get sensorTypeHumidity => 'Humedad';

  @override
  String get sensorLastReading => 'Última lectura';

  @override
  String get sensorNoReadings => 'Sin lecturas aún';

  @override
  String get sensorOutOfRange => 'Fuera de rango';

  @override
  String get sensorInRange => 'En rango';

  @override
  String sensorLimits(String min, String max, String unit) {
    return 'Rango permitido: $min–$max $unit';
  }

  @override
  String get sensorZone => 'Zona';

  @override
  String get sensorDetailTitle => 'Sensor';

  @override
  String get calibrationValid => 'Calibración vigente';

  @override
  String get calibrationExpiring => 'Calibración por vencer';

  @override
  String get calibrationExpired => 'Calibración vencida';

  @override
  String get calibrationMissing => 'Sin certificado';

  @override
  String calibrationDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Vence en $days días',
      one: 'Vence en 1 día',
      zero: 'Vence hoy',
    );
    return '$_temp0';
  }

  @override
  String get periodDay => '24 h';

  @override
  String get periodWeek => '7 días';

  @override
  String get periodMonth => '30 días';

  @override
  String get readingsStats => 'Resumen del periodo';

  @override
  String get statMin => 'Mínimo';

  @override
  String get statMax => 'Máximo';

  @override
  String get statAvg => 'Promedio';

  @override
  String get statCount => 'Lecturas';

  @override
  String get readingsEmptyPeriod => 'No hay lecturas en este periodo.';

  @override
  String get trendTitle => 'Tendencia';

  @override
  String get trendNone => 'Sin tendencia significativa en el periodo.';

  @override
  String get trendUp => 'Tendencia al alza';

  @override
  String get trendDown => 'Tendencia a la baja';

  @override
  String trendConfidence(String level) {
    return 'Confianza $level';
  }

  @override
  String get confidenceHigh => 'alta';

  @override
  String get confidenceMedium => 'media';

  @override
  String get confidenceLow => 'baja';

  @override
  String get readingRegister => 'Registrar lectura';

  @override
  String readingValue(String unit) {
    return 'Valor ($unit)';
  }

  @override
  String get readingWhen => 'Fecha y hora de la lectura';

  @override
  String get readingSaved => 'Lectura registrada.';

  @override
  String readingAlerts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'La lectura generó $count alertas.',
      one: 'La lectura generó 1 alerta.',
    );
    return '$_temp0';
  }

  @override
  String get calibrationsTitle => 'Calibraciones';

  @override
  String get calibrationsEmpty => 'Sin certificados de calibración.';

  @override
  String get calibrationDownload => 'Descargar certificado';

  @override
  String get calibrationCurrent => 'Vigente';

  @override
  String get calibrationReplaced => 'Reemplazado';

  @override
  String get alertRulesTitle => 'Reglas de alerta';

  @override
  String get alertRulesEmpty => 'Sin reglas de alerta.';

  @override
  String alertAbove(String threshold) {
    return 'Por encima de $threshold';
  }

  @override
  String alertBelow(String threshold) {
    return 'Por debajo de $threshold';
  }

  @override
  String get alertOutOfRange => 'Fuera del rango permitido';

  @override
  String get alertTrendUp => 'Tendencia al alza';

  @override
  String get alertTrendDown => 'Tendencia a la baja';

  @override
  String alertConsecutive(int count) {
    return '$count lecturas seguidas';
  }

  @override
  String get conditionsReportAction => 'Reporte de condiciones (PDF)';

  @override
  String get reportsCatalogTitle => 'Elija un reporte';

  @override
  String get reportsMyExports => 'Mis exportaciones';

  @override
  String get reportInventory => 'Inventario';

  @override
  String get reportInventoryHint => 'Existencias por almacén.';

  @override
  String get reportMovements => 'Movimientos';

  @override
  String get reportMovementsHint => 'Entradas, salidas y demás movimientos.';

  @override
  String get reportExpiring => 'Por vencer';

  @override
  String get reportExpiringHint => 'Lotes próximos a vencer.';

  @override
  String get reportPurchases => 'Compras';

  @override
  String get reportPurchasesHint => 'Órdenes de compra del periodo.';

  @override
  String get reportConsumption => 'Consumo';

  @override
  String get reportConsumptionHint => 'Productos consumidos en el periodo.';

  @override
  String get reportConditions => 'Condiciones de almacenamiento';

  @override
  String get reportConditionsHint => 'Temperatura y humedad de un sensor.';

  @override
  String get reportAudit => 'Auditoría';

  @override
  String get reportAuditHint => 'Acciones registradas en el sistema.';

  @override
  String get reportFormat => 'Formato';

  @override
  String get formatPdf => 'PDF';

  @override
  String get formatExcel => 'Excel';

  @override
  String get formatCsv => 'CSV';

  @override
  String get reportGenerate => 'Generar reporte';

  @override
  String get reportDateFrom => 'Desde';

  @override
  String get reportDateTo => 'Hasta';

  @override
  String get reportDays => 'Días a considerar';

  @override
  String get reportSensor => 'Sensor';

  @override
  String get reportMovementType => 'Tipo de movimiento';

  @override
  String get reportAnyType => 'Todos';

  @override
  String get reportPdfNeedsSensor =>
      'Para el PDF de condiciones elija un sensor.';

  @override
  String get reportDateRangeInvalid =>
      'La fecha final no puede ser anterior a la inicial.';

  @override
  String get reportQueued =>
      'El reporte es grande y se está generando. Puede seguirlo en Mis exportaciones.';

  @override
  String get reportReady => 'Reporte generado.';

  @override
  String get exportsEmpty => 'No hay exportaciones.';

  @override
  String get exportQueued => 'En cola';

  @override
  String get exportProcessing => 'Procesando';

  @override
  String get exportReady => 'Listo';

  @override
  String get exportFailed => 'Falló';

  @override
  String get exportExpired => 'Vencido';

  @override
  String get exportDownload => 'Descargar';

  @override
  String get exportShare => 'Compartir';

  @override
  String get exportOpen => 'Abrir';

  @override
  String exportCreatedAt(String date) {
    return 'Creado $date';
  }

  @override
  String exportSize(String size) {
    return '$size KB';
  }

  @override
  String get exportGone =>
      'El reporte venció. Genérelo de nuevo desde Reportes.';

  @override
  String get exportFailedDetail => 'No se pudo generar el reporte.';

  @override
  String get readingsExportAction => 'Exportar lecturas (Excel)';

  @override
  String get purchasingTabOrders => 'Compras';

  @override
  String get purchasingTabExpenses => 'Gastos';

  @override
  String get purchasingTabSuggestions => 'Sugerencias';

  @override
  String get purchasingTabConsolidated => 'Consolidadas';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterAnyPayment => 'Cualquier pago';

  @override
  String get purchaseOrdersEmpty => 'No hay órdenes de compra para mostrar.';

  @override
  String get expenseOrdersEmpty => 'No hay órdenes de gasto para mostrar.';

  @override
  String get statusUnknown => 'Sin clasificar';

  @override
  String get orderStatusDraft => 'Borrador';

  @override
  String get orderStatusPendingApproval => 'Por aprobar';

  @override
  String get orderStatusApproved => 'Aprobada';

  @override
  String get orderStatusRejected => 'Rechazada';

  @override
  String get orderStatusSent => 'Enviada';

  @override
  String get orderStatusPartiallyReceived => 'Recibida parcial';

  @override
  String get orderStatusReceived => 'Recibida';

  @override
  String get orderStatusCancelled => 'Cancelada';

  @override
  String get paymentUnpaid => 'Sin pagar';

  @override
  String get paymentPartial => 'Pago parcial';

  @override
  String get paymentPaid => 'Pagada';

  @override
  String get paymentMethodCash => 'Efectivo';

  @override
  String get paymentMethodTransfer => 'Transferencia';

  @override
  String get paymentMethodCheck => 'Cheque';

  @override
  String get paymentMethodOther => 'Otro';

  @override
  String get orderDetailTitle => 'Orden';

  @override
  String get orderWarehouse => 'Almacén de destino';

  @override
  String get orderCostCenter => 'Centro de costo';

  @override
  String get orderExpectedDate => 'Entrega esperada';

  @override
  String get orderCreatedAt => 'Creada';

  @override
  String get orderSentAt => 'Enviada';

  @override
  String get orderReceivedAt => 'Recibida';

  @override
  String get orderNotes => 'Notas';

  @override
  String get orderLines => 'Productos';

  @override
  String get orderSubtotal => 'Subtotal';

  @override
  String get orderTax => 'Impuestos';

  @override
  String get orderTotal => 'Total';

  @override
  String get orderSubmit => 'Enviar a aprobación';

  @override
  String get orderSubmitted => 'La orden quedó pendiente de aprobación.';

  @override
  String get orderApprove => 'Aprobar';

  @override
  String get orderApproveTitle => 'Aprobar orden';

  @override
  String get orderApproved => 'Orden aprobada.';

  @override
  String get orderReject => 'Rechazar';

  @override
  String get orderRejectTitle => 'Rechazar orden';

  @override
  String get orderRejected => 'Orden rechazada.';

  @override
  String get orderSend => 'Enviar al proveedor';

  @override
  String get orderSentMessage => 'Orden enviada al proveedor.';

  @override
  String get orderReceive => 'Recibir mercancía';

  @override
  String get orderReceiveTitle => 'Recibir mercancía';

  @override
  String get orderReceiveConfirm => 'Confirmar recepción';

  @override
  String get orderReceived => 'Recepción registrada.';

  @override
  String get orderReceiveHint =>
      'Escriba la cantidad que recibe de cada producto. Las líneas sin cantidad se omiten; si recibe menos de lo pedido, la orden queda como recibida parcial.';

  @override
  String get orderReceiveNothing =>
      'Escriba la cantidad recibida de al menos un producto.';

  @override
  String get orderNothingPending =>
      'Esta orden no tiene productos pendientes de recibir.';

  @override
  String get orderQuantityExceedsPending =>
      'No puede recibir más de lo que está pendiente.';

  @override
  String get orderNoWarehouse =>
      'La orden no tiene almacén de destino; no se pueden elegir ubicaciones.';

  @override
  String get orderCancel => 'Cancelar orden';

  @override
  String get orderCancelTitle => 'Cancelar orden';

  @override
  String get orderCancelBody =>
      'La orden quedará cancelada y no se podrá reactivar. ¿Desea continuar?';

  @override
  String get orderCancelled => 'Orden cancelada.';

  @override
  String get orderTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, actualice la orden: es posible que el cambio sí se haya registrado.';

  @override
  String get fieldSupplier => 'Proveedor';

  @override
  String get fieldQuantityReceived => 'Cantidad recibida';

  @override
  String get fieldCommentsOptional => 'Comentarios (opcional)';

  @override
  String get fieldInvoiceNumber => 'Número de factura';

  @override
  String get fieldInvoiceDate => 'Fecha de factura';

  @override
  String get fieldAmount => 'Valor';

  @override
  String get fieldPaymentMethod => 'Forma de pago';

  @override
  String get fieldPaymentDate => 'Fecha de pago';

  @override
  String get fieldReference => 'Referencia (opcional)';

  @override
  String get expenseInvoiceTitle => 'Registrar factura';

  @override
  String get expenseRegisterInvoice => 'Registrar factura';

  @override
  String get expenseInvoiceSaved => 'Factura registrada.';

  @override
  String get expenseSendAccounting => 'Enviar a contabilidad';

  @override
  String get expenseAccountingTitle => 'Enviar a contabilidad';

  @override
  String get expenseAccountingSent => 'Orden enviada a contabilidad.';

  @override
  String get expenseAccountingSentAt => 'Enviada a contabilidad';

  @override
  String get expensePayments => 'Pagos';

  @override
  String get expensePaid => 'Pagado';

  @override
  String get expenseBalance => 'Saldo pendiente';

  @override
  String get expensePaymentsEmpty => 'Aún no hay pagos registrados.';

  @override
  String get expenseAddPayment => 'Registrar pago';

  @override
  String get expensePaymentTitle => 'Registrar pago';

  @override
  String get expensePaymentSaved => 'Pago registrado.';

  @override
  String get expenseAmountExceeds =>
      'El valor no puede superar el saldo pendiente.';

  @override
  String get expenseDeletePayment => 'Eliminar pago';

  @override
  String get expenseDeletePaymentBody =>
      'El pago se eliminará y el saldo de la orden se recalculará. ¿Desea continuar?';

  @override
  String get expensePaymentDeleted => 'Pago eliminado.';

  @override
  String get suggestionsEmpty =>
      'Ningún producto está por debajo de su punto de reorden.';

  @override
  String get consolidatedEmpty => 'Aún no hay órdenes consolidadas.';

  @override
  String get consolidateAction => 'Consolidar órdenes';

  @override
  String get consolidateTitle => 'Consolidar órdenes';

  @override
  String get consolidatePreview => 'Ver vista previa';

  @override
  String get consolidateOrders => 'Órdenes recibidas';

  @override
  String get consolidateNoSuppliers =>
      'No hay órdenes recibidas pendientes de consolidar.';

  @override
  String get consolidateConfirmTitle => 'Crear orden consolidada';

  @override
  String get consolidateCreated => 'Orden consolidada creada.';

  @override
  String get consolidatedDetailTitle => 'Orden consolidada';

  @override
  String get consolidatedPeriod => 'Periodo';

  @override
  String orderQuantity(String quantity) {
    return 'Cantidad: $quantity';
  }

  @override
  String orderQuantities(String requested, String received) {
    return 'Pedido: $requested · Recibido: $received';
  }

  @override
  String orderUnitPrice(String price) {
    return '$price c/u';
  }

  @override
  String orderPendingQuantity(String quantity) {
    return 'Pendiente por recibir: $quantity';
  }

  @override
  String expenseBalanceHint(String balance) {
    return 'Saldo pendiente: $balance';
  }

  @override
  String suggestionStock(String stock, String reorder) {
    return 'Existencias: $stock · Punto de reorden: $reorder';
  }

  @override
  String suggestionSupplier(String name) {
    return 'Proveedor sugerido: $name';
  }

  @override
  String suggestionLeadTime(int days) {
    return 'Entrega estimada: $days días';
  }

  @override
  String suggestionQuantity(String quantity) {
    return 'Cantidad sugerida: $quantity';
  }

  @override
  String consolidateConfirmBody(int count) {
    return 'Se consolidarán $count órdenes recibidas en una sola. ¿Desea continuar?';
  }

  @override
  String periodRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get loadMore => 'Cargar más';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get assetStatusOperational => 'Operativo';

  @override
  String get assetStatusMaintenance => 'En mantenimiento';

  @override
  String get assetStatusOutOfService => 'Fuera de servicio';

  @override
  String get assetStatusAvailable => 'Disponible';

  @override
  String get assetStatusRetired => 'Dado de baja';

  @override
  String get assetTypeBiomedical => 'Biomédico';

  @override
  String get assetTypeComputing => 'Cómputo';

  @override
  String get assetTypeGeneral => 'General';

  @override
  String get assetScanAction => 'Escanear etiqueta';

  @override
  String get assetSearchHint => 'Buscar por nombre o código';

  @override
  String get assetsEmpty => 'No hay activos para mostrar.';

  @override
  String get assetFilterOverdue => 'Mantenimiento vencido';

  @override
  String get assetStatTotal => 'Activos';

  @override
  String get assetStatInMaintenance => 'En mantenimiento';

  @override
  String get assetStatOverdue => 'Mantenimientos vencidos';

  @override
  String get assetStatPendingTransfers => 'Traslados pendientes';

  @override
  String get assetStatOffPremises => 'Fuera de las instalaciones';

  @override
  String get assetDetailTitle => 'Activo';

  @override
  String get assetTabData => 'Datos';

  @override
  String get assetTabHistory => 'Historial';

  @override
  String get assetTabComments => 'Comentarios';

  @override
  String get assetCode => 'Código';

  @override
  String get assetType => 'Tipo';

  @override
  String get assetCategory => 'Categoría';

  @override
  String get assetLocation => 'Ubicación actual';

  @override
  String get assetResponsible => 'Responsable';

  @override
  String get assetBrand => 'Marca';

  @override
  String get assetModel => 'Modelo';

  @override
  String get assetSerial => 'Serie';

  @override
  String get assetSupplier => 'Proveedor';

  @override
  String get assetInvoice => 'Factura';

  @override
  String get assetAcquisition => 'Fecha de adquisición';

  @override
  String get assetAcquisitionValue => 'Valor de adquisición';

  @override
  String get assetWarrantyUntil => 'Garantía hasta';

  @override
  String get assetDescription => 'Descripción';

  @override
  String get assetRetiredAt => 'Fecha de baja';

  @override
  String get assetRetirementReason => 'Motivo de la baja';

  @override
  String get assetTechnicalProfile => 'Perfil técnico';

  @override
  String get assetLifeSheet => 'Hoja de vida (PDF)';

  @override
  String get assetLocationHistory => 'Historial de ubicaciones';

  @override
  String get assetLocationHistoryEmpty => 'Sin ubicaciones registradas.';

  @override
  String get assetUntilNow => 'hoy';

  @override
  String get assetCurrent => 'Actual';

  @override
  String get assetEvents => 'Bitácora';

  @override
  String get assetEventsEmpty => 'Aún no hay eventos registrados.';

  @override
  String get assetCommentsEmpty => 'Este activo no tiene comentarios.';

  @override
  String get assetCommentField => 'Escriba un comentario';

  @override
  String get assetCommentAdd => 'Agregar comentario';

  @override
  String get assetCommentAdded => 'Comentario agregado.';

  @override
  String get assetCommentTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, revise los comentarios: es posible que sí se haya agregado.';

  @override
  String get techManufacturer => 'Fabricante';

  @override
  String get techCountry => 'País de origen';

  @override
  String get techYear => 'Año de fabricación';

  @override
  String get techUsefulLife => 'Vida útil (años)';

  @override
  String get techAcquisitionMode => 'Forma de adquisición';

  @override
  String get techAccessories => 'Accesorios';

  @override
  String get techRecommendations => 'Recomendaciones de uso';

  @override
  String get techInvima => 'Registro INVIMA';

  @override
  String get techRiskClass => 'Clasificación de riesgo';

  @override
  String get techBiomedicalClass => 'Clase biomédica';

  @override
  String get techPowerSource => 'Fuente de energía';

  @override
  String get techVoltage => 'Voltaje';

  @override
  String get techCurrent => 'Corriente';

  @override
  String get techPower => 'Potencia';

  @override
  String get techFrequency => 'Frecuencia';

  @override
  String get techRequiresCalibration => 'Requiere calibración';

  @override
  String get techOperatingConditions => 'Condiciones de operación';

  @override
  String get techProcessor => 'Procesador';

  @override
  String get techRam => 'Memoria RAM';

  @override
  String get techStorage => 'Almacenamiento';

  @override
  String get techOperatingSystem => 'Sistema operativo';

  @override
  String get techIp => 'Dirección IP';

  @override
  String get techMac => 'Dirección MAC';

  @override
  String get techHostname => 'Nombre de equipo';

  @override
  String assetScanNotFound(String code) {
    return 'No hay un activo con el código $code.';
  }

  @override
  String assetMaintenanceOverdueOn(String date) {
    return 'Mantenimiento vencido desde el $date';
  }

  @override
  String assetPendingTransfer(String type) {
    return 'Traslado pendiente de firma: $type';
  }

  @override
  String get assetsTabAssets => 'Activos';

  @override
  String get assetsTabTransfers => 'Traslados';

  @override
  String get transfersEmpty => 'No hay traslados para mostrar.';

  @override
  String get transferStatusPending => 'Pendiente de firma';

  @override
  String get transferStatusConfirmed => 'Confirmado';

  @override
  String get transferStatusCancelled => 'Cancelado';

  @override
  String get transferTypeRelocation => 'Traslado interno';

  @override
  String get transferTypeExternalRepair => 'Salida a reparación externa';

  @override
  String get transferTypeLoan => 'Préstamo externo';

  @override
  String get transferTypeReturn => 'Retorno a las instalaciones';

  @override
  String get transferTypeRetirement => 'Baja';

  @override
  String get transferDetailTitle => 'Traslado';

  @override
  String get transferFrom => 'Origen';

  @override
  String get transferTo => 'Destino';

  @override
  String get transferExternalDestination => 'Destino externo';

  @override
  String get transferFromResponsible => 'Responsable anterior';

  @override
  String get transferToResponsible => 'Nuevo responsable';

  @override
  String get transferExpectedReturn => 'Retorno esperado';

  @override
  String get transferReason => 'Motivo';

  @override
  String get transferRequestedBy => 'Solicitado por';

  @override
  String get transferConfirmedAt => 'Confirmado';

  @override
  String get transferCancelReason => 'Motivo de la cancelación';

  @override
  String get transferAct => 'Acta del traslado (PDF)';

  @override
  String get transferCancel => 'Cancelar traslado';

  @override
  String get transferCancelTitle => 'Cancelar traslado';

  @override
  String get transferCancelled => 'Traslado cancelado.';

  @override
  String get transferConfirmed => 'Traslado confirmado.';

  @override
  String get transferTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, actualice el traslado: es posible que el cambio sí se haya registrado.';

  @override
  String get transferRequestTitle => 'Solicitar traslado';

  @override
  String get transferRequestAction => 'Solicitar traslado';

  @override
  String get transferType => 'Tipo de traslado';

  @override
  String get transferNeedsSignature =>
      'Este tipo de traslado queda pendiente hasta que se confirme con las firmas de quien entrega y de quien recibe.';

  @override
  String get transferSite => 'Sede';

  @override
  String get transferPlace => 'Lugar';

  @override
  String get transferNewResponsible => 'Nuevo responsable';

  @override
  String get transferKeepResponsible => 'Mantener el actual';

  @override
  String get transferReasonOptional => 'Motivo (opcional)';

  @override
  String get transferRequestedPending =>
      'Traslado solicitado. Falta confirmarlo con las firmas.';

  @override
  String get transferApplied => 'Traslado aplicado.';

  @override
  String get maintenanceStatusScheduled => 'Programado';

  @override
  String get maintenanceStatusOverdue => 'Vencido';

  @override
  String get maintenanceStatusInProgress => 'En curso';

  @override
  String get maintenanceStatusCompleted => 'Realizado';

  @override
  String get maintenanceStatusCancelled => 'Cancelado';

  @override
  String get maintenanceTypePreventive => 'Preventivo';

  @override
  String get maintenanceTypeCalibration => 'Calibración';

  @override
  String get maintenanceTypeMetrological => 'Verificación metrológica';

  @override
  String get maintenanceTypeInspection => 'Inspección';

  @override
  String get maintenanceTypeCorrective => 'Correctivo';

  @override
  String get maintenanceResultOperational => 'Operativo';

  @override
  String get maintenanceResultRestricted => 'Operativo con restricciones';

  @override
  String get maintenanceResultOutOfService => 'Fuera de servicio';

  @override
  String get maintenanceEmpty => 'No hay mantenimientos para mostrar.';

  @override
  String get maintenanceDetailTitle => 'Mantenimiento';

  @override
  String get maintenanceScheduledDate => 'Fecha programada';

  @override
  String get maintenanceStartedAt => 'Iniciado';

  @override
  String get maintenancePerformedAt => 'Fecha de ejecución';

  @override
  String get maintenanceReportedFailure => 'Falla reportada';

  @override
  String get maintenanceTechnician => 'Técnico';

  @override
  String get maintenanceActivities => 'Actividades realizadas';

  @override
  String get maintenanceFindings => 'Hallazgos (opcional)';

  @override
  String get maintenanceRecommendations => 'Recomendaciones (opcional)';

  @override
  String get maintenanceResult => 'Resultado';

  @override
  String get maintenanceCost => 'Costo (opcional)';

  @override
  String get maintenanceParts => 'Repuestos cambiados';

  @override
  String get maintenanceStart => 'Iniciar mantenimiento';

  @override
  String get maintenanceStartTitle => 'Iniciar mantenimiento';

  @override
  String get maintenanceStartBody =>
      'El activo pasará a \"En mantenimiento\". ¿Desea continuar?';

  @override
  String get maintenanceStarted => 'Mantenimiento iniciado.';

  @override
  String get maintenanceComplete => 'Registrar ejecución';

  @override
  String get maintenanceCompleteAction => 'Registrar ejecución';

  @override
  String get maintenanceCompleted => 'Ejecución registrada.';

  @override
  String get maintenanceCancel => 'Cancelar mantenimiento';

  @override
  String get maintenanceCancelTitle => 'Cancelar mantenimiento';

  @override
  String get maintenanceCancelled => 'Mantenimiento cancelado.';

  @override
  String get maintenanceReport => 'Reporte del mantenimiento (PDF)';

  @override
  String get maintenanceTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, actualice el mantenimiento: es posible que el cambio sí se haya registrado.';

  @override
  String get maintenanceInternal => 'Técnico interno';

  @override
  String get maintenanceExternal => 'Proveedor externo';

  @override
  String get maintenanceExternalTechnician => 'Nombre del técnico externo';

  @override
  String get maintenancePartAdd => 'Agregar repuesto';

  @override
  String get maintenancePartName => 'Repuesto';

  @override
  String get maintenancePartRemove => 'Quitar repuesto';

  @override
  String get assetViewMaintenance => 'Ver mantenimiento';

  @override
  String maintenanceScheduledFor(String date) {
    return 'Programado para el $date';
  }

  @override
  String get assetTabDocuments => 'Documentos';

  @override
  String get assetDocumentsEmpty => 'Este activo no tiene documentos.';

  @override
  String get assetDocumentAdd => 'Agregar documento';

  @override
  String get assetDocumentTakePhoto => 'Tomar una foto';

  @override
  String get assetDocumentGallery => 'Elegir de la galería';

  @override
  String get assetDocumentFile => 'Elegir un archivo (PDF o imagen)';

  @override
  String get assetDocumentTooLarge =>
      'El archivo supera los 10 MB. Elija uno más liviano.';

  @override
  String get assetDocumentExpired => 'Vencido';

  @override
  String get assetDocumentDelete => 'Eliminar documento';

  @override
  String get assetDocumentDeleteBody =>
      'El documento se eliminará del activo. ¿Desea continuar?';

  @override
  String get assetDocumentDeleted => 'Documento eliminado.';

  @override
  String get assetDocumentType => 'Tipo de documento';

  @override
  String get assetDocumentTitle => 'Título';

  @override
  String get assetDocumentIssued => 'Fecha de emisión (opcional)';

  @override
  String get assetDocumentExpiry => 'Fecha de vencimiento (opcional)';

  @override
  String get assetDocumentUpload => 'Subir documento';

  @override
  String get assetDocumentUploaded => 'Documento agregado.';

  @override
  String get assetDocumentTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, revise los documentos del activo: es posible que sí se haya subido.';

  @override
  String assetDocumentExpires(String date) {
    return 'Vence el $date';
  }

  @override
  String get assetChangeStatus => 'Cambiar estado';

  @override
  String get assetNewStatus => 'Estado nuevo';

  @override
  String get assetStatusReason => 'Motivo (opcional)';

  @override
  String get assetStatusChanged => 'Estado actualizado.';

  @override
  String get assetStatusTimeoutWarning =>
      'No se recibió respuesta del servidor. Antes de repetirlo, actualice la ficha: es posible que el estado sí haya cambiado.';

  @override
  String get assetMaintenancePlans => 'Planes de mantenimiento';

  @override
  String get planUnitDays => 'días';

  @override
  String get planUnitMonths => 'meses';

  @override
  String get planInactive => 'Inactivo';

  @override
  String planEvery(int value, String unit) {
    return 'Cada $value $unit';
  }

  @override
  String planNext(String date) {
    return 'Próximo: $date';
  }

  @override
  String get clinicalTabRecords => 'Registros';

  @override
  String get clinicalTabPatients => 'Pacientes';

  @override
  String get clinicalRecordsSearchHint => 'Documento del paciente';

  @override
  String clinicalRecordsEmpty(int days) {
    return 'No hay registros en los últimos $days días.';
  }

  @override
  String get clinicalPatientSearchHint => 'Documento o nombre del paciente';

  @override
  String clinicalPatientSearchPrompt(int count) {
    return 'Escriba al menos $count caracteres del documento o del nombre del paciente.';
  }

  @override
  String get clinicalPatientTitle => 'Paciente';

  @override
  String clinicalPatientDocument(String document) {
    return 'Documento $document';
  }

  @override
  String get clinicalHistoryTitle => 'Historial de procedimientos';

  @override
  String get clinicalHistoryEmpty =>
      'Este paciente no tiene procedimientos registrados.';

  @override
  String get clinicalSummaryRecords => 'Procedimientos';

  @override
  String get clinicalSummaryAmount => 'Total registrado';

  @override
  String get clinicalSummaryFirst => 'Primera atención';

  @override
  String get clinicalSummaryLast => 'Última atención';

  @override
  String get clinicalAppointmentsTitle => 'Citas activas';

  @override
  String get clinicalAppointmentsEmpty => 'No tiene citas activas.';

  @override
  String get clinicalRecentAppointmentsTitle => 'Últimas citas';

  @override
  String get clinicalRecordTitle => 'Registro de procedimiento';

  @override
  String get clinicalRecordService => 'Servicio';

  @override
  String get clinicalRecordPatient => 'Paciente';

  @override
  String get clinicalRecordDocument => 'Documento';

  @override
  String get clinicalRecordDate => 'Fecha de atención';

  @override
  String get clinicalRecordQuantity => 'Cantidad';

  @override
  String get clinicalRecordUnitPrice => 'Valor unitario';

  @override
  String get clinicalRecordTotal => 'Total';

  @override
  String get clinicalRecordDiscount => 'Descuento';

  @override
  String get clinicalRecordNetTotal => 'Total neto';

  @override
  String get clinicalRecordBilling => 'Facturación';

  @override
  String get clinicalRecordOrder => 'Orden de servicio';

  @override
  String get clinicalRecordSeller => 'Vendedor';

  @override
  String get clinicalRecordReferrer => 'Remitente';

  @override
  String get clinicalRecordInactive => 'Inactivo';

  @override
  String get clinicalViewHistory => 'Ver historial del paciente';

  @override
  String get billingPending => 'Sin facturar';

  @override
  String get billingBilled => 'Facturado';

  @override
  String get billingCancelled => 'Anulado';

  @override
  String get saleTitle => 'Registrar venta';

  @override
  String get saleAction => 'Registrar venta';

  @override
  String get saleChoosePatient => 'Elegir paciente';

  @override
  String get saleSearchPatient => 'Buscar paciente';

  @override
  String get saleChangePatient => 'Cambiar paciente';

  @override
  String get salePatientRequired => 'Elija el paciente al que se le vende.';

  @override
  String get saleServiceDate => 'Fecha de atención';

  @override
  String get saleSeller => 'Vendedor';

  @override
  String get saleReferrer => 'Remitente';

  @override
  String get saleServicesTitle => 'Servicios';

  @override
  String get saleAddService => 'Agregar servicio';

  @override
  String get saleChooseService => 'Elegir servicio';

  @override
  String get saleServiceSearchHint => 'Nombre o código del servicio';

  @override
  String saleServiceSearchPrompt(int count) {
    return 'Escriba al menos $count caracteres del nombre o del código.';
  }

  @override
  String get saleNoPrice => 'Sin tarifa';

  @override
  String get saleServicesRequired => 'Agregue al menos un servicio.';

  @override
  String get saleQuantity => 'Cantidad';

  @override
  String get saleUnitPrice => 'Valor unitario';

  @override
  String get saleTotal => 'Total de la venta';

  @override
  String get saleSubmit => 'Registrar venta';

  @override
  String get saleLineSaved => 'Registrado';

  @override
  String get saleLineFailed => 'No se registró';

  @override
  String get saleLineUnconfirmed => 'Sin confirmar';

  @override
  String get saleLineUnconfirmedHelp =>
      'El servidor no respondió y puede que sí se haya registrado. Revise los registros del paciente antes de enviarla de nuevo.';

  @override
  String get saleLineNotRegistered => 'No se registró, enviar de nuevo';

  @override
  String get salePartialWarning =>
      'Algunos servicios ya quedaron registrados y no se vuelven a enviar. Corrija lo pendiente y registre de nuevo.';

  @override
  String get saleDone => 'Venta registrada.';

  @override
  String get serviceOrderTabOrders => 'Órdenes';

  @override
  String get serviceOrderTabDiscounts => 'Descuentos';

  @override
  String get serviceOrderNew => 'Nueva orden';

  @override
  String get serviceOrderTitle => 'Orden de servicio';

  @override
  String get serviceOrderStatusApproved => 'Aprobada';

  @override
  String get serviceOrderStatusDiscountPending => 'Descuento por aprobar';

  @override
  String get serviceOrderPatient => 'Paciente';

  @override
  String get serviceOrderProcedures => 'Procedimientos';

  @override
  String get serviceOrderTotal => 'Total';

  @override
  String get serviceOrderDiscount => 'Descuento';

  @override
  String get serviceOrderNetTotal => 'Total neto';

  @override
  String get serviceOrderApproveDiscount => 'Aprobar descuento';

  @override
  String serviceOrderApproveConfirm(String amount, String number) {
    return 'Se aprobará el descuento de $amount de la orden $number.';
  }

  @override
  String get serviceOrderApproved => 'Descuento aprobado.';

  @override
  String get serviceOrderBill => 'Marcar como facturada';

  @override
  String serviceOrderBillConfirm(String number) {
    return 'La orden $number quedará como facturada.';
  }

  @override
  String get serviceOrderBilled => 'Orden facturada.';

  @override
  String get serviceOrderBillBlocked =>
      'Apruebe el descuento antes de facturar.';

  @override
  String get serviceOrderCancel => 'Anular orden';

  @override
  String serviceOrderCancelConfirm(String number) {
    return 'Se anulará la orden $number. Los insumos que ya salieron volverán al inventario.';
  }

  @override
  String get serviceOrderCancelled => 'Orden anulada.';

  @override
  String get serviceOrderActionTimeout =>
      'No se recibió respuesta del servidor. Revise el estado de la orden antes de repetirlo.';

  @override
  String get serviceOrderDiscountsEmpty =>
      'No hay descuentos pendientes de aprobación.';

  @override
  String serviceOrderDiscountOf(String amount) {
    return 'Descuento: $amount';
  }

  @override
  String get serviceOrderFormTitle => 'Nueva orden de servicio';

  @override
  String get serviceOrderNotes => 'Observaciones (opcional)';

  @override
  String get serviceOrderDiscountToggle => 'Aplicar descuento';

  @override
  String get serviceOrderDiscountType => 'Tipo de descuento';

  @override
  String get serviceOrderDiscountPercent => 'Porcentaje';

  @override
  String get serviceOrderDiscountFixed => 'Valor fijo';

  @override
  String get serviceOrderDiscountPercentValue => 'Porcentaje (%)';

  @override
  String get serviceOrderDiscountFixedValue => 'Valor del descuento';

  @override
  String get serviceOrderDiscountInvalid =>
      'Debe ser mayor que cero y menor que el total del procedimiento.';

  @override
  String get serviceOrderDiscountPercentInvalid => 'Debe estar entre 0 y 100.';

  @override
  String get serviceOrderDiscountNote =>
      'Un descuento deja la orden pendiente hasta que un aprobador lo autorice.';

  @override
  String get serviceOrderSupplies => 'Insumos';

  @override
  String get serviceOrderAddSupply => 'Agregar insumo';

  @override
  String get serviceOrderChooseSupply => 'Elegir insumo';

  @override
  String get serviceOrderSupplyWarehouse => 'Almacén de donde salen';

  @override
  String get serviceOrderSupplyQuantity => 'Cantidad';

  @override
  String get serviceOrderSupplyNote =>
      'Los insumos salen del inventario al crear la orden.';

  @override
  String get serviceOrderSupplyWarehouseRequired =>
      'Elija el almacén de los insumos.';

  @override
  String get serviceOrderSubmit => 'Crear orden';

  @override
  String serviceOrderCreated(String number) {
    return 'Orden $number creada.';
  }

  @override
  String get serviceOrderUnconfirmed =>
      'No se recibió respuesta del servidor. La orden pudo haberse creado: revise los registros del paciente antes de repetirla.';

  @override
  String get serviceOrderNotCreated => 'Ya revisé: no se creó, enviar de nuevo';

  @override
  String get serviceOrderMaybePartial =>
      'Si el servidor falló al guardar, la orden pudo quedar a medias (con algunos procedimientos o insumos ya registrados). Revise los registros del paciente antes de repetirla.';

  @override
  String get clinicalEvolutionsTitle => 'Evoluciones clínicas';

  @override
  String get clinicalEvolutionsEmpty => 'Este registro no tiene evoluciones.';

  @override
  String get clinicalEvolutionAdd => 'Agregar evolución';

  @override
  String get clinicalEvolutionEdit => 'Editar evolución';

  @override
  String get clinicalEvolutionNewTitle => 'Nueva evolución';

  @override
  String get clinicalEvolutionEditTitle => 'Editar evolución';

  @override
  String get clinicalEvolutionField => 'Evolución clínica';

  @override
  String get clinicalEvolutionSave => 'Guardar evolución';

  @override
  String get clinicalEvolutionSaved => 'Evolución guardada.';

  @override
  String get clinicalEvolutionTemplateLoaded =>
      'Se cargó la plantilla del servicio. Ajústela antes de guardar.';

  @override
  String clinicalEvolutionBy(String author, String date) {
    return '$author · $date';
  }

  @override
  String get clinicalEvolutionTimeout =>
      'No se recibió respuesta del servidor. Revise las evoluciones del registro antes de repetirlo: es posible que sí se haya guardado.';

  @override
  String get clinicalEvolutionFormatNote =>
      'La app guarda el texto sin formato (negritas ni listas).';

  @override
  String get clinicalMedicationsTitle => 'Medicamentos aplicados';

  @override
  String clinicalMedicationDetail(String lot, String date) {
    return 'Lote $lot · vence $date';
  }

  @override
  String get orderEvolutionLabel => 'Evolución clínica';

  @override
  String orderEvolutionHelp(int max) {
    return 'Obligatoria. Máximo $max caracteres en total.';
  }

  @override
  String get orderEvolutionRequired =>
      'Escriba la evolución clínica del procedimiento.';

  @override
  String orderEvolutionTooLong(int max) {
    return 'La evolución es demasiado larga (máximo $max caracteres).';
  }

  @override
  String orderEvolutionCounter(int used, int max) {
    return '$used de $max';
  }

  @override
  String get costCentersTabCenters => 'Centros de costo';

  @override
  String get costCentersTabServices => 'Servicios';

  @override
  String get costCentersSearchHint => 'Nombre o código del centro';

  @override
  String get costCentersEmpty => 'No hay centros de costo.';

  @override
  String get costCenterExternal => 'Externo';

  @override
  String get costCenterInternal => 'Interno';

  @override
  String get servicesEmpty => 'No hay servicios registrados.';

  @override
  String servicePricesTitle(String name) {
    return 'Tarifas de $name';
  }

  @override
  String get servicePricesEmpty =>
      'Este procedimiento no tiene tarifas registradas.';

  @override
  String get servicePriceCurrent => 'Vigente';

  @override
  String servicePriceFrom(String date) {
    return 'Desde $date';
  }

  @override
  String servicePriceUntil(String date) {
    return 'hasta $date';
  }

  @override
  String get consumptionsTabList => 'Consumos';

  @override
  String get consumptionsTabProjection => 'Proyección';

  @override
  String get consumptionsEmpty => 'No hay consumos registrados.';

  @override
  String get syncPending => 'Pendiente';

  @override
  String get syncSynced => 'Sincronizado';

  @override
  String get syncFailed => 'Fallido';

  @override
  String get consumptionNew => 'Nuevo consumo';

  @override
  String get consumptionDetailTitle => 'Consumo';

  @override
  String get consumptionProductUnknown => 'Insumo';

  @override
  String get consumptionLot => 'Lote';

  @override
  String consumptionLotValue(String lot) {
    return 'Lote $lot';
  }

  @override
  String get consumptionQuantity => 'Cantidad';

  @override
  String get consumptionDate => 'Fecha del consumo';

  @override
  String get consumptionSyncedAt => 'Sincronizado el';

  @override
  String get consumptionAppointment => 'Cita';

  @override
  String get consumptionPatient => 'Paciente';

  @override
  String get consumptionServiceType => 'Servicio';

  @override
  String get consumptionSyncStatus => 'Historia clínica';

  @override
  String get consumptionRetrySync => 'Reintentar sincronización';

  @override
  String get consumptionRetryConfirm =>
      'Se volverá a enviar el consumo a la historia clínica.';

  @override
  String get consumptionRetryQueued => 'Sincronización reencolada.';

  @override
  String get consumptionRetryTimeout =>
      'No se recibió respuesta del servidor. Actualice el consumo antes de repetirlo: es posible que sí se haya reencolado.';

  @override
  String get consumptionFormTitle => 'Registrar consumo';

  @override
  String get consumptionWarehouse => 'Almacén';

  @override
  String get consumptionCostCenter => 'Centro de costo';

  @override
  String get consumptionAppointmentField => 'Código de la cita (opcional)';

  @override
  String get consumptionPatientField =>
      'Identificación del paciente (opcional)';

  @override
  String get consumptionServiceField => 'Servicio (opcional)';

  @override
  String get consumptionSyncNote =>
      'Con cita y paciente, el consumo también se envía a la historia clínica.';

  @override
  String get consumptionItemsTitle => 'Insumos';

  @override
  String get consumptionItemsRequired => 'Agregue al menos un insumo.';

  @override
  String get consumptionSubmit => 'Registrar consumo';

  @override
  String get consumptionSaved => 'Consumo registrado.';

  @override
  String get consumptionUnconfirmed =>
      'No se recibió respuesta del servidor. El consumo pudo haberse registrado: revise la lista de consumos antes de repetirlo.';

  @override
  String get consumptionNotSaved =>
      'Ya revisé: no se registró, enviar de nuevo';

  @override
  String projectionDays(int days) {
    return '$days días';
  }

  @override
  String get projectionEmpty => 'No hay citas futuras con consumo previsto.';

  @override
  String projectionAverage(int count, String avg) {
    return '$count citas · promedio $avg por cita';
  }

  @override
  String projectionUnits(int units) {
    return '$units u.';
  }

  @override
  String get projectionNote =>
      'Estimado con las citas futuras de MedSys y el promedio de los últimos 90 días.';

  @override
  String get auditPeriodToday => 'Hoy';

  @override
  String get auditPeriodWeek => '7 días';

  @override
  String get auditPeriodMonth => '30 días';

  @override
  String get auditActionCreated => 'Creación';

  @override
  String get auditActionUpdated => 'Modificación';

  @override
  String get auditActionDeleted => 'Eliminación';

  @override
  String get auditActionAccess => 'Acceso';

  @override
  String get auditActionOther => 'Otra acción';

  @override
  String get auditEmpty => 'No hay registros en el periodo elegido.';

  @override
  String auditSummaryTotal(int count) {
    return '$count registros';
  }

  @override
  String get auditSystemUser => 'Sistema';

  @override
  String get auditEntitySystem => 'Sistema';

  @override
  String get auditDetailTitle => 'Registro de auditoría';

  @override
  String get auditUser => 'Usuario';

  @override
  String get auditDate => 'Fecha';

  @override
  String get auditEntity => 'Elemento';

  @override
  String get auditEntityId => 'Identificador';

  @override
  String get auditIp => 'Dirección IP';

  @override
  String get auditDevice => 'Dispositivo';

  @override
  String get auditChanges => 'Cambios';

  @override
  String get auditNoChanges => 'Este registro no guarda valores.';

  @override
  String get auditValueNew => 'Nuevo';

  @override
  String get auditValueOld => 'Anterior';

  @override
  String get auditValueMasked => 'Oculto por seguridad';

  @override
  String get clinicalRecordDelete => 'Eliminar registro';

  @override
  String clinicalRecordDeleteConfirm(String service, String patient) {
    return 'Se eliminará el registro «$service» del paciente $patient. Esta acción no se puede deshacer.';
  }

  @override
  String clinicalRecordDeleteOrder(String order) {
    return 'Pertenece a la orden de servicio $order.';
  }

  @override
  String get clinicalRecordDeleted => 'Registro eliminado.';

  @override
  String get clinicalRecordDeleteTimeout =>
      'No se recibió respuesta del servidor. Revise si el registro sigue en la lista antes de repetirlo: es posible que sí se haya eliminado.';

  @override
  String get alertRuleNew => 'Nueva regla';

  @override
  String get alertRuleFormTitle => 'Nueva regla de alerta';

  @override
  String get alertRuleCondition => 'Condición';

  @override
  String get alertRuleThreshold => 'Valor límite';

  @override
  String get alertRuleConsecutive => 'Lecturas seguidas';

  @override
  String get alertRuleConsecutiveHelp => 'Entre 1 y 100.';

  @override
  String get alertRuleChannels => 'Avisar por';

  @override
  String get alertRuleChannelInternal => 'Notificación en la app';

  @override
  String get alertRuleChannelEmail => 'Correo';

  @override
  String get alertRuleChannelPush => 'Aviso al teléfono';

  @override
  String get alertRuleChannelRequired => 'Elija al menos un canal.';

  @override
  String get alertRuleSave => 'Crear regla';

  @override
  String get alertRuleCreated => 'Regla creada.';

  @override
  String get alertRuleActiveToggle => 'Regla activa';

  @override
  String get alertRuleDelete => 'Eliminar regla';

  @override
  String get alertRuleDeleteConfirm =>
      'Se eliminará esta regla de alerta. Esta acción no se puede deshacer.';

  @override
  String get alertRuleDeleted => 'Regla eliminada.';

  @override
  String get alertRuleTimeout =>
      'No se recibió respuesta del servidor. Revise la lista de reglas antes de repetirlo: es posible que sí se haya aplicado.';

  @override
  String get alertConditionAbove => 'Por encima de un valor';

  @override
  String get alertConditionBelow => 'Por debajo de un valor';

  @override
  String get maintenanceSignatures => 'Registrar firmas (opcional)';

  @override
  String get maintenanceSignaturesHelp =>
      'Firma de quien entrega el equipo y de quien lo recibe de vuelta.';

  @override
  String get productKitAvailability =>
      'Kits que se pueden armar (almacén activo)';

  @override
  String productKitAvailabilityValue(String count) {
    return '$count unidades';
  }

  @override
  String get auditEntityFilter => 'Elemento';

  @override
  String get auditAllEntities => 'Todos los elementos';

  @override
  String get orderDraftEdit => 'Editar borrador';

  @override
  String get orderDraftDelete => 'Eliminar borrador';

  @override
  String get orderDraftDeleteBody =>
      'El borrador se eliminará y no se puede deshacer.';

  @override
  String get orderDraftDeleted => 'Borrador eliminado.';

  @override
  String get orderNewPurchase => 'Nueva orden de compra';

  @override
  String get orderNewExpense => 'Nueva orden de gasto';

  @override
  String get draftPurchaseTitle => 'Nueva orden de compra';

  @override
  String get draftPurchaseEditTitle => 'Editar orden de compra';

  @override
  String get draftExpenseTitle => 'Nueva orden de gasto';

  @override
  String get draftExpenseEditTitle => 'Editar orden de gasto';

  @override
  String get draftSupplier => 'Proveedor';

  @override
  String get draftSupplierRequired => 'Elija el proveedor.';

  @override
  String get draftSupplierHintExpense =>
      'Solo proveedores habilitados para gastos.';

  @override
  String get draftWarehouse => 'Almacén que recibe';

  @override
  String get draftCostCenter => 'Centro de costo (opcional)';

  @override
  String get draftExpectedDate => 'Fecha esperada de entrega (opcional)';

  @override
  String get draftNotes => 'Observaciones (opcional)';

  @override
  String get draftItems => 'Líneas';

  @override
  String get draftItemsRequired => 'Agregue al menos una línea.';

  @override
  String get draftAddProduct => 'Agregar producto';

  @override
  String get draftAddExpenseLine => 'Agregar concepto';

  @override
  String get draftVariant => 'Marca o presentación comercial';

  @override
  String get draftPresentation => 'Presentación';

  @override
  String get draftPresentationRequired => 'Elija la presentación.';

  @override
  String get draftPickProduct => 'Elegir producto';

  @override
  String get draftNoVariants => 'Este producto no tiene variantes registradas.';

  @override
  String get draftDescription => 'Descripción';

  @override
  String get draftUnit => 'Unidad';

  @override
  String get draftQuantity => 'Cantidad';

  @override
  String get draftUnitPrice => 'Valor unitario';

  @override
  String get draftTaxRate => 'IVA % (opcional)';

  @override
  String get draftTaxInvalid => 'Debe estar entre 0 y 100.';

  @override
  String draftTotal(String amount) {
    return 'Total estimado: $amount';
  }

  @override
  String get draftSave => 'Guardar borrador';

  @override
  String get draftSaved => 'Borrador guardado.';

  @override
  String get draftTimeout =>
      'No se recibió respuesta del servidor. Revise la lista de órdenes antes de repetirlo: es posible que sí se haya guardado.';

  @override
  String get draftNotSaved => 'Ya revisé: no se guardó, enviar de nuevo';

  @override
  String get assetNewTitle => 'Nuevo activo';

  @override
  String get assetEditTitle => 'Editar activo';

  @override
  String get assetNewAction => 'Nuevo activo';

  @override
  String get assetEditAction => 'Editar datos';

  @override
  String get assetFormName => 'Nombre';

  @override
  String get assetFormPlace => 'Lugar';

  @override
  String get assetFormSite => 'Sede';

  @override
  String get assetFormInitialStatus => 'Estado inicial';

  @override
  String get assetFormInitialStatusDefault => 'Operativo (por defecto)';

  @override
  String get assetFormInitialComment => 'Comentario inicial (opcional)';

  @override
  String get assetFormKeepResponsible => 'Sin responsable';

  @override
  String get assetFormNoSupplier => 'Sin proveedor';

  @override
  String assetFormOptional(Object label) {
    return '$label (opcional)';
  }

  @override
  String get assetFormCodeInfo =>
      'El código se genera automáticamente al guardar.';

  @override
  String get assetFormLocationInfo =>
      'La ubicación y el estado se cambian después con traslados y con «Cambiar estado».';

  @override
  String get assetFormAcquisitionValueInvalid =>
      'Ingrese un valor válido, sin letras.';

  @override
  String get assetCreated => 'Activo registrado.';

  @override
  String get assetUpdated => 'Datos del activo guardados.';

  @override
  String get assetFormTimeoutWarning =>
      'No se recibió respuesta del servidor. Revise la lista de activos antes de volver a guardar para no duplicarlo.';

  @override
  String get assetDelete => 'Eliminar activo';

  @override
  String assetDeleteBody(String name) {
    return 'Se eliminará el activo $name. Use esta opción solo si lo registró por error; si ya tiene mantenimientos o traslados, el sistema no lo permitirá y deberá darlo de baja.';
  }

  @override
  String get assetDeleted => 'Activo eliminado.';

  @override
  String get assetDeleteTimeoutWarning =>
      'No se recibió respuesta del servidor. Revise la lista de activos antes de intentarlo de nuevo.';

  @override
  String get techProfileEdit => 'Editar hoja de vida técnica';

  @override
  String get techProfileTitle => 'Hoja de vida técnica';

  @override
  String get techProfileSaved => 'Hoja de vida técnica guardada.';

  @override
  String get techProfileTimeoutWarning =>
      'No se recibió respuesta del servidor. Abra la ficha del activo y revise la hoja de vida antes de volver a guardar.';

  @override
  String get techProfileGeneral => 'Datos generales';

  @override
  String get techProfileBiomedical => 'Equipo biomédico';

  @override
  String get techProfileComputing => 'Equipo de cómputo';

  @override
  String get techAcquisitionPurchase => 'Compra';

  @override
  String get techAcquisitionDonation => 'Donación';

  @override
  String get techAcquisitionComodato => 'Comodato';

  @override
  String get techAcquisitionLeasing => 'Leasing';

  @override
  String get techRiskI => 'Clase I · riesgo bajo';

  @override
  String get techRiskIIa => 'Clase IIa · riesgo moderado';

  @override
  String get techRiskIIb => 'Clase IIb · riesgo alto';

  @override
  String get techRiskIII => 'Clase III · riesgo muy alto';

  @override
  String get techClassDiagnosis => 'Diagnóstico';

  @override
  String get techClassTreatment => 'Tratamiento';

  @override
  String get techClassRehabilitation => 'Rehabilitación';

  @override
  String get techClassPrevention => 'Prevención';

  @override
  String get techClassLaboratory => 'Análisis de laboratorio';

  @override
  String get techPowerElectric => 'Eléctrica';

  @override
  String get techPowerBattery => 'Batería';

  @override
  String get techPowerPneumatic => 'Neumática';

  @override
  String get techPowerMechanical => 'Mecánica';

  @override
  String get techPowerOther => 'Otra';

  @override
  String techYearInvalid(int max) {
    return 'Ingrese un año entre 1900 y $max.';
  }

  @override
  String get techUsefulLifeInvalid => 'Ingrese de 1 a 100 años.';

  @override
  String get techIpInvalid => 'Ingrese una dirección IP válida.';

  @override
  String get techMacInvalid =>
      'Ingrese una dirección MAC válida (por ejemplo 00:1A:2B:3C:4D:5E).';

  @override
  String get techNotApplicable =>
      'La hoja de vida técnica solo aplica a equipos biomédicos y de cómputo.';

  @override
  String get maintenanceScheduleAction => 'Programar mantenimiento';

  @override
  String get maintenanceScheduleTitle => 'Programar mantenimiento';

  @override
  String get maintenanceType => 'Tipo de mantenimiento';

  @override
  String get maintenanceScheduledOn => 'Fecha programada';

  @override
  String get maintenanceReportedFailureRequired =>
      'Describa la falla reportada para el mantenimiento correctivo.';

  @override
  String get maintenancePerformer => 'Quién lo realizará';

  @override
  String get maintenancePerformerUndefined => 'Por definir';

  @override
  String get maintenanceScheduled => 'Mantenimiento programado.';

  @override
  String get maintenanceScheduleTimeoutWarning =>
      'No se recibió respuesta del servidor. Revise los mantenimientos del activo antes de volver a programarlo.';

  @override
  String get maintenanceRescheduleAction => 'Reprogramar';

  @override
  String get maintenanceRescheduleTitle => 'Reprogramar mantenimiento';

  @override
  String get maintenanceRescheduled => 'Mantenimiento reprogramado.';

  @override
  String get maintenanceRescheduleTimeoutWarning =>
      'No se recibió respuesta del servidor. Abra el mantenimiento y revise su fecha antes de volver a guardar.';

  @override
  String get planAdd => 'Agregar plan';

  @override
  String get planNewTitle => 'Nuevo plan de mantenimiento';

  @override
  String get planEditTitle => 'Editar plan de mantenimiento';

  @override
  String get planEdit => 'Editar plan';

  @override
  String get planFrequencyValue => 'Cada cuánto';

  @override
  String get planFrequencyUnit => 'Unidad';

  @override
  String get planFrequencyInvalid => 'Ingrese un número entero de 1 a 3650.';

  @override
  String get planStartDate => 'Primera fecha';

  @override
  String get planActive => 'Plan activo';

  @override
  String get planActiveHelp =>
      'Un plan inactivo deja de generar mantenimientos; no se elimina.';

  @override
  String get planCorrectiveNotPlannable =>
      'El mantenimiento correctivo no se planifica: regístrelo como mantenimiento puntual.';

  @override
  String get planSaved => 'Plan guardado.';

  @override
  String get planTimeoutWarning =>
      'No se recibió respuesta del servidor. Revise los planes del activo antes de volver a guardar.';

  @override
  String get planNotFound =>
      'No se encontró el plan. Vuelva a la ficha del activo y actualice.';

  @override
  String get optionUnset => 'Sin definir';

  @override
  String get serviceOrderSearchHint => 'Buscar por número de orden o documento';

  @override
  String get serviceOrdersEmpty => 'No hay órdenes para mostrar.';
}
