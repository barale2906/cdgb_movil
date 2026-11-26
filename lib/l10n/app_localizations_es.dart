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
}
