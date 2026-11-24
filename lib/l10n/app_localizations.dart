import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// Nombre visible de la aplicación.
  ///
  /// In es, this message translates to:
  /// **'SGA Bojanini'**
  String get appTitle;

  /// No description provided for @brandSubtitle.
  ///
  /// In es, this message translates to:
  /// **'SISTEMA DE GESTIÓN DE ALMACÉN'**
  String get brandSubtitle;

  /// No description provided for @aboutTitle.
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get aboutTitle;

  /// No description provided for @aboutEnvironment.
  ///
  /// In es, this message translates to:
  /// **'Ambiente'**
  String get aboutEnvironment;

  /// No description provided for @aboutServer.
  ///
  /// In es, this message translates to:
  /// **'Servidor'**
  String get aboutServer;

  /// No description provided for @aboutUpdates.
  ///
  /// In es, this message translates to:
  /// **'Actualizaciones'**
  String get aboutUpdates;

  /// No description provided for @aboutUpdatesDisabled.
  ///
  /// In es, this message translates to:
  /// **'Desactivadas (ruta del APK pendiente)'**
  String get aboutUpdatesDisabled;

  /// No description provided for @aboutSessionPolicy.
  ///
  /// In es, this message translates to:
  /// **'Bloqueo por inactividad: {minutes} min · Cierre de sesión: {hours} h'**
  String aboutSessionPolicy(int minutes, int hours);

  /// No description provided for @envDev.
  ///
  /// In es, this message translates to:
  /// **'Desarrollo'**
  String get envDev;

  /// No description provided for @envProd.
  ///
  /// In es, this message translates to:
  /// **'Producción'**
  String get envProd;

  /// No description provided for @actionRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get actionRetry;

  /// No description provided for @actionCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get actionCancel;

  /// No description provided for @actionAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get actionAccept;

  /// No description provided for @actionClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get actionClose;

  /// No description provided for @actionContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get actionContinue;

  /// No description provided for @actionSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get actionSave;

  /// No description provided for @actionBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get actionBack;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando…'**
  String get loading;

  /// No description provided for @errorNetworkProd.
  ///
  /// In es, this message translates to:
  /// **'No se pudo conectar con el servidor. Verifique que la VPN de la clínica esté activa e intente de nuevo.'**
  String get errorNetworkProd;

  /// No description provided for @errorNetwork.
  ///
  /// In es, this message translates to:
  /// **'No se pudo conectar con el servidor. Revise su conexión a internet e intente de nuevo.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In es, this message translates to:
  /// **'El servidor tardó demasiado en responder. Intente de nuevo.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In es, this message translates to:
  /// **'El servidor no pudo completar la solicitud. Intente de nuevo en unos minutos.'**
  String get errorServer;

  /// No description provided for @errorRateLimited.
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Espere un momento e intente de nuevo.'**
  String get errorRateLimited;

  /// No description provided for @errorForbidden.
  ///
  /// In es, this message translates to:
  /// **'No tiene permiso para realizar esta acción.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontró la información solicitada.'**
  String get errorNotFound;

  /// No description provided for @errorUnauthenticated.
  ///
  /// In es, this message translates to:
  /// **'Su sesión terminó. Inicie sesión de nuevo.'**
  String get errorUnauthenticated;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado. Intente de nuevo.'**
  String get errorGeneric;

  /// No description provided for @offlineBanner.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Las acciones que guardan datos están deshabilitadas.'**
  String get offlineBanner;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ingrese con su cuenta de la clínica.'**
  String get loginSubtitle;

  /// No description provided for @fieldEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get fieldPassword;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Ingresar'**
  String get loginButton;

  /// No description provided for @validationEmailRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese su correo electrónico.'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingrese un correo válido.'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese su contraseña.'**
  String get validationPasswordRequired;

  /// No description provided for @showPassword.
  ///
  /// In es, this message translates to:
  /// **'Mostrar contraseña'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In es, this message translates to:
  /// **'Ocultar contraseña'**
  String get hidePassword;

  /// No description provided for @sessionEndedExpired.
  ///
  /// In es, this message translates to:
  /// **'Su sesión expiró. Inicie sesión de nuevo.'**
  String get sessionEndedExpired;

  /// No description provided for @sessionEndedAccountDisabled.
  ///
  /// In es, this message translates to:
  /// **'Su cuenta fue desactivada. Comuníquese con el administrador.'**
  String get sessionEndedAccountDisabled;

  /// No description provided for @sessionEndedShift.
  ///
  /// In es, this message translates to:
  /// **'Su turno terminó y la sesión se cerró por seguridad. Inicie sesión de nuevo.'**
  String get sessionEndedShift;

  /// No description provided for @restoreFailedTitle.
  ///
  /// In es, this message translates to:
  /// **'No se pudo verificar su sesión'**
  String get restoreFailedTitle;

  /// No description provided for @lockedTitle.
  ///
  /// In es, this message translates to:
  /// **'Sesión bloqueada'**
  String get lockedTitle;

  /// No description provided for @lockedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Se bloqueó por inactividad. {name}, ingrese su contraseña para continuar.'**
  String lockedSubtitle(String name);

  /// No description provided for @lockedUnlock.
  ///
  /// In es, this message translates to:
  /// **'Desbloquear'**
  String get lockedUnlock;

  /// No description provided for @lockedWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña no es correcta.'**
  String get lockedWrongPassword;

  /// No description provided for @switchUser.
  ///
  /// In es, this message translates to:
  /// **'Cambiar de usuario'**
  String get switchUser;

  /// No description provided for @switchUserConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cambiar de usuario?'**
  String get switchUserConfirmTitle;

  /// No description provided for @switchUserConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Se cerrará la sesión actual en este equipo.'**
  String get switchUserConfirmBody;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cerrar sesión?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Deberá ingresar de nuevo para usar la aplicación.'**
  String get logoutConfirmBody;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navMore.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get navMore;

  /// No description provided for @navInventory.
  ///
  /// In es, this message translates to:
  /// **'Inventario'**
  String get navInventory;

  /// No description provided for @navPurchasing.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get navPurchasing;

  /// No description provided for @navAssets.
  ///
  /// In es, this message translates to:
  /// **'Activos'**
  String get navAssets;

  /// No description provided for @navMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Mantenimientos'**
  String get navMaintenance;

  /// No description provided for @navWarehouses.
  ///
  /// In es, this message translates to:
  /// **'Almacenes'**
  String get navWarehouses;

  /// No description provided for @navCatalog.
  ///
  /// In es, this message translates to:
  /// **'Catálogo'**
  String get navCatalog;

  /// No description provided for @navServiceOrders.
  ///
  /// In es, this message translates to:
  /// **'Órdenes de servicio'**
  String get navServiceOrders;

  /// No description provided for @navClinicalRecords.
  ///
  /// In es, this message translates to:
  /// **'Registros clínicos'**
  String get navClinicalRecords;

  /// No description provided for @navCostCenters.
  ///
  /// In es, this message translates to:
  /// **'Centros de costo'**
  String get navCostCenters;

  /// No description provided for @navMonitoring.
  ///
  /// In es, this message translates to:
  /// **'Monitoreo'**
  String get navMonitoring;

  /// No description provided for @navConsumptions.
  ///
  /// In es, this message translates to:
  /// **'Consumos'**
  String get navConsumptions;

  /// No description provided for @navReports.
  ///
  /// In es, this message translates to:
  /// **'Reportes'**
  String get navReports;

  /// No description provided for @navAudit.
  ///
  /// In es, this message translates to:
  /// **'Auditoría'**
  String get navAudit;

  /// No description provided for @homeGreeting.
  ///
  /// In es, this message translates to:
  /// **'Hola, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeModules.
  ///
  /// In es, this message translates to:
  /// **'Módulos disponibles'**
  String get homeModules;

  /// No description provided for @homeNoModules.
  ///
  /// In es, this message translates to:
  /// **'Su usuario no tiene módulos habilitados. Comuníquese con el administrador.'**
  String get homeNoModules;

  /// No description provided for @comingSoonTitle.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonBody.
  ///
  /// In es, this message translates to:
  /// **'Este módulo estará disponible en una próxima versión de la aplicación.'**
  String get comingSoonBody;

  /// No description provided for @menuLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar sus módulos.'**
  String get menuLoadError;

  /// No description provided for @moreTitle.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreTitle;

  /// No description provided for @openProfile.
  ///
  /// In es, this message translates to:
  /// **'Abrir perfil'**
  String get openProfile;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profileTitle;

  /// No description provided for @profileRoles.
  ///
  /// In es, this message translates to:
  /// **'Roles'**
  String get profileRoles;

  /// No description provided for @profileWarehouses.
  ///
  /// In es, this message translates to:
  /// **'Almacenes asignados'**
  String get profileWarehouses;

  /// No description provided for @profileNoWarehouses.
  ///
  /// In es, this message translates to:
  /// **'Sin almacenes asignados'**
  String get profileNoWarehouses;

  /// No description provided for @profileChangePassword.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get profileChangePassword;

  /// No description provided for @changePasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get changePasswordTitle;

  /// No description provided for @fieldCurrentPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actual'**
  String get fieldCurrentPassword;

  /// No description provided for @fieldNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get fieldNewPassword;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar nueva contraseña'**
  String get fieldConfirmPassword;

  /// No description provided for @validationPasswordMinLength.
  ///
  /// In es, this message translates to:
  /// **'Use al menos {min} caracteres.'**
  String validationPasswordMinLength(int min);

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden.'**
  String get validationPasswordMismatch;

  /// No description provided for @validationPasswordSame.
  ///
  /// In es, this message translates to:
  /// **'La nueva contraseña debe ser distinta de la actual.'**
  String get validationPasswordSame;

  /// No description provided for @passwordChanged.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada.'**
  String get passwordChanged;

  /// No description provided for @warehouseSelectTitle.
  ///
  /// In es, this message translates to:
  /// **'Almacén activo'**
  String get warehouseSelectTitle;

  /// No description provided for @warehouseNone.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar almacén'**
  String get warehouseNone;

  /// No description provided for @warehouseEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tiene almacenes asignados.'**
  String get warehouseEmpty;

  /// No description provided for @warehouseLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar los almacenes.'**
  String get warehouseLoadError;

  /// No description provided for @warehouseSelectorHint.
  ///
  /// In es, this message translates to:
  /// **'Cambiar almacén activo'**
  String get warehouseSelectorHint;

  /// No description provided for @updateAvailableTitle.
  ///
  /// In es, this message translates to:
  /// **'Hay una versión nueva'**
  String get updateAvailableTitle;

  /// No description provided for @updateAvailableBody.
  ///
  /// In es, this message translates to:
  /// **'La versión {version} ya está disponible.'**
  String updateAvailableBody(String version);

  /// No description provided for @updateRequiredTitle.
  ///
  /// In es, this message translates to:
  /// **'Actualice la aplicación'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredBody.
  ///
  /// In es, this message translates to:
  /// **'Esta versión ya no es compatible. Descargue la versión {version} para continuar.'**
  String updateRequiredBody(String version);

  /// No description provided for @updateDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get updateDownload;

  /// No description provided for @updateLater.
  ///
  /// In es, this message translates to:
  /// **'Más tarde'**
  String get updateLater;

  /// No description provided for @aboutVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión'**
  String get aboutVersion;

  /// No description provided for @aboutChangeServer.
  ///
  /// In es, this message translates to:
  /// **'Cambiar servidor'**
  String get aboutChangeServer;

  /// No description provided for @aboutChangeServerHint.
  ///
  /// In es, this message translates to:
  /// **'Dirección del servidor'**
  String get aboutChangeServerHint;

  /// No description provided for @aboutChangeServerInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingrese una dirección válida, p. ej. http://192.168.1.10:8000/api/v1'**
  String get aboutChangeServerInvalid;

  /// No description provided for @aboutChangeServerNotice.
  ///
  /// In es, this message translates to:
  /// **'Se cerrará la sesión y la aplicación se reiniciará con el nuevo servidor.'**
  String get aboutChangeServerNotice;

  /// No description provided for @aboutUseDefaultServer.
  ///
  /// In es, this message translates to:
  /// **'Usar el servidor original'**
  String get aboutUseDefaultServer;

  /// No description provided for @aboutLicenses.
  ///
  /// In es, this message translates to:
  /// **'Licencias'**
  String get aboutLicenses;

  /// No description provided for @statusActive.
  ///
  /// In es, this message translates to:
  /// **'Activo'**
  String get statusActive;

  /// No description provided for @statusInactive.
  ///
  /// In es, this message translates to:
  /// **'Inactivo'**
  String get statusInactive;

  /// No description provided for @warehouseDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Almacén'**
  String get warehouseDetailTitle;

  /// No description provided for @warehouseCode.
  ///
  /// In es, this message translates to:
  /// **'Código'**
  String get warehouseCode;

  /// No description provided for @warehouseAddress.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get warehouseAddress;

  /// No description provided for @warehouseDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get warehouseDescription;

  /// No description provided for @capacityTitle.
  ///
  /// In es, this message translates to:
  /// **'Capacidad'**
  String get capacityTitle;

  /// No description provided for @capacityVolume.
  ///
  /// In es, this message translates to:
  /// **'Volumen'**
  String get capacityVolume;

  /// No description provided for @capacityWeight.
  ///
  /// In es, this message translates to:
  /// **'Peso'**
  String get capacityWeight;

  /// No description provided for @capacityUsedOfMax.
  ///
  /// In es, this message translates to:
  /// **'{used} de {max} {unit}'**
  String capacityUsedOfMax(String used, String max, String unit);

  /// No description provided for @capacityUsedOnly.
  ///
  /// In es, this message translates to:
  /// **'En uso: {used} {unit} (sin límite definido)'**
  String capacityUsedOnly(String used, String unit);

  /// No description provided for @capacityLevelLow.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get capacityLevelLow;

  /// No description provided for @capacityLevelMedium.
  ///
  /// In es, this message translates to:
  /// **'Moderado'**
  String get capacityLevelMedium;

  /// No description provided for @capacityLevelHigh.
  ///
  /// In es, this message translates to:
  /// **'Casi lleno'**
  String get capacityLevelHigh;

  /// No description provided for @capacityZones.
  ///
  /// In es, this message translates to:
  /// **'Zonas'**
  String get capacityZones;

  /// No description provided for @capacityNoZones.
  ///
  /// In es, this message translates to:
  /// **'Este almacén no tiene zonas registradas.'**
  String get capacityNoZones;

  /// No description provided for @capacityLocationCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin ubicaciones} =1{1 ubicación} other{{count} ubicaciones}}'**
  String capacityLocationCount(int count);

  /// No description provided for @unitLiters.
  ///
  /// In es, this message translates to:
  /// **'L'**
  String get unitLiters;

  /// No description provided for @unitKg.
  ///
  /// In es, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get searchHint;

  /// No description provided for @searchClear.
  ///
  /// In es, this message translates to:
  /// **'Borrar búsqueda'**
  String get searchClear;

  /// No description provided for @noResults.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron resultados.'**
  String get noResults;

  /// No description provided for @catalogTabProducts.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get catalogTabProducts;

  /// No description provided for @catalogTabSuppliers.
  ///
  /// In es, this message translates to:
  /// **'Proveedores'**
  String get catalogTabSuppliers;

  /// No description provided for @catalogSearchProducts.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre o código de barras'**
  String get catalogSearchProducts;

  /// No description provided for @catalogSearchSuppliers.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre o NIT'**
  String get catalogSearchSuppliers;

  /// No description provided for @catalogEmptyProducts.
  ///
  /// In es, this message translates to:
  /// **'No hay productos para mostrar.'**
  String get catalogEmptyProducts;

  /// No description provided for @catalogEmptySuppliers.
  ///
  /// In es, this message translates to:
  /// **'No hay proveedores para mostrar.'**
  String get catalogEmptySuppliers;

  /// No description provided for @productDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Producto'**
  String get productDetailTitle;

  /// No description provided for @productTypeSimple.
  ///
  /// In es, this message translates to:
  /// **'Simple'**
  String get productTypeSimple;

  /// No description provided for @productTypeKit.
  ///
  /// In es, this message translates to:
  /// **'Kit'**
  String get productTypeKit;

  /// No description provided for @productColdChain.
  ///
  /// In es, this message translates to:
  /// **'Cadena de frío'**
  String get productColdChain;

  /// No description provided for @productBarcode.
  ///
  /// In es, this message translates to:
  /// **'Código de barras'**
  String get productBarcode;

  /// No description provided for @productCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get productCategory;

  /// No description provided for @productClassification.
  ///
  /// In es, this message translates to:
  /// **'Clasificación'**
  String get productClassification;

  /// No description provided for @productBaseUnit.
  ///
  /// In es, this message translates to:
  /// **'Unidad base'**
  String get productBaseUnit;

  /// No description provided for @productPharmaceuticalForm.
  ///
  /// In es, this message translates to:
  /// **'Forma farmacéutica'**
  String get productPharmaceuticalForm;

  /// No description provided for @productConcentration.
  ///
  /// In es, this message translates to:
  /// **'Concentración'**
  String get productConcentration;

  /// No description provided for @productStockLevels.
  ///
  /// In es, this message translates to:
  /// **'Niveles de stock'**
  String get productStockLevels;

  /// No description provided for @productMinStock.
  ///
  /// In es, this message translates to:
  /// **'Mínimo'**
  String get productMinStock;

  /// No description provided for @productMaxStock.
  ///
  /// In es, this message translates to:
  /// **'Máximo'**
  String get productMaxStock;

  /// No description provided for @productReorderPoint.
  ///
  /// In es, this message translates to:
  /// **'Punto de reorden'**
  String get productReorderPoint;

  /// No description provided for @productReorderQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad de reorden'**
  String get productReorderQuantity;

  /// No description provided for @productVariants.
  ///
  /// In es, this message translates to:
  /// **'Variantes'**
  String get productVariants;

  /// No description provided for @productNoVariants.
  ///
  /// In es, this message translates to:
  /// **'Sin variantes registradas.'**
  String get productNoVariants;

  /// No description provided for @variantBrand.
  ///
  /// In es, this message translates to:
  /// **'Marca'**
  String get variantBrand;

  /// No description provided for @variantSku.
  ///
  /// In es, this message translates to:
  /// **'Referencia'**
  String get variantSku;

  /// No description provided for @variantRisk.
  ///
  /// In es, this message translates to:
  /// **'Riesgo'**
  String get variantRisk;

  /// No description provided for @variantSanitaryRegistration.
  ///
  /// In es, this message translates to:
  /// **'Registro sanitario'**
  String get variantSanitaryRegistration;

  /// No description provided for @sanitaryExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get sanitaryExpired;

  /// No description provided for @sanitaryExpiresOn.
  ///
  /// In es, this message translates to:
  /// **'Vence {date}'**
  String sanitaryExpiresOn(String date);

  /// No description provided for @productKitComponents.
  ///
  /// In es, this message translates to:
  /// **'Componentes del kit'**
  String get productKitComponents;

  /// No description provided for @productKitQuantity.
  ///
  /// In es, this message translates to:
  /// **'x{quantity}'**
  String productKitQuantity(String quantity);

  /// No description provided for @supplierDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Proveedor'**
  String get supplierDetailTitle;

  /// No description provided for @supplierTaxId.
  ///
  /// In es, this message translates to:
  /// **'NIT'**
  String get supplierTaxId;

  /// No description provided for @supplierContact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get supplierContact;

  /// No description provided for @supplierPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get supplierPhone;

  /// No description provided for @supplierEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get supplierEmail;

  /// No description provided for @supplierAddress.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get supplierAddress;

  /// No description provided for @supplierNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get supplierNotes;

  /// No description provided for @supplierTypeInventory.
  ///
  /// In es, this message translates to:
  /// **'Inventario'**
  String get supplierTypeInventory;

  /// No description provided for @supplierTypeExpense.
  ///
  /// In es, this message translates to:
  /// **'Gasto'**
  String get supplierTypeExpense;

  /// No description provided for @notAvailable.
  ///
  /// In es, this message translates to:
  /// **'—'**
  String get notAvailable;

  /// No description provided for @variantPresentation.
  ///
  /// In es, this message translates to:
  /// **'Presentación comercial'**
  String get variantPresentation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
