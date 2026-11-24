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
}
