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

  /// No description provided for @inventoryTabStock.
  ///
  /// In es, this message translates to:
  /// **'Existencias'**
  String get inventoryTabStock;

  /// No description provided for @inventoryTabBatches.
  ///
  /// In es, this message translates to:
  /// **'Lotes'**
  String get inventoryTabBatches;

  /// No description provided for @inventoryTabDocuments.
  ///
  /// In es, this message translates to:
  /// **'Comprobantes'**
  String get inventoryTabDocuments;

  /// No description provided for @inventoryTabHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get inventoryTabHistory;

  /// No description provided for @inventorySelectWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Seleccione un almacén activo en la barra superior para ver el inventario.'**
  String get inventorySelectWarehouse;

  /// No description provided for @stockEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay existencias registradas en este almacén.'**
  String get stockEmpty;

  /// No description provided for @stockLowFilter.
  ///
  /// In es, this message translates to:
  /// **'Bajo mínimo'**
  String get stockLowFilter;

  /// No description provided for @stockLowEmpty.
  ///
  /// In es, this message translates to:
  /// **'Ningún producto está por debajo del punto de reorden.'**
  String get stockLowEmpty;

  /// No description provided for @stockAvailable.
  ///
  /// In es, this message translates to:
  /// **'Disponible: {quantity}'**
  String stockAvailable(String quantity);

  /// No description provided for @stockTotals.
  ///
  /// In es, this message translates to:
  /// **'Total: {total} · Reservado: {reserved}'**
  String stockTotals(String total, String reserved);

  /// No description provided for @batchFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get batchFilterAll;

  /// No description provided for @batchFilterExpiring.
  ///
  /// In es, this message translates to:
  /// **'Por vencer'**
  String get batchFilterExpiring;

  /// No description provided for @batchFilterExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencidos'**
  String get batchFilterExpired;

  /// No description provided for @batchesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay lotes para mostrar.'**
  String get batchesEmpty;

  /// No description provided for @batchLot.
  ///
  /// In es, this message translates to:
  /// **'Lote {lot}'**
  String batchLot(String lot);

  /// No description provided for @batchExpires.
  ///
  /// In es, this message translates to:
  /// **'Vence {date}'**
  String batchExpires(String date);

  /// No description provided for @batchExpiresInDays.
  ///
  /// In es, this message translates to:
  /// **'Vence en {days, plural, =0{hoy} =1{1 día} other{{days} días}}'**
  String batchExpiresInDays(int days);

  /// No description provided for @batchStatusActive.
  ///
  /// In es, this message translates to:
  /// **'Vigente'**
  String get batchStatusActive;

  /// No description provided for @batchStatusExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get batchStatusExpired;

  /// No description provided for @batchStatusDepleted.
  ///
  /// In es, this message translates to:
  /// **'Agotado'**
  String get batchStatusDepleted;

  /// No description provided for @batchDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Lote'**
  String get batchDetailTitle;

  /// No description provided for @batchQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad disponible'**
  String get batchQuantity;

  /// No description provided for @batchManufacturing.
  ///
  /// In es, this message translates to:
  /// **'Fabricación'**
  String get batchManufacturing;

  /// No description provided for @batchLocations.
  ///
  /// In es, this message translates to:
  /// **'Ubicaciones'**
  String get batchLocations;

  /// No description provided for @batchNoLocations.
  ///
  /// In es, this message translates to:
  /// **'Sin ubicaciones con saldo.'**
  String get batchNoLocations;

  /// No description provided for @documentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay comprobantes para mostrar.'**
  String get documentsEmpty;

  /// No description provided for @documentFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get documentFilterAll;

  /// No description provided for @documentFilterPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get documentFilterPending;

  /// No description provided for @documentFilterConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirmados'**
  String get documentFilterConfirmed;

  /// No description provided for @documentStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de firma'**
  String get documentStatusPending;

  /// No description provided for @documentStatusConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirmado'**
  String get documentStatusConfirmed;

  /// No description provided for @historyEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay movimientos registrados.'**
  String get historyEmpty;

  /// No description provided for @movementEntry.
  ///
  /// In es, this message translates to:
  /// **'Entrada'**
  String get movementEntry;

  /// No description provided for @movementExit.
  ///
  /// In es, this message translates to:
  /// **'Salida'**
  String get movementExit;

  /// No description provided for @movementTransfer.
  ///
  /// In es, this message translates to:
  /// **'Traslado'**
  String get movementTransfer;

  /// No description provided for @movementAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Ajuste'**
  String get movementAdjustment;

  /// No description provided for @movementReturn.
  ///
  /// In es, this message translates to:
  /// **'Devolución'**
  String get movementReturn;

  /// No description provided for @movementWriteOff.
  ///
  /// In es, this message translates to:
  /// **'Baja por vencimiento'**
  String get movementWriteOff;

  /// No description provided for @movementLoss.
  ///
  /// In es, this message translates to:
  /// **'Pérdida'**
  String get movementLoss;

  /// No description provided for @movementEntryHint.
  ///
  /// In es, this message translates to:
  /// **'Ingreso de mercancía con lote y ubicación.'**
  String get movementEntryHint;

  /// No description provided for @movementExitHint.
  ///
  /// In es, this message translates to:
  /// **'Despacho a un centro de costo o paciente.'**
  String get movementExitHint;

  /// No description provided for @movementTransferHint.
  ///
  /// In es, this message translates to:
  /// **'Envío de stock a otro almacén.'**
  String get movementTransferHint;

  /// No description provided for @movementAdjustmentHint.
  ///
  /// In es, this message translates to:
  /// **'Corrección de cantidad con motivo.'**
  String get movementAdjustmentHint;

  /// No description provided for @movementReturnHint.
  ///
  /// In es, this message translates to:
  /// **'Reingreso de producto devuelto.'**
  String get movementReturnHint;

  /// No description provided for @movementWriteOffHint.
  ///
  /// In es, this message translates to:
  /// **'Baja de un lote vencido.'**
  String get movementWriteOffHint;

  /// No description provided for @movementLossHint.
  ///
  /// In es, this message translates to:
  /// **'Rotura, extravío u otra pérdida.'**
  String get movementLossHint;

  /// No description provided for @scanAction.
  ///
  /// In es, this message translates to:
  /// **'Escanear código'**
  String get scanAction;

  /// No description provided for @newMovementAction.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get newMovementAction;

  /// No description provided for @scanTitle.
  ///
  /// In es, this message translates to:
  /// **'Escanear producto'**
  String get scanTitle;

  /// No description provided for @scanHint.
  ///
  /// In es, this message translates to:
  /// **'Apunte la cámara al código de barras del producto.'**
  String get scanHint;

  /// No description provided for @scanPermissionDenied.
  ///
  /// In es, this message translates to:
  /// **'Sin acceso a la cámara. Habilítelo en los ajustes del teléfono.'**
  String get scanPermissionDenied;

  /// No description provided for @scanNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontró un producto con el código {code}.'**
  String scanNotFound(String code);

  /// No description provided for @scanTorch.
  ///
  /// In es, this message translates to:
  /// **'Linterna'**
  String get scanTorch;

  /// No description provided for @newMovementTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get newMovementTitle;

  /// No description provided for @newMovementChoose.
  ///
  /// In es, this message translates to:
  /// **'¿Qué desea registrar?'**
  String get newMovementChoose;

  /// No description provided for @newMovementNone.
  ///
  /// In es, this message translates to:
  /// **'Su usuario no tiene permisos para registrar movimientos.'**
  String get newMovementNone;

  /// No description provided for @fieldWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén'**
  String get fieldWarehouse;

  /// No description provided for @fieldReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo'**
  String get fieldReason;

  /// No description provided for @fieldReasonOptional.
  ///
  /// In es, this message translates to:
  /// **'Motivo (opcional)'**
  String get fieldReasonOptional;

  /// No description provided for @fieldNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas (opcional)'**
  String get fieldNotes;

  /// No description provided for @fieldQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get fieldQuantity;

  /// No description provided for @fieldLot.
  ///
  /// In es, this message translates to:
  /// **'Número de lote'**
  String get fieldLot;

  /// No description provided for @fieldExpiration.
  ///
  /// In es, this message translates to:
  /// **'Fecha de vencimiento'**
  String get fieldExpiration;

  /// No description provided for @fieldManufacturing.
  ///
  /// In es, this message translates to:
  /// **'Fecha de fabricación (opcional)'**
  String get fieldManufacturing;

  /// No description provided for @fieldLocation.
  ///
  /// In es, this message translates to:
  /// **'Ubicación'**
  String get fieldLocation;

  /// No description provided for @fieldLocationOptional.
  ///
  /// In es, this message translates to:
  /// **'Ubicación (opcional)'**
  String get fieldLocationOptional;

  /// No description provided for @fieldCostCenter.
  ///
  /// In es, this message translates to:
  /// **'Centro de costo'**
  String get fieldCostCenter;

  /// No description provided for @fieldPatientDocument.
  ///
  /// In es, this message translates to:
  /// **'Documento del paciente (opcional)'**
  String get fieldPatientDocument;

  /// No description provided for @fieldInvoice.
  ///
  /// In es, this message translates to:
  /// **'Factura (opcional)'**
  String get fieldInvoice;

  /// No description provided for @fieldTemperature.
  ///
  /// In es, this message translates to:
  /// **'Temperatura de entrada, °C (opcional)'**
  String get fieldTemperature;

  /// No description provided for @fieldProduct.
  ///
  /// In es, this message translates to:
  /// **'Producto'**
  String get fieldProduct;

  /// No description provided for @fieldVariant.
  ///
  /// In es, this message translates to:
  /// **'Variante'**
  String get fieldVariant;

  /// No description provided for @fieldBatch.
  ///
  /// In es, this message translates to:
  /// **'Lote'**
  String get fieldBatch;

  /// No description provided for @fieldBatchFefo.
  ///
  /// In es, this message translates to:
  /// **'Automático (primero en vencer)'**
  String get fieldBatchFefo;

  /// No description provided for @fieldDestinationWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén destino'**
  String get fieldDestinationWarehouse;

  /// No description provided for @fieldPresentation.
  ///
  /// In es, this message translates to:
  /// **'Presentación'**
  String get fieldPresentation;

  /// No description provided for @fieldBaseUnitDirect.
  ///
  /// In es, this message translates to:
  /// **'Unidad base'**
  String get fieldBaseUnitDirect;

  /// No description provided for @fieldSignedQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad (negativa para restar)'**
  String get fieldSignedQuantity;

  /// No description provided for @itemsTitle.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get itemsTitle;

  /// No description provided for @addItem.
  ///
  /// In es, this message translates to:
  /// **'Agregar producto'**
  String get addItem;

  /// No description provided for @removeItem.
  ///
  /// In es, this message translates to:
  /// **'Quitar'**
  String get removeItem;

  /// No description provided for @itemsRequired.
  ///
  /// In es, this message translates to:
  /// **'Agregue al menos un producto.'**
  String get itemsRequired;

  /// No description provided for @selectProduct.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar producto'**
  String get selectProduct;

  /// No description provided for @selectOption.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar'**
  String get selectOption;

  /// No description provided for @pickDate.
  ///
  /// In es, this message translates to:
  /// **'Elegir fecha'**
  String get pickDate;

  /// No description provided for @submitRegister.
  ///
  /// In es, this message translates to:
  /// **'Registrar'**
  String get submitRegister;

  /// No description provided for @validationRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio.'**
  String get validationRequired;

  /// No description provided for @validationPositive.
  ///
  /// In es, this message translates to:
  /// **'Ingrese una cantidad mayor que cero.'**
  String get validationPositive;

  /// No description provided for @validationNonZero.
  ///
  /// In es, this message translates to:
  /// **'Ingrese una cantidad distinta de cero.'**
  String get validationNonZero;

  /// No description provided for @validationNumber.
  ///
  /// In es, this message translates to:
  /// **'Ingrese un número válido.'**
  String get validationNumber;

  /// No description provided for @movementRegisteredDoc.
  ///
  /// In es, this message translates to:
  /// **'Comprobante {number} registrado.'**
  String movementRegisteredDoc(String number);

  /// No description provided for @movementRegistered.
  ///
  /// In es, this message translates to:
  /// **'Movimiento registrado.'**
  String get movementRegistered;

  /// No description provided for @movementPendingSignNote.
  ///
  /// In es, this message translates to:
  /// **'Quedó pendiente de firma: el stock cambia al confirmarlo.'**
  String get movementPendingSignNote;

  /// No description provided for @movementTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, revise el historial: es posible que sí se haya registrado.'**
  String get movementTimeoutWarning;

  /// No description provided for @movementNeedsCostCenters.
  ///
  /// In es, this message translates to:
  /// **'Para registrar salidas se necesita poder consultar centros de costo.'**
  String get movementNeedsCostCenters;

  /// No description provided for @noProductsFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron productos.'**
  String get noProductsFound;

  /// No description provided for @noVariants.
  ///
  /// In es, this message translates to:
  /// **'Este producto no tiene variantes.'**
  String get noVariants;

  /// No description provided for @noLocations.
  ///
  /// In es, this message translates to:
  /// **'Este almacén no tiene ubicaciones.'**
  String get noLocations;

  /// No description provided for @noBatchesAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay lotes disponibles.'**
  String get noBatchesAvailable;

  /// No description provided for @confirmTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar comprobante'**
  String get confirmTitle;

  /// No description provided for @confirmDelivered.
  ///
  /// In es, this message translates to:
  /// **'Entrega'**
  String get confirmDelivered;

  /// No description provided for @confirmUseMySignature.
  ///
  /// In es, this message translates to:
  /// **'Usar mi firma registrada'**
  String get confirmUseMySignature;

  /// No description provided for @confirmNoSignature.
  ///
  /// In es, this message translates to:
  /// **'Aún no tiene firma registrada. Regístrela para poder entregar.'**
  String get confirmNoSignature;

  /// No description provided for @confirmRegisterSignature.
  ///
  /// In es, this message translates to:
  /// **'Registrar mi firma'**
  String get confirmRegisterSignature;

  /// No description provided for @confirmReceived.
  ///
  /// In es, this message translates to:
  /// **'Recibe'**
  String get confirmReceived;

  /// No description provided for @confirmModePin.
  ///
  /// In es, this message translates to:
  /// **'Usuario del sistema'**
  String get confirmModePin;

  /// No description provided for @confirmModeExternal.
  ///
  /// In es, this message translates to:
  /// **'Persona externa'**
  String get confirmModeExternal;

  /// No description provided for @fieldPin.
  ///
  /// In es, this message translates to:
  /// **'PIN de 3 dígitos'**
  String get fieldPin;

  /// No description provided for @validationPin.
  ///
  /// In es, this message translates to:
  /// **'Ingrese los 3 dígitos del PIN.'**
  String get validationPin;

  /// No description provided for @fieldSignerName.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get fieldSignerName;

  /// No description provided for @fieldSignerDocument.
  ///
  /// In es, this message translates to:
  /// **'Documento'**
  String get fieldSignerDocument;

  /// No description provided for @signHere.
  ///
  /// In es, this message translates to:
  /// **'Firme aquí'**
  String get signHere;

  /// No description provided for @clearSignature.
  ///
  /// In es, this message translates to:
  /// **'Borrar firma'**
  String get clearSignature;

  /// No description provided for @signatureRequired.
  ///
  /// In es, this message translates to:
  /// **'La firma es obligatoria.'**
  String get signatureRequired;

  /// No description provided for @confirmAction.
  ///
  /// In es, this message translates to:
  /// **'Confirmar y firmar'**
  String get confirmAction;

  /// No description provided for @confirmedMessage.
  ///
  /// In es, this message translates to:
  /// **'Comprobante confirmado.'**
  String get confirmedMessage;

  /// No description provided for @cancelPendingAction.
  ///
  /// In es, this message translates to:
  /// **'Cancelar comprobante'**
  String get cancelPendingAction;

  /// No description provided for @cancelPendingTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cancelar este comprobante?'**
  String get cancelPendingTitle;

  /// No description provided for @cancelPendingBody.
  ///
  /// In es, this message translates to:
  /// **'Quedará anulado y el stock no cambiará.'**
  String get cancelPendingBody;

  /// No description provided for @cancelledMessage.
  ///
  /// In es, this message translates to:
  /// **'Comprobante cancelado.'**
  String get cancelledMessage;

  /// No description provided for @documentDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Comprobante'**
  String get documentDetailTitle;

  /// No description provided for @documentWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén'**
  String get documentWarehouse;

  /// No description provided for @documentDestination.
  ///
  /// In es, this message translates to:
  /// **'Almacén destino'**
  String get documentDestination;

  /// No description provided for @documentCreatedBy.
  ///
  /// In es, this message translates to:
  /// **'Registrado por'**
  String get documentCreatedBy;

  /// No description provided for @documentDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get documentDate;

  /// No description provided for @documentCostCenter.
  ///
  /// In es, this message translates to:
  /// **'Centro de costo'**
  String get documentCostCenter;

  /// No description provided for @documentReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo'**
  String get documentReason;

  /// No description provided for @documentLines.
  ///
  /// In es, this message translates to:
  /// **'Líneas'**
  String get documentLines;

  /// No description provided for @documentSignatures.
  ///
  /// In es, this message translates to:
  /// **'Firmas'**
  String get documentSignatures;

  /// No description provided for @signatureDelivered.
  ///
  /// In es, this message translates to:
  /// **'Entrega'**
  String get signatureDelivered;

  /// No description provided for @signatureReceived.
  ///
  /// In es, this message translates to:
  /// **'Recibe'**
  String get signatureReceived;

  /// No description provided for @viewSignature.
  ///
  /// In es, this message translates to:
  /// **'Ver firma'**
  String get viewSignature;

  /// No description provided for @documentLineQuantity.
  ///
  /// In es, this message translates to:
  /// **'{product} · {quantity}'**
  String documentLineQuantity(String product, String quantity);

  /// No description provided for @pdfView.
  ///
  /// In es, this message translates to:
  /// **'Ver PDF'**
  String get pdfView;

  /// No description provided for @pdfShare.
  ///
  /// In es, this message translates to:
  /// **'Compartir PDF'**
  String get pdfShare;

  /// No description provided for @pdfTitle.
  ///
  /// In es, this message translates to:
  /// **'Comprobante en PDF'**
  String get pdfTitle;

  /// No description provided for @pdfError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el PDF.'**
  String get pdfError;

  /// No description provided for @sendEmailAction.
  ///
  /// In es, this message translates to:
  /// **'Enviar por correo'**
  String get sendEmailAction;

  /// No description provided for @fieldRecipients.
  ///
  /// In es, this message translates to:
  /// **'Correos (separados por coma)'**
  String get fieldRecipients;

  /// No description provided for @validationEmails.
  ///
  /// In es, this message translates to:
  /// **'Ingrese correos válidos separados por comas.'**
  String get validationEmails;

  /// No description provided for @emailSent.
  ///
  /// In es, this message translates to:
  /// **'Correo enviado.'**
  String get emailSent;

  /// No description provided for @signatureTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi firma'**
  String get signatureTitle;

  /// No description provided for @signatureIntro.
  ///
  /// In es, this message translates to:
  /// **'Su firma se usa al entregar comprobantes. Necesita su contraseña para guardarla.'**
  String get signatureIntro;

  /// No description provided for @fieldDocumentType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de documento'**
  String get fieldDocumentType;

  /// No description provided for @fieldDocumentNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de documento'**
  String get fieldDocumentNumber;

  /// No description provided for @validationDocumentNumber.
  ///
  /// In es, this message translates to:
  /// **'Use entre 4 y 20 letras o números.'**
  String get validationDocumentNumber;

  /// No description provided for @signatureSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar firma'**
  String get signatureSave;

  /// No description provided for @signatureSaved.
  ///
  /// In es, this message translates to:
  /// **'Firma guardada.'**
  String get signatureSaved;

  /// No description provided for @signatureNone.
  ///
  /// In es, this message translates to:
  /// **'Aún no ha registrado su firma.'**
  String get signatureNone;

  /// No description provided for @signaturePinTitle.
  ///
  /// In es, this message translates to:
  /// **'Anote su PIN'**
  String get signaturePinTitle;

  /// No description provided for @signaturePinBody.
  ///
  /// In es, this message translates to:
  /// **'Este PIN de 3 dígitos permite recibir comprobantes con su firma. Se muestra una sola vez.'**
  String get signaturePinBody;

  /// No description provided for @signaturePinConfirm.
  ///
  /// In es, this message translates to:
  /// **'Ya anoté mi PIN'**
  String get signaturePinConfirm;

  /// No description provided for @signaturePinRegenerate.
  ///
  /// In es, this message translates to:
  /// **'Generar PIN nuevo'**
  String get signaturePinRegenerate;

  /// No description provided for @signaturePinRegenerateBody.
  ///
  /// In es, this message translates to:
  /// **'El PIN anterior dejará de funcionar. ¿Generar uno nuevo?'**
  String get signaturePinRegenerateBody;

  /// No description provided for @signatureRegisteredOn.
  ///
  /// In es, this message translates to:
  /// **'Registrada el {date}'**
  String signatureRegisteredOn(String date);

  /// No description provided for @signatureHasPin.
  ///
  /// In es, this message translates to:
  /// **'PIN activo'**
  String get signatureHasPin;

  /// No description provided for @signatureNoPin.
  ///
  /// In es, this message translates to:
  /// **'Sin PIN'**
  String get signatureNoPin;

  /// No description provided for @docTypeCC.
  ///
  /// In es, this message translates to:
  /// **'Cédula de ciudadanía'**
  String get docTypeCC;

  /// No description provided for @docTypeCE.
  ///
  /// In es, this message translates to:
  /// **'Cédula de extranjería'**
  String get docTypeCE;

  /// No description provided for @docTypeTI.
  ///
  /// In es, this message translates to:
  /// **'Tarjeta de identidad'**
  String get docTypeTI;

  /// No description provided for @docTypePA.
  ///
  /// In es, this message translates to:
  /// **'Pasaporte'**
  String get docTypePA;

  /// No description provided for @docTypePPT.
  ///
  /// In es, this message translates to:
  /// **'Permiso por protección temporal'**
  String get docTypePPT;

  /// No description provided for @profileMySignature.
  ///
  /// In es, this message translates to:
  /// **'Mi firma'**
  String get profileMySignature;

  /// No description provided for @clearField.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get clearField;

  /// No description provided for @lineAdded.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get lineAdded;

  /// No description provided for @aboutServerPresets.
  ///
  /// In es, this message translates to:
  /// **'Servidores disponibles'**
  String get aboutServerPresets;

  /// No description provided for @aboutServerCustom.
  ///
  /// In es, this message translates to:
  /// **'Otra dirección'**
  String get aboutServerCustom;

  /// No description provided for @aboutServerCurrent.
  ///
  /// In es, this message translates to:
  /// **'En uso'**
  String get aboutServerCurrent;

  /// No description provided for @aboutServerRestartNote.
  ///
  /// In es, this message translates to:
  /// **'Al cambiar de servidor se cierra la sesión.'**
  String get aboutServerRestartNote;

  /// No description provided for @loginServerLabel.
  ///
  /// In es, this message translates to:
  /// **'Servidor: {name}'**
  String loginServerLabel(String name);

  /// No description provided for @notificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificationsTitle;

  /// No description provided for @notificationsOpen.
  ///
  /// In es, this message translates to:
  /// **'Abrir notificaciones'**
  String get notificationsOpen;

  /// No description provided for @notificationsUnreadCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin notificaciones nuevas} =1{1 notificación sin leer} other{{count} notificaciones sin leer}}'**
  String notificationsUnreadCount(int count);

  /// No description provided for @notificationsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tiene notificaciones.'**
  String get notificationsEmpty;

  /// No description provided for @notificationsEmptyUnread.
  ///
  /// In es, this message translates to:
  /// **'No tiene notificaciones sin leer.'**
  String get notificationsEmptyUnread;

  /// No description provided for @notificationsFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get notificationsFilterAll;

  /// No description provided for @notificationsFilterUnread.
  ///
  /// In es, this message translates to:
  /// **'Sin leer'**
  String get notificationsFilterUnread;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In es, this message translates to:
  /// **'Marcar todas como leídas'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsAllRead.
  ///
  /// In es, this message translates to:
  /// **'Todas las notificaciones quedaron leídas.'**
  String get notificationsAllRead;

  /// No description provided for @severityCritical.
  ///
  /// In es, this message translates to:
  /// **'Crítica'**
  String get severityCritical;

  /// No description provided for @severityWarning.
  ///
  /// In es, this message translates to:
  /// **'Advertencia'**
  String get severityWarning;

  /// No description provided for @severityInfo.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get severityInfo;

  /// No description provided for @severitySuccess.
  ///
  /// In es, this message translates to:
  /// **'Listo'**
  String get severitySuccess;

  /// No description provided for @notificationUnread.
  ///
  /// In es, this message translates to:
  /// **'Sin leer'**
  String get notificationUnread;

  /// No description provided for @dashInventory.
  ///
  /// In es, this message translates to:
  /// **'Inventario'**
  String get dashInventory;

  /// No description provided for @dashProducts.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get dashProducts;

  /// No description provided for @dashUnits.
  ///
  /// In es, this message translates to:
  /// **'Unidades en stock'**
  String get dashUnits;

  /// No description provided for @dashStockHealth.
  ///
  /// In es, this message translates to:
  /// **'Estado del stock'**
  String get dashStockHealth;

  /// No description provided for @dashStockOk.
  ///
  /// In es, this message translates to:
  /// **'Suficiente'**
  String get dashStockOk;

  /// No description provided for @dashStockLow.
  ///
  /// In es, this message translates to:
  /// **'Bajo reorden'**
  String get dashStockLow;

  /// No description provided for @dashStockCritical.
  ///
  /// In es, this message translates to:
  /// **'Crítico'**
  String get dashStockCritical;

  /// No description provided for @dashExpiring.
  ///
  /// In es, this message translates to:
  /// **'Vencimientos de lotes'**
  String get dashExpiring;

  /// No description provided for @dashExpiringToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get dashExpiringToday;

  /// No description provided for @dashExpiring7.
  ///
  /// In es, this message translates to:
  /// **'7 días'**
  String get dashExpiring7;

  /// No description provided for @dashExpiring30.
  ///
  /// In es, this message translates to:
  /// **'30 días'**
  String get dashExpiring30;

  /// No description provided for @dashMovementsToday.
  ///
  /// In es, this message translates to:
  /// **'Movimientos hoy'**
  String get dashMovementsToday;

  /// No description provided for @dashTopConsumed.
  ///
  /// In es, this message translates to:
  /// **'Más consumidos (30 días)'**
  String get dashTopConsumed;

  /// No description provided for @dashPurchasing.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get dashPurchasing;

  /// No description provided for @dashPendingOrders.
  ///
  /// In es, this message translates to:
  /// **'Órdenes por aprobar'**
  String get dashPendingOrders;

  /// No description provided for @dashApprovedOrders.
  ///
  /// In es, this message translates to:
  /// **'Órdenes aprobadas'**
  String get dashApprovedOrders;

  /// No description provided for @dashMonthTotal.
  ///
  /// In es, this message translates to:
  /// **'Compras del mes'**
  String get dashMonthTotal;

  /// No description provided for @dashMonitoring.
  ///
  /// In es, this message translates to:
  /// **'Monitoreo'**
  String get dashMonitoring;

  /// No description provided for @dashActiveSensors.
  ///
  /// In es, this message translates to:
  /// **'Sensores activos'**
  String get dashActiveSensors;

  /// No description provided for @dashAlertsToday.
  ///
  /// In es, this message translates to:
  /// **'Alertas hoy'**
  String get dashAlertsToday;

  /// No description provided for @dashReadingsToday.
  ///
  /// In es, this message translates to:
  /// **'Lecturas hoy'**
  String get dashReadingsToday;

  /// No description provided for @dashAlerts.
  ///
  /// In es, this message translates to:
  /// **'Alertas recientes'**
  String get dashAlerts;

  /// No description provided for @dashNoAlerts.
  ///
  /// In es, this message translates to:
  /// **'Sin alertas pendientes.'**
  String get dashNoAlerts;

  /// No description provided for @dashActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad reciente'**
  String get dashActivity;

  /// No description provided for @dashNoActivity.
  ///
  /// In es, this message translates to:
  /// **'Sin actividad reciente.'**
  String get dashNoActivity;

  /// No description provided for @dashQuickActions.
  ///
  /// In es, this message translates to:
  /// **'Accesos rápidos'**
  String get dashQuickActions;

  /// No description provided for @dashScan.
  ///
  /// In es, this message translates to:
  /// **'Escanear'**
  String get dashScan;

  /// No description provided for @dashNewMovement.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get dashNewMovement;

  /// No description provided for @dashBlockError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar este bloque.'**
  String get dashBlockError;

  /// No description provided for @auditCreated.
  ///
  /// In es, this message translates to:
  /// **'Creó'**
  String get auditCreated;

  /// No description provided for @auditUpdated.
  ///
  /// In es, this message translates to:
  /// **'Modificó'**
  String get auditUpdated;

  /// No description provided for @auditDeleted.
  ///
  /// In es, this message translates to:
  /// **'Eliminó'**
  String get auditDeleted;

  /// No description provided for @auditUnknown.
  ///
  /// In es, this message translates to:
  /// **'Acción'**
  String get auditUnknown;

  /// No description provided for @monitoringEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tiene sensores asignados.'**
  String get monitoringEmpty;

  /// No description provided for @sensorTypeTemperature.
  ///
  /// In es, this message translates to:
  /// **'Temperatura'**
  String get sensorTypeTemperature;

  /// No description provided for @sensorTypeHumidity.
  ///
  /// In es, this message translates to:
  /// **'Humedad'**
  String get sensorTypeHumidity;

  /// No description provided for @sensorLastReading.
  ///
  /// In es, this message translates to:
  /// **'Última lectura'**
  String get sensorLastReading;

  /// No description provided for @sensorNoReadings.
  ///
  /// In es, this message translates to:
  /// **'Sin lecturas aún'**
  String get sensorNoReadings;

  /// No description provided for @sensorOutOfRange.
  ///
  /// In es, this message translates to:
  /// **'Fuera de rango'**
  String get sensorOutOfRange;

  /// No description provided for @sensorInRange.
  ///
  /// In es, this message translates to:
  /// **'En rango'**
  String get sensorInRange;

  /// No description provided for @sensorLimits.
  ///
  /// In es, this message translates to:
  /// **'Rango permitido: {min}–{max} {unit}'**
  String sensorLimits(String min, String max, String unit);

  /// No description provided for @sensorZone.
  ///
  /// In es, this message translates to:
  /// **'Zona'**
  String get sensorZone;

  /// No description provided for @sensorDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Sensor'**
  String get sensorDetailTitle;

  /// No description provided for @calibrationValid.
  ///
  /// In es, this message translates to:
  /// **'Calibración vigente'**
  String get calibrationValid;

  /// No description provided for @calibrationExpiring.
  ///
  /// In es, this message translates to:
  /// **'Calibración por vencer'**
  String get calibrationExpiring;

  /// No description provided for @calibrationExpired.
  ///
  /// In es, this message translates to:
  /// **'Calibración vencida'**
  String get calibrationExpired;

  /// No description provided for @calibrationMissing.
  ///
  /// In es, this message translates to:
  /// **'Sin certificado'**
  String get calibrationMissing;

  /// No description provided for @calibrationDaysLeft.
  ///
  /// In es, this message translates to:
  /// **'{days, plural, =0{Vence hoy} =1{Vence en 1 día} other{Vence en {days} días}}'**
  String calibrationDaysLeft(int days);

  /// No description provided for @periodDay.
  ///
  /// In es, this message translates to:
  /// **'24 h'**
  String get periodDay;

  /// No description provided for @periodWeek.
  ///
  /// In es, this message translates to:
  /// **'7 días'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In es, this message translates to:
  /// **'30 días'**
  String get periodMonth;

  /// No description provided for @readingsStats.
  ///
  /// In es, this message translates to:
  /// **'Resumen del periodo'**
  String get readingsStats;

  /// No description provided for @statMin.
  ///
  /// In es, this message translates to:
  /// **'Mínimo'**
  String get statMin;

  /// No description provided for @statMax.
  ///
  /// In es, this message translates to:
  /// **'Máximo'**
  String get statMax;

  /// No description provided for @statAvg.
  ///
  /// In es, this message translates to:
  /// **'Promedio'**
  String get statAvg;

  /// No description provided for @statCount.
  ///
  /// In es, this message translates to:
  /// **'Lecturas'**
  String get statCount;

  /// No description provided for @readingsEmptyPeriod.
  ///
  /// In es, this message translates to:
  /// **'No hay lecturas en este periodo.'**
  String get readingsEmptyPeriod;

  /// No description provided for @trendTitle.
  ///
  /// In es, this message translates to:
  /// **'Tendencia'**
  String get trendTitle;

  /// No description provided for @trendNone.
  ///
  /// In es, this message translates to:
  /// **'Sin tendencia significativa en el periodo.'**
  String get trendNone;

  /// No description provided for @trendUp.
  ///
  /// In es, this message translates to:
  /// **'Tendencia al alza'**
  String get trendUp;

  /// No description provided for @trendDown.
  ///
  /// In es, this message translates to:
  /// **'Tendencia a la baja'**
  String get trendDown;

  /// No description provided for @trendConfidence.
  ///
  /// In es, this message translates to:
  /// **'Confianza {level}'**
  String trendConfidence(String level);

  /// No description provided for @confidenceHigh.
  ///
  /// In es, this message translates to:
  /// **'alta'**
  String get confidenceHigh;

  /// No description provided for @confidenceMedium.
  ///
  /// In es, this message translates to:
  /// **'media'**
  String get confidenceMedium;

  /// No description provided for @confidenceLow.
  ///
  /// In es, this message translates to:
  /// **'baja'**
  String get confidenceLow;

  /// No description provided for @readingRegister.
  ///
  /// In es, this message translates to:
  /// **'Registrar lectura'**
  String get readingRegister;

  /// No description provided for @readingValue.
  ///
  /// In es, this message translates to:
  /// **'Valor ({unit})'**
  String readingValue(String unit);

  /// No description provided for @readingWhen.
  ///
  /// In es, this message translates to:
  /// **'Fecha y hora de la lectura'**
  String get readingWhen;

  /// No description provided for @readingSaved.
  ///
  /// In es, this message translates to:
  /// **'Lectura registrada.'**
  String get readingSaved;

  /// No description provided for @readingAlerts.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{La lectura generó 1 alerta.} other{La lectura generó {count} alertas.}}'**
  String readingAlerts(int count);

  /// No description provided for @calibrationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Calibraciones'**
  String get calibrationsTitle;

  /// No description provided for @calibrationsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin certificados de calibración.'**
  String get calibrationsEmpty;

  /// No description provided for @calibrationDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar certificado'**
  String get calibrationDownload;

  /// No description provided for @calibrationCurrent.
  ///
  /// In es, this message translates to:
  /// **'Vigente'**
  String get calibrationCurrent;

  /// No description provided for @calibrationReplaced.
  ///
  /// In es, this message translates to:
  /// **'Reemplazado'**
  String get calibrationReplaced;

  /// No description provided for @alertRulesTitle.
  ///
  /// In es, this message translates to:
  /// **'Reglas de alerta'**
  String get alertRulesTitle;

  /// No description provided for @alertRulesEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin reglas de alerta.'**
  String get alertRulesEmpty;

  /// No description provided for @alertAbove.
  ///
  /// In es, this message translates to:
  /// **'Por encima de {threshold}'**
  String alertAbove(String threshold);

  /// No description provided for @alertBelow.
  ///
  /// In es, this message translates to:
  /// **'Por debajo de {threshold}'**
  String alertBelow(String threshold);

  /// No description provided for @alertOutOfRange.
  ///
  /// In es, this message translates to:
  /// **'Fuera del rango permitido'**
  String get alertOutOfRange;

  /// No description provided for @alertTrendUp.
  ///
  /// In es, this message translates to:
  /// **'Tendencia al alza'**
  String get alertTrendUp;

  /// No description provided for @alertTrendDown.
  ///
  /// In es, this message translates to:
  /// **'Tendencia a la baja'**
  String get alertTrendDown;

  /// No description provided for @alertConsecutive.
  ///
  /// In es, this message translates to:
  /// **'{count} lecturas seguidas'**
  String alertConsecutive(int count);

  /// No description provided for @conditionsReportAction.
  ///
  /// In es, this message translates to:
  /// **'Reporte de condiciones (PDF)'**
  String get conditionsReportAction;

  /// No description provided for @reportsCatalogTitle.
  ///
  /// In es, this message translates to:
  /// **'Elija un reporte'**
  String get reportsCatalogTitle;

  /// No description provided for @reportsMyExports.
  ///
  /// In es, this message translates to:
  /// **'Mis exportaciones'**
  String get reportsMyExports;

  /// No description provided for @reportInventory.
  ///
  /// In es, this message translates to:
  /// **'Inventario'**
  String get reportInventory;

  /// No description provided for @reportInventoryHint.
  ///
  /// In es, this message translates to:
  /// **'Existencias por almacén.'**
  String get reportInventoryHint;

  /// No description provided for @reportMovements.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get reportMovements;

  /// No description provided for @reportMovementsHint.
  ///
  /// In es, this message translates to:
  /// **'Entradas, salidas y demás movimientos.'**
  String get reportMovementsHint;

  /// No description provided for @reportExpiring.
  ///
  /// In es, this message translates to:
  /// **'Por vencer'**
  String get reportExpiring;

  /// No description provided for @reportExpiringHint.
  ///
  /// In es, this message translates to:
  /// **'Lotes próximos a vencer.'**
  String get reportExpiringHint;

  /// No description provided for @reportPurchases.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get reportPurchases;

  /// No description provided for @reportPurchasesHint.
  ///
  /// In es, this message translates to:
  /// **'Órdenes de compra del periodo.'**
  String get reportPurchasesHint;

  /// No description provided for @reportConsumption.
  ///
  /// In es, this message translates to:
  /// **'Consumo'**
  String get reportConsumption;

  /// No description provided for @reportConsumptionHint.
  ///
  /// In es, this message translates to:
  /// **'Productos consumidos en el periodo.'**
  String get reportConsumptionHint;

  /// No description provided for @reportConditions.
  ///
  /// In es, this message translates to:
  /// **'Condiciones de almacenamiento'**
  String get reportConditions;

  /// No description provided for @reportConditionsHint.
  ///
  /// In es, this message translates to:
  /// **'Temperatura y humedad de un sensor.'**
  String get reportConditionsHint;

  /// No description provided for @reportAudit.
  ///
  /// In es, this message translates to:
  /// **'Auditoría'**
  String get reportAudit;

  /// No description provided for @reportAuditHint.
  ///
  /// In es, this message translates to:
  /// **'Acciones registradas en el sistema.'**
  String get reportAuditHint;

  /// No description provided for @reportFormat.
  ///
  /// In es, this message translates to:
  /// **'Formato'**
  String get reportFormat;

  /// No description provided for @formatPdf.
  ///
  /// In es, this message translates to:
  /// **'PDF'**
  String get formatPdf;

  /// No description provided for @formatExcel.
  ///
  /// In es, this message translates to:
  /// **'Excel'**
  String get formatExcel;

  /// No description provided for @formatCsv.
  ///
  /// In es, this message translates to:
  /// **'CSV'**
  String get formatCsv;

  /// No description provided for @reportGenerate.
  ///
  /// In es, this message translates to:
  /// **'Generar reporte'**
  String get reportGenerate;

  /// No description provided for @reportDateFrom.
  ///
  /// In es, this message translates to:
  /// **'Desde'**
  String get reportDateFrom;

  /// No description provided for @reportDateTo.
  ///
  /// In es, this message translates to:
  /// **'Hasta'**
  String get reportDateTo;

  /// No description provided for @reportDays.
  ///
  /// In es, this message translates to:
  /// **'Días a considerar'**
  String get reportDays;

  /// No description provided for @reportSensor.
  ///
  /// In es, this message translates to:
  /// **'Sensor'**
  String get reportSensor;

  /// No description provided for @reportMovementType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de movimiento'**
  String get reportMovementType;

  /// No description provided for @reportAnyType.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get reportAnyType;

  /// No description provided for @reportPdfNeedsSensor.
  ///
  /// In es, this message translates to:
  /// **'Para el PDF de condiciones elija un sensor.'**
  String get reportPdfNeedsSensor;

  /// No description provided for @reportDateRangeInvalid.
  ///
  /// In es, this message translates to:
  /// **'La fecha final no puede ser anterior a la inicial.'**
  String get reportDateRangeInvalid;

  /// No description provided for @reportQueued.
  ///
  /// In es, this message translates to:
  /// **'El reporte es grande y se está generando. Puede seguirlo en Mis exportaciones.'**
  String get reportQueued;

  /// No description provided for @reportReady.
  ///
  /// In es, this message translates to:
  /// **'Reporte generado.'**
  String get reportReady;

  /// No description provided for @exportsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay exportaciones.'**
  String get exportsEmpty;

  /// No description provided for @exportQueued.
  ///
  /// In es, this message translates to:
  /// **'En cola'**
  String get exportQueued;

  /// No description provided for @exportProcessing.
  ///
  /// In es, this message translates to:
  /// **'Procesando'**
  String get exportProcessing;

  /// No description provided for @exportReady.
  ///
  /// In es, this message translates to:
  /// **'Listo'**
  String get exportReady;

  /// No description provided for @exportFailed.
  ///
  /// In es, this message translates to:
  /// **'Falló'**
  String get exportFailed;

  /// No description provided for @exportExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get exportExpired;

  /// No description provided for @exportDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get exportDownload;

  /// No description provided for @exportShare.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get exportShare;

  /// No description provided for @exportOpen.
  ///
  /// In es, this message translates to:
  /// **'Abrir'**
  String get exportOpen;

  /// No description provided for @exportCreatedAt.
  ///
  /// In es, this message translates to:
  /// **'Creado {date}'**
  String exportCreatedAt(String date);

  /// No description provided for @exportSize.
  ///
  /// In es, this message translates to:
  /// **'{size} KB'**
  String exportSize(String size);

  /// No description provided for @exportGone.
  ///
  /// In es, this message translates to:
  /// **'El reporte venció. Genérelo de nuevo desde Reportes.'**
  String get exportGone;

  /// No description provided for @exportFailedDetail.
  ///
  /// In es, this message translates to:
  /// **'No se pudo generar el reporte.'**
  String get exportFailedDetail;

  /// No description provided for @readingsExportAction.
  ///
  /// In es, this message translates to:
  /// **'Exportar lecturas (Excel)'**
  String get readingsExportAction;

  /// No description provided for @purchasingTabOrders.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get purchasingTabOrders;

  /// No description provided for @purchasingTabExpenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get purchasingTabExpenses;

  /// No description provided for @purchasingTabSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias'**
  String get purchasingTabSuggestions;

  /// No description provided for @purchasingTabConsolidated.
  ///
  /// In es, this message translates to:
  /// **'Consolidadas'**
  String get purchasingTabConsolidated;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get filterAll;

  /// No description provided for @filterAnyPayment.
  ///
  /// In es, this message translates to:
  /// **'Cualquier pago'**
  String get filterAnyPayment;

  /// No description provided for @purchaseOrdersEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay órdenes de compra para mostrar.'**
  String get purchaseOrdersEmpty;

  /// No description provided for @expenseOrdersEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay órdenes de gasto para mostrar.'**
  String get expenseOrdersEmpty;

  /// No description provided for @statusUnknown.
  ///
  /// In es, this message translates to:
  /// **'Sin clasificar'**
  String get statusUnknown;

  /// No description provided for @orderStatusDraft.
  ///
  /// In es, this message translates to:
  /// **'Borrador'**
  String get orderStatusDraft;

  /// No description provided for @orderStatusPendingApproval.
  ///
  /// In es, this message translates to:
  /// **'Por aprobar'**
  String get orderStatusPendingApproval;

  /// No description provided for @orderStatusApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobada'**
  String get orderStatusApproved;

  /// No description provided for @orderStatusRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazada'**
  String get orderStatusRejected;

  /// No description provided for @orderStatusSent.
  ///
  /// In es, this message translates to:
  /// **'Enviada'**
  String get orderStatusSent;

  /// No description provided for @orderStatusPartiallyReceived.
  ///
  /// In es, this message translates to:
  /// **'Recibida parcial'**
  String get orderStatusPartiallyReceived;

  /// No description provided for @orderStatusReceived.
  ///
  /// In es, this message translates to:
  /// **'Recibida'**
  String get orderStatusReceived;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelada'**
  String get orderStatusCancelled;

  /// No description provided for @paymentUnpaid.
  ///
  /// In es, this message translates to:
  /// **'Sin pagar'**
  String get paymentUnpaid;

  /// No description provided for @paymentPartial.
  ///
  /// In es, this message translates to:
  /// **'Pago parcial'**
  String get paymentPartial;

  /// No description provided for @paymentPaid.
  ///
  /// In es, this message translates to:
  /// **'Pagada'**
  String get paymentPaid;

  /// No description provided for @paymentMethodCash.
  ///
  /// In es, this message translates to:
  /// **'Efectivo'**
  String get paymentMethodCash;

  /// No description provided for @paymentMethodTransfer.
  ///
  /// In es, this message translates to:
  /// **'Transferencia'**
  String get paymentMethodTransfer;

  /// No description provided for @paymentMethodCheck.
  ///
  /// In es, this message translates to:
  /// **'Cheque'**
  String get paymentMethodCheck;

  /// No description provided for @paymentMethodOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get paymentMethodOther;

  /// No description provided for @orderDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Orden'**
  String get orderDetailTitle;

  /// No description provided for @orderWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén de destino'**
  String get orderWarehouse;

  /// No description provided for @orderCostCenter.
  ///
  /// In es, this message translates to:
  /// **'Centro de costo'**
  String get orderCostCenter;

  /// No description provided for @orderExpectedDate.
  ///
  /// In es, this message translates to:
  /// **'Entrega esperada'**
  String get orderExpectedDate;

  /// No description provided for @orderCreatedAt.
  ///
  /// In es, this message translates to:
  /// **'Creada'**
  String get orderCreatedAt;

  /// No description provided for @orderSentAt.
  ///
  /// In es, this message translates to:
  /// **'Enviada'**
  String get orderSentAt;

  /// No description provided for @orderReceivedAt.
  ///
  /// In es, this message translates to:
  /// **'Recibida'**
  String get orderReceivedAt;

  /// No description provided for @orderNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get orderNotes;

  /// No description provided for @orderLines.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get orderLines;

  /// No description provided for @orderSubtotal.
  ///
  /// In es, this message translates to:
  /// **'Subtotal'**
  String get orderSubtotal;

  /// No description provided for @orderTax.
  ///
  /// In es, this message translates to:
  /// **'Impuestos'**
  String get orderTax;

  /// No description provided for @orderTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// No description provided for @orderSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar a aprobación'**
  String get orderSubmit;

  /// No description provided for @orderSubmitted.
  ///
  /// In es, this message translates to:
  /// **'La orden quedó pendiente de aprobación.'**
  String get orderSubmitted;

  /// No description provided for @orderApprove.
  ///
  /// In es, this message translates to:
  /// **'Aprobar'**
  String get orderApprove;

  /// No description provided for @orderApproveTitle.
  ///
  /// In es, this message translates to:
  /// **'Aprobar orden'**
  String get orderApproveTitle;

  /// No description provided for @orderApproved.
  ///
  /// In es, this message translates to:
  /// **'Orden aprobada.'**
  String get orderApproved;

  /// No description provided for @orderReject.
  ///
  /// In es, this message translates to:
  /// **'Rechazar'**
  String get orderReject;

  /// No description provided for @orderRejectTitle.
  ///
  /// In es, this message translates to:
  /// **'Rechazar orden'**
  String get orderRejectTitle;

  /// No description provided for @orderRejected.
  ///
  /// In es, this message translates to:
  /// **'Orden rechazada.'**
  String get orderRejected;

  /// No description provided for @orderSend.
  ///
  /// In es, this message translates to:
  /// **'Enviar al proveedor'**
  String get orderSend;

  /// No description provided for @orderSentMessage.
  ///
  /// In es, this message translates to:
  /// **'Orden enviada al proveedor.'**
  String get orderSentMessage;

  /// No description provided for @orderReceive.
  ///
  /// In es, this message translates to:
  /// **'Recibir mercancía'**
  String get orderReceive;

  /// No description provided for @orderReceiveTitle.
  ///
  /// In es, this message translates to:
  /// **'Recibir mercancía'**
  String get orderReceiveTitle;

  /// No description provided for @orderReceiveConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar recepción'**
  String get orderReceiveConfirm;

  /// No description provided for @orderReceived.
  ///
  /// In es, this message translates to:
  /// **'Recepción registrada.'**
  String get orderReceived;

  /// No description provided for @orderReceiveHint.
  ///
  /// In es, this message translates to:
  /// **'Escriba la cantidad que recibe de cada producto. Las líneas sin cantidad se omiten; si recibe menos de lo pedido, la orden queda como recibida parcial.'**
  String get orderReceiveHint;

  /// No description provided for @orderReceiveNothing.
  ///
  /// In es, this message translates to:
  /// **'Escriba la cantidad recibida de al menos un producto.'**
  String get orderReceiveNothing;

  /// No description provided for @orderNothingPending.
  ///
  /// In es, this message translates to:
  /// **'Esta orden no tiene productos pendientes de recibir.'**
  String get orderNothingPending;

  /// No description provided for @orderQuantityExceedsPending.
  ///
  /// In es, this message translates to:
  /// **'No puede recibir más de lo que está pendiente.'**
  String get orderQuantityExceedsPending;

  /// No description provided for @orderNoWarehouse.
  ///
  /// In es, this message translates to:
  /// **'La orden no tiene almacén de destino; no se pueden elegir ubicaciones.'**
  String get orderNoWarehouse;

  /// No description provided for @orderCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar orden'**
  String get orderCancel;

  /// No description provided for @orderCancelTitle.
  ///
  /// In es, this message translates to:
  /// **'Cancelar orden'**
  String get orderCancelTitle;

  /// No description provided for @orderCancelBody.
  ///
  /// In es, this message translates to:
  /// **'La orden quedará cancelada y no se podrá reactivar. ¿Desea continuar?'**
  String get orderCancelBody;

  /// No description provided for @orderCancelled.
  ///
  /// In es, this message translates to:
  /// **'Orden cancelada.'**
  String get orderCancelled;

  /// No description provided for @orderTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, actualice la orden: es posible que el cambio sí se haya registrado.'**
  String get orderTimeoutWarning;

  /// No description provided for @fieldSupplier.
  ///
  /// In es, this message translates to:
  /// **'Proveedor'**
  String get fieldSupplier;

  /// No description provided for @fieldQuantityReceived.
  ///
  /// In es, this message translates to:
  /// **'Cantidad recibida'**
  String get fieldQuantityReceived;

  /// No description provided for @fieldCommentsOptional.
  ///
  /// In es, this message translates to:
  /// **'Comentarios (opcional)'**
  String get fieldCommentsOptional;

  /// No description provided for @fieldInvoiceNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de factura'**
  String get fieldInvoiceNumber;

  /// No description provided for @fieldInvoiceDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de factura'**
  String get fieldInvoiceDate;

  /// No description provided for @fieldAmount.
  ///
  /// In es, this message translates to:
  /// **'Valor'**
  String get fieldAmount;

  /// No description provided for @fieldPaymentMethod.
  ///
  /// In es, this message translates to:
  /// **'Forma de pago'**
  String get fieldPaymentMethod;

  /// No description provided for @fieldPaymentDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de pago'**
  String get fieldPaymentDate;

  /// No description provided for @fieldReference.
  ///
  /// In es, this message translates to:
  /// **'Referencia (opcional)'**
  String get fieldReference;

  /// No description provided for @expenseInvoiceTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar factura'**
  String get expenseInvoiceTitle;

  /// No description provided for @expenseRegisterInvoice.
  ///
  /// In es, this message translates to:
  /// **'Registrar factura'**
  String get expenseRegisterInvoice;

  /// No description provided for @expenseInvoiceSaved.
  ///
  /// In es, this message translates to:
  /// **'Factura registrada.'**
  String get expenseInvoiceSaved;

  /// No description provided for @expenseSendAccounting.
  ///
  /// In es, this message translates to:
  /// **'Enviar a contabilidad'**
  String get expenseSendAccounting;

  /// No description provided for @expenseAccountingTitle.
  ///
  /// In es, this message translates to:
  /// **'Enviar a contabilidad'**
  String get expenseAccountingTitle;

  /// No description provided for @expenseAccountingSent.
  ///
  /// In es, this message translates to:
  /// **'Orden enviada a contabilidad.'**
  String get expenseAccountingSent;

  /// No description provided for @expenseAccountingSentAt.
  ///
  /// In es, this message translates to:
  /// **'Enviada a contabilidad'**
  String get expenseAccountingSentAt;

  /// No description provided for @expensePayments.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get expensePayments;

  /// No description provided for @expensePaid.
  ///
  /// In es, this message translates to:
  /// **'Pagado'**
  String get expensePaid;

  /// No description provided for @expenseBalance.
  ///
  /// In es, this message translates to:
  /// **'Saldo pendiente'**
  String get expenseBalance;

  /// No description provided for @expensePaymentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay pagos registrados.'**
  String get expensePaymentsEmpty;

  /// No description provided for @expenseAddPayment.
  ///
  /// In es, this message translates to:
  /// **'Registrar pago'**
  String get expenseAddPayment;

  /// No description provided for @expensePaymentTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar pago'**
  String get expensePaymentTitle;

  /// No description provided for @expensePaymentSaved.
  ///
  /// In es, this message translates to:
  /// **'Pago registrado.'**
  String get expensePaymentSaved;

  /// No description provided for @expenseAmountExceeds.
  ///
  /// In es, this message translates to:
  /// **'El valor no puede superar el saldo pendiente.'**
  String get expenseAmountExceeds;

  /// No description provided for @expenseDeletePayment.
  ///
  /// In es, this message translates to:
  /// **'Eliminar pago'**
  String get expenseDeletePayment;

  /// No description provided for @expenseDeletePaymentBody.
  ///
  /// In es, this message translates to:
  /// **'El pago se eliminará y el saldo de la orden se recalculará. ¿Desea continuar?'**
  String get expenseDeletePaymentBody;

  /// No description provided for @expensePaymentDeleted.
  ///
  /// In es, this message translates to:
  /// **'Pago eliminado.'**
  String get expensePaymentDeleted;

  /// No description provided for @suggestionsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Ningún producto está por debajo de su punto de reorden.'**
  String get suggestionsEmpty;

  /// No description provided for @consolidatedEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay órdenes consolidadas.'**
  String get consolidatedEmpty;

  /// No description provided for @consolidateAction.
  ///
  /// In es, this message translates to:
  /// **'Consolidar órdenes'**
  String get consolidateAction;

  /// No description provided for @consolidateTitle.
  ///
  /// In es, this message translates to:
  /// **'Consolidar órdenes'**
  String get consolidateTitle;

  /// No description provided for @consolidatePreview.
  ///
  /// In es, this message translates to:
  /// **'Ver vista previa'**
  String get consolidatePreview;

  /// No description provided for @consolidateOrders.
  ///
  /// In es, this message translates to:
  /// **'Órdenes recibidas'**
  String get consolidateOrders;

  /// No description provided for @consolidateNoSuppliers.
  ///
  /// In es, this message translates to:
  /// **'No hay órdenes recibidas pendientes de consolidar.'**
  String get consolidateNoSuppliers;

  /// No description provided for @consolidateConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear orden consolidada'**
  String get consolidateConfirmTitle;

  /// No description provided for @consolidateCreated.
  ///
  /// In es, this message translates to:
  /// **'Orden consolidada creada.'**
  String get consolidateCreated;

  /// No description provided for @consolidatedDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Orden consolidada'**
  String get consolidatedDetailTitle;

  /// No description provided for @consolidatedPeriod.
  ///
  /// In es, this message translates to:
  /// **'Periodo'**
  String get consolidatedPeriod;

  /// No description provided for @orderQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad: {quantity}'**
  String orderQuantity(String quantity);

  /// No description provided for @orderQuantities.
  ///
  /// In es, this message translates to:
  /// **'Pedido: {requested} · Recibido: {received}'**
  String orderQuantities(String requested, String received);

  /// No description provided for @orderUnitPrice.
  ///
  /// In es, this message translates to:
  /// **'{price} c/u'**
  String orderUnitPrice(String price);

  /// No description provided for @orderPendingQuantity.
  ///
  /// In es, this message translates to:
  /// **'Pendiente por recibir: {quantity}'**
  String orderPendingQuantity(String quantity);

  /// No description provided for @expenseBalanceHint.
  ///
  /// In es, this message translates to:
  /// **'Saldo pendiente: {balance}'**
  String expenseBalanceHint(String balance);

  /// No description provided for @suggestionStock.
  ///
  /// In es, this message translates to:
  /// **'Existencias: {stock} · Punto de reorden: {reorder}'**
  String suggestionStock(String stock, String reorder);

  /// No description provided for @suggestionSupplier.
  ///
  /// In es, this message translates to:
  /// **'Proveedor sugerido: {name}'**
  String suggestionSupplier(String name);

  /// No description provided for @suggestionLeadTime.
  ///
  /// In es, this message translates to:
  /// **'Entrega estimada: {days} días'**
  String suggestionLeadTime(int days);

  /// No description provided for @suggestionQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad sugerida: {quantity}'**
  String suggestionQuantity(String quantity);

  /// No description provided for @consolidateConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Se consolidarán {count} órdenes recibidas en una sola. ¿Desea continuar?'**
  String consolidateConfirmBody(int count);

  /// No description provided for @periodRange.
  ///
  /// In es, this message translates to:
  /// **'{from} – {to}'**
  String periodRange(String from, String to);

  /// No description provided for @loadMore.
  ///
  /// In es, this message translates to:
  /// **'Cargar más'**
  String get loadMore;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @assetStatusOperational.
  ///
  /// In es, this message translates to:
  /// **'Operativo'**
  String get assetStatusOperational;

  /// No description provided for @assetStatusMaintenance.
  ///
  /// In es, this message translates to:
  /// **'En mantenimiento'**
  String get assetStatusMaintenance;

  /// No description provided for @assetStatusOutOfService.
  ///
  /// In es, this message translates to:
  /// **'Fuera de servicio'**
  String get assetStatusOutOfService;

  /// No description provided for @assetStatusAvailable.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get assetStatusAvailable;

  /// No description provided for @assetStatusRetired.
  ///
  /// In es, this message translates to:
  /// **'Dado de baja'**
  String get assetStatusRetired;

  /// No description provided for @assetTypeBiomedical.
  ///
  /// In es, this message translates to:
  /// **'Biomédico'**
  String get assetTypeBiomedical;

  /// No description provided for @assetTypeComputing.
  ///
  /// In es, this message translates to:
  /// **'Cómputo'**
  String get assetTypeComputing;

  /// No description provided for @assetTypeGeneral.
  ///
  /// In es, this message translates to:
  /// **'General'**
  String get assetTypeGeneral;

  /// No description provided for @assetScanAction.
  ///
  /// In es, this message translates to:
  /// **'Escanear etiqueta'**
  String get assetScanAction;

  /// No description provided for @assetSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre o código'**
  String get assetSearchHint;

  /// No description provided for @assetsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay activos para mostrar.'**
  String get assetsEmpty;

  /// No description provided for @assetFilterOverdue.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento vencido'**
  String get assetFilterOverdue;

  /// No description provided for @assetStatTotal.
  ///
  /// In es, this message translates to:
  /// **'Activos'**
  String get assetStatTotal;

  /// No description provided for @assetStatInMaintenance.
  ///
  /// In es, this message translates to:
  /// **'En mantenimiento'**
  String get assetStatInMaintenance;

  /// No description provided for @assetStatOverdue.
  ///
  /// In es, this message translates to:
  /// **'Mantenimientos vencidos'**
  String get assetStatOverdue;

  /// No description provided for @assetStatPendingTransfers.
  ///
  /// In es, this message translates to:
  /// **'Traslados pendientes'**
  String get assetStatPendingTransfers;

  /// No description provided for @assetStatOffPremises.
  ///
  /// In es, this message translates to:
  /// **'Fuera de las instalaciones'**
  String get assetStatOffPremises;

  /// No description provided for @assetDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Activo'**
  String get assetDetailTitle;

  /// No description provided for @assetTabData.
  ///
  /// In es, this message translates to:
  /// **'Datos'**
  String get assetTabData;

  /// No description provided for @assetTabHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get assetTabHistory;

  /// No description provided for @assetTabComments.
  ///
  /// In es, this message translates to:
  /// **'Comentarios'**
  String get assetTabComments;

  /// No description provided for @assetCode.
  ///
  /// In es, this message translates to:
  /// **'Código'**
  String get assetCode;

  /// No description provided for @assetType.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get assetType;

  /// No description provided for @assetCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get assetCategory;

  /// No description provided for @assetLocation.
  ///
  /// In es, this message translates to:
  /// **'Ubicación actual'**
  String get assetLocation;

  /// No description provided for @assetResponsible.
  ///
  /// In es, this message translates to:
  /// **'Responsable'**
  String get assetResponsible;

  /// No description provided for @assetBrand.
  ///
  /// In es, this message translates to:
  /// **'Marca'**
  String get assetBrand;

  /// No description provided for @assetModel.
  ///
  /// In es, this message translates to:
  /// **'Modelo'**
  String get assetModel;

  /// No description provided for @assetSerial.
  ///
  /// In es, this message translates to:
  /// **'Serie'**
  String get assetSerial;

  /// No description provided for @assetSupplier.
  ///
  /// In es, this message translates to:
  /// **'Proveedor'**
  String get assetSupplier;

  /// No description provided for @assetInvoice.
  ///
  /// In es, this message translates to:
  /// **'Factura'**
  String get assetInvoice;

  /// No description provided for @assetAcquisition.
  ///
  /// In es, this message translates to:
  /// **'Fecha de adquisición'**
  String get assetAcquisition;

  /// No description provided for @assetAcquisitionValue.
  ///
  /// In es, this message translates to:
  /// **'Valor de adquisición'**
  String get assetAcquisitionValue;

  /// No description provided for @assetWarrantyUntil.
  ///
  /// In es, this message translates to:
  /// **'Garantía hasta'**
  String get assetWarrantyUntil;

  /// No description provided for @assetDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get assetDescription;

  /// No description provided for @assetRetiredAt.
  ///
  /// In es, this message translates to:
  /// **'Fecha de baja'**
  String get assetRetiredAt;

  /// No description provided for @assetRetirementReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo de la baja'**
  String get assetRetirementReason;

  /// No description provided for @assetTechnicalProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil técnico'**
  String get assetTechnicalProfile;

  /// No description provided for @assetLifeSheet.
  ///
  /// In es, this message translates to:
  /// **'Hoja de vida (PDF)'**
  String get assetLifeSheet;

  /// No description provided for @assetLocationHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial de ubicaciones'**
  String get assetLocationHistory;

  /// No description provided for @assetLocationHistoryEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin ubicaciones registradas.'**
  String get assetLocationHistoryEmpty;

  /// No description provided for @assetUntilNow.
  ///
  /// In es, this message translates to:
  /// **'hoy'**
  String get assetUntilNow;

  /// No description provided for @assetCurrent.
  ///
  /// In es, this message translates to:
  /// **'Actual'**
  String get assetCurrent;

  /// No description provided for @assetEvents.
  ///
  /// In es, this message translates to:
  /// **'Bitácora'**
  String get assetEvents;

  /// No description provided for @assetEventsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay eventos registrados.'**
  String get assetEventsEmpty;

  /// No description provided for @assetCommentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este activo no tiene comentarios.'**
  String get assetCommentsEmpty;

  /// No description provided for @assetCommentField.
  ///
  /// In es, this message translates to:
  /// **'Escriba un comentario'**
  String get assetCommentField;

  /// No description provided for @assetCommentAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar comentario'**
  String get assetCommentAdd;

  /// No description provided for @assetCommentAdded.
  ///
  /// In es, this message translates to:
  /// **'Comentario agregado.'**
  String get assetCommentAdded;

  /// No description provided for @assetCommentTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, revise los comentarios: es posible que sí se haya agregado.'**
  String get assetCommentTimeoutWarning;

  /// No description provided for @techManufacturer.
  ///
  /// In es, this message translates to:
  /// **'Fabricante'**
  String get techManufacturer;

  /// No description provided for @techCountry.
  ///
  /// In es, this message translates to:
  /// **'País de origen'**
  String get techCountry;

  /// No description provided for @techYear.
  ///
  /// In es, this message translates to:
  /// **'Año de fabricación'**
  String get techYear;

  /// No description provided for @techUsefulLife.
  ///
  /// In es, this message translates to:
  /// **'Vida útil (años)'**
  String get techUsefulLife;

  /// No description provided for @techAcquisitionMode.
  ///
  /// In es, this message translates to:
  /// **'Forma de adquisición'**
  String get techAcquisitionMode;

  /// No description provided for @techAccessories.
  ///
  /// In es, this message translates to:
  /// **'Accesorios'**
  String get techAccessories;

  /// No description provided for @techRecommendations.
  ///
  /// In es, this message translates to:
  /// **'Recomendaciones de uso'**
  String get techRecommendations;

  /// No description provided for @techInvima.
  ///
  /// In es, this message translates to:
  /// **'Registro INVIMA'**
  String get techInvima;

  /// No description provided for @techRiskClass.
  ///
  /// In es, this message translates to:
  /// **'Clasificación de riesgo'**
  String get techRiskClass;

  /// No description provided for @techBiomedicalClass.
  ///
  /// In es, this message translates to:
  /// **'Clase biomédica'**
  String get techBiomedicalClass;

  /// No description provided for @techPowerSource.
  ///
  /// In es, this message translates to:
  /// **'Fuente de energía'**
  String get techPowerSource;

  /// No description provided for @techVoltage.
  ///
  /// In es, this message translates to:
  /// **'Voltaje'**
  String get techVoltage;

  /// No description provided for @techCurrent.
  ///
  /// In es, this message translates to:
  /// **'Corriente'**
  String get techCurrent;

  /// No description provided for @techPower.
  ///
  /// In es, this message translates to:
  /// **'Potencia'**
  String get techPower;

  /// No description provided for @techFrequency.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia'**
  String get techFrequency;

  /// No description provided for @techRequiresCalibration.
  ///
  /// In es, this message translates to:
  /// **'Requiere calibración'**
  String get techRequiresCalibration;

  /// No description provided for @techOperatingConditions.
  ///
  /// In es, this message translates to:
  /// **'Condiciones de operación'**
  String get techOperatingConditions;

  /// No description provided for @techProcessor.
  ///
  /// In es, this message translates to:
  /// **'Procesador'**
  String get techProcessor;

  /// No description provided for @techRam.
  ///
  /// In es, this message translates to:
  /// **'Memoria RAM'**
  String get techRam;

  /// No description provided for @techStorage.
  ///
  /// In es, this message translates to:
  /// **'Almacenamiento'**
  String get techStorage;

  /// No description provided for @techOperatingSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema operativo'**
  String get techOperatingSystem;

  /// No description provided for @techIp.
  ///
  /// In es, this message translates to:
  /// **'Dirección IP'**
  String get techIp;

  /// No description provided for @techMac.
  ///
  /// In es, this message translates to:
  /// **'Dirección MAC'**
  String get techMac;

  /// No description provided for @techHostname.
  ///
  /// In es, this message translates to:
  /// **'Nombre de equipo'**
  String get techHostname;

  /// No description provided for @assetScanNotFound.
  ///
  /// In es, this message translates to:
  /// **'No hay un activo con el código {code}.'**
  String assetScanNotFound(String code);

  /// No description provided for @assetMaintenanceOverdueOn.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento vencido desde el {date}'**
  String assetMaintenanceOverdueOn(String date);

  /// No description provided for @assetPendingTransfer.
  ///
  /// In es, this message translates to:
  /// **'Traslado pendiente de firma: {type}'**
  String assetPendingTransfer(String type);

  /// No description provided for @assetsTabAssets.
  ///
  /// In es, this message translates to:
  /// **'Activos'**
  String get assetsTabAssets;

  /// No description provided for @assetsTabTransfers.
  ///
  /// In es, this message translates to:
  /// **'Traslados'**
  String get assetsTabTransfers;

  /// No description provided for @transfersEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay traslados para mostrar.'**
  String get transfersEmpty;

  /// No description provided for @transferStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de firma'**
  String get transferStatusPending;

  /// No description provided for @transferStatusConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirmado'**
  String get transferStatusConfirmed;

  /// No description provided for @transferStatusCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelado'**
  String get transferStatusCancelled;

  /// No description provided for @transferTypeRelocation.
  ///
  /// In es, this message translates to:
  /// **'Traslado interno'**
  String get transferTypeRelocation;

  /// No description provided for @transferTypeExternalRepair.
  ///
  /// In es, this message translates to:
  /// **'Salida a reparación externa'**
  String get transferTypeExternalRepair;

  /// No description provided for @transferTypeLoan.
  ///
  /// In es, this message translates to:
  /// **'Préstamo externo'**
  String get transferTypeLoan;

  /// No description provided for @transferTypeReturn.
  ///
  /// In es, this message translates to:
  /// **'Retorno a las instalaciones'**
  String get transferTypeReturn;

  /// No description provided for @transferTypeRetirement.
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get transferTypeRetirement;

  /// No description provided for @transferDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Traslado'**
  String get transferDetailTitle;

  /// No description provided for @transferFrom.
  ///
  /// In es, this message translates to:
  /// **'Origen'**
  String get transferFrom;

  /// No description provided for @transferTo.
  ///
  /// In es, this message translates to:
  /// **'Destino'**
  String get transferTo;

  /// No description provided for @transferExternalDestination.
  ///
  /// In es, this message translates to:
  /// **'Destino externo'**
  String get transferExternalDestination;

  /// No description provided for @transferFromResponsible.
  ///
  /// In es, this message translates to:
  /// **'Responsable anterior'**
  String get transferFromResponsible;

  /// No description provided for @transferToResponsible.
  ///
  /// In es, this message translates to:
  /// **'Nuevo responsable'**
  String get transferToResponsible;

  /// No description provided for @transferExpectedReturn.
  ///
  /// In es, this message translates to:
  /// **'Retorno esperado'**
  String get transferExpectedReturn;

  /// No description provided for @transferReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo'**
  String get transferReason;

  /// No description provided for @transferRequestedBy.
  ///
  /// In es, this message translates to:
  /// **'Solicitado por'**
  String get transferRequestedBy;

  /// No description provided for @transferConfirmedAt.
  ///
  /// In es, this message translates to:
  /// **'Confirmado'**
  String get transferConfirmedAt;

  /// No description provided for @transferCancelReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo de la cancelación'**
  String get transferCancelReason;

  /// No description provided for @transferAct.
  ///
  /// In es, this message translates to:
  /// **'Acta del traslado (PDF)'**
  String get transferAct;

  /// No description provided for @transferCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar traslado'**
  String get transferCancel;

  /// No description provided for @transferCancelTitle.
  ///
  /// In es, this message translates to:
  /// **'Cancelar traslado'**
  String get transferCancelTitle;

  /// No description provided for @transferCancelled.
  ///
  /// In es, this message translates to:
  /// **'Traslado cancelado.'**
  String get transferCancelled;

  /// No description provided for @transferConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Traslado confirmado.'**
  String get transferConfirmed;

  /// No description provided for @transferTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, actualice el traslado: es posible que el cambio sí se haya registrado.'**
  String get transferTimeoutWarning;

  /// No description provided for @transferRequestTitle.
  ///
  /// In es, this message translates to:
  /// **'Solicitar traslado'**
  String get transferRequestTitle;

  /// No description provided for @transferRequestAction.
  ///
  /// In es, this message translates to:
  /// **'Solicitar traslado'**
  String get transferRequestAction;

  /// No description provided for @transferType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de traslado'**
  String get transferType;

  /// No description provided for @transferNeedsSignature.
  ///
  /// In es, this message translates to:
  /// **'Este tipo de traslado queda pendiente hasta que se confirme con las firmas de quien entrega y de quien recibe.'**
  String get transferNeedsSignature;

  /// No description provided for @transferSite.
  ///
  /// In es, this message translates to:
  /// **'Sede'**
  String get transferSite;

  /// No description provided for @transferPlace.
  ///
  /// In es, this message translates to:
  /// **'Lugar'**
  String get transferPlace;

  /// No description provided for @transferNewResponsible.
  ///
  /// In es, this message translates to:
  /// **'Nuevo responsable'**
  String get transferNewResponsible;

  /// No description provided for @transferKeepResponsible.
  ///
  /// In es, this message translates to:
  /// **'Mantener el actual'**
  String get transferKeepResponsible;

  /// No description provided for @transferReasonOptional.
  ///
  /// In es, this message translates to:
  /// **'Motivo (opcional)'**
  String get transferReasonOptional;

  /// No description provided for @transferRequestedPending.
  ///
  /// In es, this message translates to:
  /// **'Traslado solicitado. Falta confirmarlo con las firmas.'**
  String get transferRequestedPending;

  /// No description provided for @transferApplied.
  ///
  /// In es, this message translates to:
  /// **'Traslado aplicado.'**
  String get transferApplied;

  /// No description provided for @maintenanceStatusScheduled.
  ///
  /// In es, this message translates to:
  /// **'Programado'**
  String get maintenanceStatusScheduled;

  /// No description provided for @maintenanceStatusOverdue.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get maintenanceStatusOverdue;

  /// No description provided for @maintenanceStatusInProgress.
  ///
  /// In es, this message translates to:
  /// **'En curso'**
  String get maintenanceStatusInProgress;

  /// No description provided for @maintenanceStatusCompleted.
  ///
  /// In es, this message translates to:
  /// **'Realizado'**
  String get maintenanceStatusCompleted;

  /// No description provided for @maintenanceStatusCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelado'**
  String get maintenanceStatusCancelled;

  /// No description provided for @maintenanceTypePreventive.
  ///
  /// In es, this message translates to:
  /// **'Preventivo'**
  String get maintenanceTypePreventive;

  /// No description provided for @maintenanceTypeCalibration.
  ///
  /// In es, this message translates to:
  /// **'Calibración'**
  String get maintenanceTypeCalibration;

  /// No description provided for @maintenanceTypeMetrological.
  ///
  /// In es, this message translates to:
  /// **'Verificación metrológica'**
  String get maintenanceTypeMetrological;

  /// No description provided for @maintenanceTypeInspection.
  ///
  /// In es, this message translates to:
  /// **'Inspección'**
  String get maintenanceTypeInspection;

  /// No description provided for @maintenanceTypeCorrective.
  ///
  /// In es, this message translates to:
  /// **'Correctivo'**
  String get maintenanceTypeCorrective;

  /// No description provided for @maintenanceResultOperational.
  ///
  /// In es, this message translates to:
  /// **'Operativo'**
  String get maintenanceResultOperational;

  /// No description provided for @maintenanceResultRestricted.
  ///
  /// In es, this message translates to:
  /// **'Operativo con restricciones'**
  String get maintenanceResultRestricted;

  /// No description provided for @maintenanceResultOutOfService.
  ///
  /// In es, this message translates to:
  /// **'Fuera de servicio'**
  String get maintenanceResultOutOfService;

  /// No description provided for @maintenanceEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay mantenimientos para mostrar.'**
  String get maintenanceEmpty;

  /// No description provided for @maintenanceDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento'**
  String get maintenanceDetailTitle;

  /// No description provided for @maintenanceScheduledDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha programada'**
  String get maintenanceScheduledDate;

  /// No description provided for @maintenanceStartedAt.
  ///
  /// In es, this message translates to:
  /// **'Iniciado'**
  String get maintenanceStartedAt;

  /// No description provided for @maintenancePerformedAt.
  ///
  /// In es, this message translates to:
  /// **'Fecha de ejecución'**
  String get maintenancePerformedAt;

  /// No description provided for @maintenanceReportedFailure.
  ///
  /// In es, this message translates to:
  /// **'Falla reportada'**
  String get maintenanceReportedFailure;

  /// No description provided for @maintenanceTechnician.
  ///
  /// In es, this message translates to:
  /// **'Técnico'**
  String get maintenanceTechnician;

  /// No description provided for @maintenanceActivities.
  ///
  /// In es, this message translates to:
  /// **'Actividades realizadas'**
  String get maintenanceActivities;

  /// No description provided for @maintenanceFindings.
  ///
  /// In es, this message translates to:
  /// **'Hallazgos (opcional)'**
  String get maintenanceFindings;

  /// No description provided for @maintenanceRecommendations.
  ///
  /// In es, this message translates to:
  /// **'Recomendaciones (opcional)'**
  String get maintenanceRecommendations;

  /// No description provided for @maintenanceResult.
  ///
  /// In es, this message translates to:
  /// **'Resultado'**
  String get maintenanceResult;

  /// No description provided for @maintenanceCost.
  ///
  /// In es, this message translates to:
  /// **'Costo (opcional)'**
  String get maintenanceCost;

  /// No description provided for @maintenanceParts.
  ///
  /// In es, this message translates to:
  /// **'Repuestos cambiados'**
  String get maintenanceParts;

  /// No description provided for @maintenanceStart.
  ///
  /// In es, this message translates to:
  /// **'Iniciar mantenimiento'**
  String get maintenanceStart;

  /// No description provided for @maintenanceStartTitle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar mantenimiento'**
  String get maintenanceStartTitle;

  /// No description provided for @maintenanceStartBody.
  ///
  /// In es, this message translates to:
  /// **'El activo pasará a \"En mantenimiento\". ¿Desea continuar?'**
  String get maintenanceStartBody;

  /// No description provided for @maintenanceStarted.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento iniciado.'**
  String get maintenanceStarted;

  /// No description provided for @maintenanceComplete.
  ///
  /// In es, this message translates to:
  /// **'Registrar ejecución'**
  String get maintenanceComplete;

  /// No description provided for @maintenanceCompleteAction.
  ///
  /// In es, this message translates to:
  /// **'Registrar ejecución'**
  String get maintenanceCompleteAction;

  /// No description provided for @maintenanceCompleted.
  ///
  /// In es, this message translates to:
  /// **'Ejecución registrada.'**
  String get maintenanceCompleted;

  /// No description provided for @maintenanceCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar mantenimiento'**
  String get maintenanceCancel;

  /// No description provided for @maintenanceCancelTitle.
  ///
  /// In es, this message translates to:
  /// **'Cancelar mantenimiento'**
  String get maintenanceCancelTitle;

  /// No description provided for @maintenanceCancelled.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento cancelado.'**
  String get maintenanceCancelled;

  /// No description provided for @maintenanceReport.
  ///
  /// In es, this message translates to:
  /// **'Reporte del mantenimiento (PDF)'**
  String get maintenanceReport;

  /// No description provided for @maintenanceTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, actualice el mantenimiento: es posible que el cambio sí se haya registrado.'**
  String get maintenanceTimeoutWarning;

  /// No description provided for @maintenanceInternal.
  ///
  /// In es, this message translates to:
  /// **'Técnico interno'**
  String get maintenanceInternal;

  /// No description provided for @maintenanceExternal.
  ///
  /// In es, this message translates to:
  /// **'Proveedor externo'**
  String get maintenanceExternal;

  /// No description provided for @maintenanceExternalTechnician.
  ///
  /// In es, this message translates to:
  /// **'Nombre del técnico externo'**
  String get maintenanceExternalTechnician;

  /// No description provided for @maintenancePartAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar repuesto'**
  String get maintenancePartAdd;

  /// No description provided for @maintenancePartName.
  ///
  /// In es, this message translates to:
  /// **'Repuesto'**
  String get maintenancePartName;

  /// No description provided for @maintenancePartRemove.
  ///
  /// In es, this message translates to:
  /// **'Quitar repuesto'**
  String get maintenancePartRemove;

  /// No description provided for @assetViewMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Ver mantenimiento'**
  String get assetViewMaintenance;

  /// No description provided for @maintenanceScheduledFor.
  ///
  /// In es, this message translates to:
  /// **'Programado para el {date}'**
  String maintenanceScheduledFor(String date);

  /// No description provided for @assetTabDocuments.
  ///
  /// In es, this message translates to:
  /// **'Documentos'**
  String get assetTabDocuments;

  /// No description provided for @assetDocumentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este activo no tiene documentos.'**
  String get assetDocumentsEmpty;

  /// No description provided for @assetDocumentAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar documento'**
  String get assetDocumentAdd;

  /// No description provided for @assetDocumentTakePhoto.
  ///
  /// In es, this message translates to:
  /// **'Tomar una foto'**
  String get assetDocumentTakePhoto;

  /// No description provided for @assetDocumentGallery.
  ///
  /// In es, this message translates to:
  /// **'Elegir de la galería'**
  String get assetDocumentGallery;

  /// No description provided for @assetDocumentFile.
  ///
  /// In es, this message translates to:
  /// **'Elegir un archivo (PDF o imagen)'**
  String get assetDocumentFile;

  /// No description provided for @assetDocumentTooLarge.
  ///
  /// In es, this message translates to:
  /// **'El archivo supera los 10 MB. Elija uno más liviano.'**
  String get assetDocumentTooLarge;

  /// No description provided for @assetDocumentExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencido'**
  String get assetDocumentExpired;

  /// No description provided for @assetDocumentDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar documento'**
  String get assetDocumentDelete;

  /// No description provided for @assetDocumentDeleteBody.
  ///
  /// In es, this message translates to:
  /// **'El documento se eliminará del activo. ¿Desea continuar?'**
  String get assetDocumentDeleteBody;

  /// No description provided for @assetDocumentDeleted.
  ///
  /// In es, this message translates to:
  /// **'Documento eliminado.'**
  String get assetDocumentDeleted;

  /// No description provided for @assetDocumentType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de documento'**
  String get assetDocumentType;

  /// No description provided for @assetDocumentTitle.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get assetDocumentTitle;

  /// No description provided for @assetDocumentIssued.
  ///
  /// In es, this message translates to:
  /// **'Fecha de emisión (opcional)'**
  String get assetDocumentIssued;

  /// No description provided for @assetDocumentExpiry.
  ///
  /// In es, this message translates to:
  /// **'Fecha de vencimiento (opcional)'**
  String get assetDocumentExpiry;

  /// No description provided for @assetDocumentUpload.
  ///
  /// In es, this message translates to:
  /// **'Subir documento'**
  String get assetDocumentUpload;

  /// No description provided for @assetDocumentUploaded.
  ///
  /// In es, this message translates to:
  /// **'Documento agregado.'**
  String get assetDocumentUploaded;

  /// No description provided for @assetDocumentTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, revise los documentos del activo: es posible que sí se haya subido.'**
  String get assetDocumentTimeoutWarning;

  /// No description provided for @assetDocumentExpires.
  ///
  /// In es, this message translates to:
  /// **'Vence el {date}'**
  String assetDocumentExpires(String date);

  /// No description provided for @assetChangeStatus.
  ///
  /// In es, this message translates to:
  /// **'Cambiar estado'**
  String get assetChangeStatus;

  /// No description provided for @assetNewStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado nuevo'**
  String get assetNewStatus;

  /// No description provided for @assetStatusReason.
  ///
  /// In es, this message translates to:
  /// **'Motivo (opcional)'**
  String get assetStatusReason;

  /// No description provided for @assetStatusChanged.
  ///
  /// In es, this message translates to:
  /// **'Estado actualizado.'**
  String get assetStatusChanged;

  /// No description provided for @assetStatusTimeoutWarning.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Antes de repetirlo, actualice la ficha: es posible que el estado sí haya cambiado.'**
  String get assetStatusTimeoutWarning;

  /// No description provided for @assetMaintenancePlans.
  ///
  /// In es, this message translates to:
  /// **'Planes de mantenimiento'**
  String get assetMaintenancePlans;

  /// No description provided for @planUnitDays.
  ///
  /// In es, this message translates to:
  /// **'días'**
  String get planUnitDays;

  /// No description provided for @planUnitMonths.
  ///
  /// In es, this message translates to:
  /// **'meses'**
  String get planUnitMonths;

  /// No description provided for @planInactive.
  ///
  /// In es, this message translates to:
  /// **'Inactivo'**
  String get planInactive;

  /// No description provided for @planEvery.
  ///
  /// In es, this message translates to:
  /// **'Cada {value} {unit}'**
  String planEvery(int value, String unit);

  /// No description provided for @planNext.
  ///
  /// In es, this message translates to:
  /// **'Próximo: {date}'**
  String planNext(String date);

  /// No description provided for @clinicalTabRecords.
  ///
  /// In es, this message translates to:
  /// **'Registros'**
  String get clinicalTabRecords;

  /// No description provided for @clinicalTabPatients.
  ///
  /// In es, this message translates to:
  /// **'Pacientes'**
  String get clinicalTabPatients;

  /// No description provided for @clinicalRecordsSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Documento del paciente'**
  String get clinicalRecordsSearchHint;

  /// No description provided for @clinicalRecordsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay registros en los últimos {days} días.'**
  String clinicalRecordsEmpty(int days);

  /// No description provided for @clinicalPatientSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Documento o nombre del paciente'**
  String get clinicalPatientSearchHint;

  /// No description provided for @clinicalPatientSearchPrompt.
  ///
  /// In es, this message translates to:
  /// **'Escriba al menos {count} caracteres del documento o del nombre del paciente.'**
  String clinicalPatientSearchPrompt(int count);

  /// No description provided for @clinicalPatientTitle.
  ///
  /// In es, this message translates to:
  /// **'Paciente'**
  String get clinicalPatientTitle;

  /// No description provided for @clinicalPatientDocument.
  ///
  /// In es, this message translates to:
  /// **'Documento {document}'**
  String clinicalPatientDocument(String document);

  /// No description provided for @clinicalHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de procedimientos'**
  String get clinicalHistoryTitle;

  /// No description provided for @clinicalHistoryEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este paciente no tiene procedimientos registrados.'**
  String get clinicalHistoryEmpty;

  /// No description provided for @clinicalSummaryRecords.
  ///
  /// In es, this message translates to:
  /// **'Procedimientos'**
  String get clinicalSummaryRecords;

  /// No description provided for @clinicalSummaryAmount.
  ///
  /// In es, this message translates to:
  /// **'Total registrado'**
  String get clinicalSummaryAmount;

  /// No description provided for @clinicalSummaryFirst.
  ///
  /// In es, this message translates to:
  /// **'Primera atención'**
  String get clinicalSummaryFirst;

  /// No description provided for @clinicalSummaryLast.
  ///
  /// In es, this message translates to:
  /// **'Última atención'**
  String get clinicalSummaryLast;

  /// No description provided for @clinicalAppointmentsTitle.
  ///
  /// In es, this message translates to:
  /// **'Citas activas'**
  String get clinicalAppointmentsTitle;

  /// No description provided for @clinicalAppointmentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tiene citas activas.'**
  String get clinicalAppointmentsEmpty;

  /// No description provided for @clinicalRecentAppointmentsTitle.
  ///
  /// In es, this message translates to:
  /// **'Últimas citas'**
  String get clinicalRecentAppointmentsTitle;

  /// No description provided for @clinicalRecordTitle.
  ///
  /// In es, this message translates to:
  /// **'Registro de procedimiento'**
  String get clinicalRecordTitle;

  /// No description provided for @clinicalRecordService.
  ///
  /// In es, this message translates to:
  /// **'Servicio'**
  String get clinicalRecordService;

  /// No description provided for @clinicalRecordPatient.
  ///
  /// In es, this message translates to:
  /// **'Paciente'**
  String get clinicalRecordPatient;

  /// No description provided for @clinicalRecordDocument.
  ///
  /// In es, this message translates to:
  /// **'Documento'**
  String get clinicalRecordDocument;

  /// No description provided for @clinicalRecordDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de atención'**
  String get clinicalRecordDate;

  /// No description provided for @clinicalRecordQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get clinicalRecordQuantity;

  /// No description provided for @clinicalRecordUnitPrice.
  ///
  /// In es, this message translates to:
  /// **'Valor unitario'**
  String get clinicalRecordUnitPrice;

  /// No description provided for @clinicalRecordTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get clinicalRecordTotal;

  /// No description provided for @clinicalRecordDiscount.
  ///
  /// In es, this message translates to:
  /// **'Descuento'**
  String get clinicalRecordDiscount;

  /// No description provided for @clinicalRecordNetTotal.
  ///
  /// In es, this message translates to:
  /// **'Total neto'**
  String get clinicalRecordNetTotal;

  /// No description provided for @clinicalRecordBilling.
  ///
  /// In es, this message translates to:
  /// **'Facturación'**
  String get clinicalRecordBilling;

  /// No description provided for @clinicalRecordOrder.
  ///
  /// In es, this message translates to:
  /// **'Orden de servicio'**
  String get clinicalRecordOrder;

  /// No description provided for @clinicalRecordSeller.
  ///
  /// In es, this message translates to:
  /// **'Vendedor'**
  String get clinicalRecordSeller;

  /// No description provided for @clinicalRecordReferrer.
  ///
  /// In es, this message translates to:
  /// **'Remitente'**
  String get clinicalRecordReferrer;

  /// No description provided for @clinicalRecordInactive.
  ///
  /// In es, this message translates to:
  /// **'Inactivo'**
  String get clinicalRecordInactive;

  /// No description provided for @clinicalViewHistory.
  ///
  /// In es, this message translates to:
  /// **'Ver historial del paciente'**
  String get clinicalViewHistory;

  /// No description provided for @billingPending.
  ///
  /// In es, this message translates to:
  /// **'Sin facturar'**
  String get billingPending;

  /// No description provided for @billingBilled.
  ///
  /// In es, this message translates to:
  /// **'Facturado'**
  String get billingBilled;

  /// No description provided for @billingCancelled.
  ///
  /// In es, this message translates to:
  /// **'Anulado'**
  String get billingCancelled;

  /// No description provided for @saleTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar venta'**
  String get saleTitle;

  /// No description provided for @saleAction.
  ///
  /// In es, this message translates to:
  /// **'Registrar venta'**
  String get saleAction;

  /// No description provided for @saleChoosePatient.
  ///
  /// In es, this message translates to:
  /// **'Elegir paciente'**
  String get saleChoosePatient;

  /// No description provided for @saleSearchPatient.
  ///
  /// In es, this message translates to:
  /// **'Buscar paciente'**
  String get saleSearchPatient;

  /// No description provided for @saleChangePatient.
  ///
  /// In es, this message translates to:
  /// **'Cambiar paciente'**
  String get saleChangePatient;

  /// No description provided for @salePatientRequired.
  ///
  /// In es, this message translates to:
  /// **'Elija el paciente al que se le vende.'**
  String get salePatientRequired;

  /// No description provided for @saleServiceDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de atención'**
  String get saleServiceDate;

  /// No description provided for @saleSeller.
  ///
  /// In es, this message translates to:
  /// **'Vendedor'**
  String get saleSeller;

  /// No description provided for @saleReferrer.
  ///
  /// In es, this message translates to:
  /// **'Remitente'**
  String get saleReferrer;

  /// No description provided for @saleServicesTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get saleServicesTitle;

  /// No description provided for @saleAddService.
  ///
  /// In es, this message translates to:
  /// **'Agregar servicio'**
  String get saleAddService;

  /// No description provided for @saleChooseService.
  ///
  /// In es, this message translates to:
  /// **'Elegir servicio'**
  String get saleChooseService;

  /// No description provided for @saleServiceSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre o código del servicio'**
  String get saleServiceSearchHint;

  /// No description provided for @saleServiceSearchPrompt.
  ///
  /// In es, this message translates to:
  /// **'Escriba al menos {count} caracteres del nombre o del código.'**
  String saleServiceSearchPrompt(int count);

  /// No description provided for @saleNoPrice.
  ///
  /// In es, this message translates to:
  /// **'Sin tarifa'**
  String get saleNoPrice;

  /// No description provided for @saleServicesRequired.
  ///
  /// In es, this message translates to:
  /// **'Agregue al menos un servicio.'**
  String get saleServicesRequired;

  /// No description provided for @saleQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get saleQuantity;

  /// No description provided for @saleUnitPrice.
  ///
  /// In es, this message translates to:
  /// **'Valor unitario'**
  String get saleUnitPrice;

  /// No description provided for @saleTotal.
  ///
  /// In es, this message translates to:
  /// **'Total de la venta'**
  String get saleTotal;

  /// No description provided for @saleSubmit.
  ///
  /// In es, this message translates to:
  /// **'Registrar venta'**
  String get saleSubmit;

  /// No description provided for @saleLineSaved.
  ///
  /// In es, this message translates to:
  /// **'Registrado'**
  String get saleLineSaved;

  /// No description provided for @saleLineFailed.
  ///
  /// In es, this message translates to:
  /// **'No se registró'**
  String get saleLineFailed;

  /// No description provided for @saleLineUnconfirmed.
  ///
  /// In es, this message translates to:
  /// **'Sin confirmar'**
  String get saleLineUnconfirmed;

  /// No description provided for @saleLineUnconfirmedHelp.
  ///
  /// In es, this message translates to:
  /// **'El servidor no respondió y puede que sí se haya registrado. Revise los registros del paciente antes de enviarla de nuevo.'**
  String get saleLineUnconfirmedHelp;

  /// No description provided for @saleLineNotRegistered.
  ///
  /// In es, this message translates to:
  /// **'No se registró, enviar de nuevo'**
  String get saleLineNotRegistered;

  /// No description provided for @salePartialWarning.
  ///
  /// In es, this message translates to:
  /// **'Algunos servicios ya quedaron registrados y no se vuelven a enviar. Corrija lo pendiente y registre de nuevo.'**
  String get salePartialWarning;

  /// No description provided for @saleDone.
  ///
  /// In es, this message translates to:
  /// **'Venta registrada.'**
  String get saleDone;

  /// No description provided for @serviceOrderTabOrders.
  ///
  /// In es, this message translates to:
  /// **'Órdenes'**
  String get serviceOrderTabOrders;

  /// No description provided for @serviceOrderTabDiscounts.
  ///
  /// In es, this message translates to:
  /// **'Descuentos'**
  String get serviceOrderTabDiscounts;

  /// No description provided for @serviceOrderLookupHint.
  ///
  /// In es, this message translates to:
  /// **'Número de orden'**
  String get serviceOrderLookupHint;

  /// No description provided for @serviceOrderLookupAction.
  ///
  /// In es, this message translates to:
  /// **'Buscar orden'**
  String get serviceOrderLookupAction;

  /// No description provided for @serviceOrderLookupHelp.
  ///
  /// In es, this message translates to:
  /// **'Escriba el número completo, por ejemplo OS-20261126-000001.'**
  String get serviceOrderLookupHelp;

  /// No description provided for @serviceOrderNew.
  ///
  /// In es, this message translates to:
  /// **'Nueva orden'**
  String get serviceOrderNew;

  /// No description provided for @serviceOrderTitle.
  ///
  /// In es, this message translates to:
  /// **'Orden de servicio'**
  String get serviceOrderTitle;

  /// No description provided for @serviceOrderStatusApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobada'**
  String get serviceOrderStatusApproved;

  /// No description provided for @serviceOrderStatusDiscountPending.
  ///
  /// In es, this message translates to:
  /// **'Descuento por aprobar'**
  String get serviceOrderStatusDiscountPending;

  /// No description provided for @serviceOrderPatient.
  ///
  /// In es, this message translates to:
  /// **'Paciente'**
  String get serviceOrderPatient;

  /// No description provided for @serviceOrderProcedures.
  ///
  /// In es, this message translates to:
  /// **'Procedimientos'**
  String get serviceOrderProcedures;

  /// No description provided for @serviceOrderTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get serviceOrderTotal;

  /// No description provided for @serviceOrderDiscount.
  ///
  /// In es, this message translates to:
  /// **'Descuento'**
  String get serviceOrderDiscount;

  /// No description provided for @serviceOrderNetTotal.
  ///
  /// In es, this message translates to:
  /// **'Total neto'**
  String get serviceOrderNetTotal;

  /// No description provided for @serviceOrderApproveDiscount.
  ///
  /// In es, this message translates to:
  /// **'Aprobar descuento'**
  String get serviceOrderApproveDiscount;

  /// No description provided for @serviceOrderApproveConfirm.
  ///
  /// In es, this message translates to:
  /// **'Se aprobará el descuento de {amount} de la orden {number}.'**
  String serviceOrderApproveConfirm(String amount, String number);

  /// No description provided for @serviceOrderApproved.
  ///
  /// In es, this message translates to:
  /// **'Descuento aprobado.'**
  String get serviceOrderApproved;

  /// No description provided for @serviceOrderBill.
  ///
  /// In es, this message translates to:
  /// **'Marcar como facturada'**
  String get serviceOrderBill;

  /// No description provided for @serviceOrderBillConfirm.
  ///
  /// In es, this message translates to:
  /// **'La orden {number} quedará como facturada.'**
  String serviceOrderBillConfirm(String number);

  /// No description provided for @serviceOrderBilled.
  ///
  /// In es, this message translates to:
  /// **'Orden facturada.'**
  String get serviceOrderBilled;

  /// No description provided for @serviceOrderBillBlocked.
  ///
  /// In es, this message translates to:
  /// **'Apruebe el descuento antes de facturar.'**
  String get serviceOrderBillBlocked;

  /// No description provided for @serviceOrderCancel.
  ///
  /// In es, this message translates to:
  /// **'Anular orden'**
  String get serviceOrderCancel;

  /// No description provided for @serviceOrderCancelConfirm.
  ///
  /// In es, this message translates to:
  /// **'Se anulará la orden {number}. Anular no devuelve al inventario los insumos que ya salieron.'**
  String serviceOrderCancelConfirm(String number);

  /// No description provided for @serviceOrderCancelled.
  ///
  /// In es, this message translates to:
  /// **'Orden anulada.'**
  String get serviceOrderCancelled;

  /// No description provided for @serviceOrderActionTimeout.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Revise el estado de la orden antes de repetirlo.'**
  String get serviceOrderActionTimeout;

  /// No description provided for @serviceOrderDiscountsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay descuentos pendientes de aprobación.'**
  String get serviceOrderDiscountsEmpty;

  /// No description provided for @serviceOrderDiscountOf.
  ///
  /// In es, this message translates to:
  /// **'Descuento: {amount}'**
  String serviceOrderDiscountOf(String amount);

  /// No description provided for @serviceOrderFormTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva orden de servicio'**
  String get serviceOrderFormTitle;

  /// No description provided for @serviceOrderNotes.
  ///
  /// In es, this message translates to:
  /// **'Observaciones (opcional)'**
  String get serviceOrderNotes;

  /// No description provided for @serviceOrderDiscountToggle.
  ///
  /// In es, this message translates to:
  /// **'Aplicar descuento'**
  String get serviceOrderDiscountToggle;

  /// No description provided for @serviceOrderDiscountType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de descuento'**
  String get serviceOrderDiscountType;

  /// No description provided for @serviceOrderDiscountPercent.
  ///
  /// In es, this message translates to:
  /// **'Porcentaje'**
  String get serviceOrderDiscountPercent;

  /// No description provided for @serviceOrderDiscountFixed.
  ///
  /// In es, this message translates to:
  /// **'Valor fijo'**
  String get serviceOrderDiscountFixed;

  /// No description provided for @serviceOrderDiscountPercentValue.
  ///
  /// In es, this message translates to:
  /// **'Porcentaje (%)'**
  String get serviceOrderDiscountPercentValue;

  /// No description provided for @serviceOrderDiscountFixedValue.
  ///
  /// In es, this message translates to:
  /// **'Valor del descuento'**
  String get serviceOrderDiscountFixedValue;

  /// No description provided for @serviceOrderDiscountInvalid.
  ///
  /// In es, this message translates to:
  /// **'Debe ser mayor que cero y menor que el total del procedimiento.'**
  String get serviceOrderDiscountInvalid;

  /// No description provided for @serviceOrderDiscountPercentInvalid.
  ///
  /// In es, this message translates to:
  /// **'Debe estar entre 0 y 100.'**
  String get serviceOrderDiscountPercentInvalid;

  /// No description provided for @serviceOrderDiscountNote.
  ///
  /// In es, this message translates to:
  /// **'Un descuento deja la orden pendiente hasta que un aprobador lo autorice.'**
  String get serviceOrderDiscountNote;

  /// No description provided for @serviceOrderSupplies.
  ///
  /// In es, this message translates to:
  /// **'Insumos'**
  String get serviceOrderSupplies;

  /// No description provided for @serviceOrderAddSupply.
  ///
  /// In es, this message translates to:
  /// **'Agregar insumo'**
  String get serviceOrderAddSupply;

  /// No description provided for @serviceOrderChooseSupply.
  ///
  /// In es, this message translates to:
  /// **'Elegir insumo'**
  String get serviceOrderChooseSupply;

  /// No description provided for @serviceOrderSupplyWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén de donde salen'**
  String get serviceOrderSupplyWarehouse;

  /// No description provided for @serviceOrderSupplyQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get serviceOrderSupplyQuantity;

  /// No description provided for @serviceOrderSupplyNote.
  ///
  /// In es, this message translates to:
  /// **'Los insumos salen del inventario al crear la orden.'**
  String get serviceOrderSupplyNote;

  /// No description provided for @serviceOrderSupplyWarehouseRequired.
  ///
  /// In es, this message translates to:
  /// **'Elija el almacén de los insumos.'**
  String get serviceOrderSupplyWarehouseRequired;

  /// No description provided for @serviceOrderSubmit.
  ///
  /// In es, this message translates to:
  /// **'Crear orden'**
  String get serviceOrderSubmit;

  /// No description provided for @serviceOrderCreated.
  ///
  /// In es, this message translates to:
  /// **'Orden {number} creada.'**
  String serviceOrderCreated(String number);

  /// No description provided for @serviceOrderUnconfirmed.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. La orden pudo haberse creado: revise los registros del paciente antes de repetirla.'**
  String get serviceOrderUnconfirmed;

  /// No description provided for @serviceOrderNotCreated.
  ///
  /// In es, this message translates to:
  /// **'Ya revisé: no se creó, enviar de nuevo'**
  String get serviceOrderNotCreated;

  /// No description provided for @serviceOrderMaybePartial.
  ///
  /// In es, this message translates to:
  /// **'Si el servidor falló al guardar, la orden pudo quedar a medias (con algunos procedimientos o insumos ya registrados). Revise los registros del paciente antes de repetirla.'**
  String get serviceOrderMaybePartial;

  /// No description provided for @clinicalEvolutionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Evoluciones clínicas'**
  String get clinicalEvolutionsTitle;

  /// No description provided for @clinicalEvolutionsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este registro no tiene evoluciones.'**
  String get clinicalEvolutionsEmpty;

  /// No description provided for @clinicalEvolutionAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar evolución'**
  String get clinicalEvolutionAdd;

  /// No description provided for @clinicalEvolutionEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar evolución'**
  String get clinicalEvolutionEdit;

  /// No description provided for @clinicalEvolutionNewTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva evolución'**
  String get clinicalEvolutionNewTitle;

  /// No description provided for @clinicalEvolutionEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar evolución'**
  String get clinicalEvolutionEditTitle;

  /// No description provided for @clinicalEvolutionField.
  ///
  /// In es, this message translates to:
  /// **'Evolución clínica'**
  String get clinicalEvolutionField;

  /// No description provided for @clinicalEvolutionSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar evolución'**
  String get clinicalEvolutionSave;

  /// No description provided for @clinicalEvolutionSaved.
  ///
  /// In es, this message translates to:
  /// **'Evolución guardada.'**
  String get clinicalEvolutionSaved;

  /// No description provided for @clinicalEvolutionTemplateLoaded.
  ///
  /// In es, this message translates to:
  /// **'Se cargó la plantilla del servicio. Ajústela antes de guardar.'**
  String get clinicalEvolutionTemplateLoaded;

  /// No description provided for @clinicalEvolutionBy.
  ///
  /// In es, this message translates to:
  /// **'{author} · {date}'**
  String clinicalEvolutionBy(String author, String date);

  /// No description provided for @clinicalEvolutionTimeout.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Revise las evoluciones del registro antes de repetirlo: es posible que sí se haya guardado.'**
  String get clinicalEvolutionTimeout;

  /// No description provided for @clinicalEvolutionFormatNote.
  ///
  /// In es, this message translates to:
  /// **'La app guarda el texto sin formato (negritas ni listas).'**
  String get clinicalEvolutionFormatNote;

  /// No description provided for @clinicalMedicationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Medicamentos aplicados'**
  String get clinicalMedicationsTitle;

  /// No description provided for @clinicalMedicationDetail.
  ///
  /// In es, this message translates to:
  /// **'Lote {lot} · vence {date}'**
  String clinicalMedicationDetail(String lot, String date);

  /// No description provided for @orderEvolutionLabel.
  ///
  /// In es, this message translates to:
  /// **'Evolución clínica'**
  String get orderEvolutionLabel;

  /// No description provided for @orderEvolutionHelp.
  ///
  /// In es, this message translates to:
  /// **'Obligatoria. Máximo {max} caracteres en total.'**
  String orderEvolutionHelp(int max);

  /// No description provided for @orderEvolutionRequired.
  ///
  /// In es, this message translates to:
  /// **'Escriba la evolución clínica del procedimiento.'**
  String get orderEvolutionRequired;

  /// No description provided for @orderEvolutionTooLong.
  ///
  /// In es, this message translates to:
  /// **'La evolución es demasiado larga (máximo {max} caracteres).'**
  String orderEvolutionTooLong(int max);

  /// No description provided for @orderEvolutionCounter.
  ///
  /// In es, this message translates to:
  /// **'{used} de {max}'**
  String orderEvolutionCounter(int used, int max);

  /// No description provided for @costCentersTabCenters.
  ///
  /// In es, this message translates to:
  /// **'Centros de costo'**
  String get costCentersTabCenters;

  /// No description provided for @costCentersTabServices.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get costCentersTabServices;

  /// No description provided for @costCentersSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre o código del centro'**
  String get costCentersSearchHint;

  /// No description provided for @costCentersEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay centros de costo.'**
  String get costCentersEmpty;

  /// No description provided for @costCenterExternal.
  ///
  /// In es, this message translates to:
  /// **'Externo'**
  String get costCenterExternal;

  /// No description provided for @costCenterInternal.
  ///
  /// In es, this message translates to:
  /// **'Interno'**
  String get costCenterInternal;

  /// No description provided for @servicesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay servicios registrados.'**
  String get servicesEmpty;

  /// No description provided for @servicePricesTitle.
  ///
  /// In es, this message translates to:
  /// **'Tarifas de {name}'**
  String servicePricesTitle(String name);

  /// No description provided for @servicePricesEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este procedimiento no tiene tarifas registradas.'**
  String get servicePricesEmpty;

  /// No description provided for @servicePriceCurrent.
  ///
  /// In es, this message translates to:
  /// **'Vigente'**
  String get servicePriceCurrent;

  /// No description provided for @servicePriceFrom.
  ///
  /// In es, this message translates to:
  /// **'Desde {date}'**
  String servicePriceFrom(String date);

  /// No description provided for @servicePriceUntil.
  ///
  /// In es, this message translates to:
  /// **'hasta {date}'**
  String servicePriceUntil(String date);

  /// No description provided for @consumptionsTabList.
  ///
  /// In es, this message translates to:
  /// **'Consumos'**
  String get consumptionsTabList;

  /// No description provided for @consumptionsTabProjection.
  ///
  /// In es, this message translates to:
  /// **'Proyección'**
  String get consumptionsTabProjection;

  /// No description provided for @consumptionsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay consumos registrados.'**
  String get consumptionsEmpty;

  /// No description provided for @syncPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get syncPending;

  /// No description provided for @syncSynced.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado'**
  String get syncSynced;

  /// No description provided for @syncFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallido'**
  String get syncFailed;

  /// No description provided for @consumptionNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo consumo'**
  String get consumptionNew;

  /// No description provided for @consumptionDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Consumo'**
  String get consumptionDetailTitle;

  /// No description provided for @consumptionProductUnknown.
  ///
  /// In es, this message translates to:
  /// **'Insumo'**
  String get consumptionProductUnknown;

  /// No description provided for @consumptionLot.
  ///
  /// In es, this message translates to:
  /// **'Lote'**
  String get consumptionLot;

  /// No description provided for @consumptionLotValue.
  ///
  /// In es, this message translates to:
  /// **'Lote {lot}'**
  String consumptionLotValue(String lot);

  /// No description provided for @consumptionQuantity.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get consumptionQuantity;

  /// No description provided for @consumptionDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha del consumo'**
  String get consumptionDate;

  /// No description provided for @consumptionSyncedAt.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado el'**
  String get consumptionSyncedAt;

  /// No description provided for @consumptionAppointment.
  ///
  /// In es, this message translates to:
  /// **'Cita'**
  String get consumptionAppointment;

  /// No description provided for @consumptionPatient.
  ///
  /// In es, this message translates to:
  /// **'Paciente'**
  String get consumptionPatient;

  /// No description provided for @consumptionServiceType.
  ///
  /// In es, this message translates to:
  /// **'Servicio'**
  String get consumptionServiceType;

  /// No description provided for @consumptionSyncStatus.
  ///
  /// In es, this message translates to:
  /// **'Historia clínica'**
  String get consumptionSyncStatus;

  /// No description provided for @consumptionRetrySync.
  ///
  /// In es, this message translates to:
  /// **'Reintentar sincronización'**
  String get consumptionRetrySync;

  /// No description provided for @consumptionRetryConfirm.
  ///
  /// In es, this message translates to:
  /// **'Se volverá a enviar el consumo a la historia clínica.'**
  String get consumptionRetryConfirm;

  /// No description provided for @consumptionRetryQueued.
  ///
  /// In es, this message translates to:
  /// **'Sincronización reencolada.'**
  String get consumptionRetryQueued;

  /// No description provided for @consumptionRetryTimeout.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. Actualice el consumo antes de repetirlo: es posible que sí se haya reencolado.'**
  String get consumptionRetryTimeout;

  /// No description provided for @consumptionFormTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar consumo'**
  String get consumptionFormTitle;

  /// No description provided for @consumptionWarehouse.
  ///
  /// In es, this message translates to:
  /// **'Almacén'**
  String get consumptionWarehouse;

  /// No description provided for @consumptionCostCenter.
  ///
  /// In es, this message translates to:
  /// **'Centro de costo'**
  String get consumptionCostCenter;

  /// No description provided for @consumptionAppointmentField.
  ///
  /// In es, this message translates to:
  /// **'Código de la cita (opcional)'**
  String get consumptionAppointmentField;

  /// No description provided for @consumptionPatientField.
  ///
  /// In es, this message translates to:
  /// **'Identificación del paciente (opcional)'**
  String get consumptionPatientField;

  /// No description provided for @consumptionServiceField.
  ///
  /// In es, this message translates to:
  /// **'Servicio (opcional)'**
  String get consumptionServiceField;

  /// No description provided for @consumptionSyncNote.
  ///
  /// In es, this message translates to:
  /// **'Con cita y paciente, el consumo también se envía a la historia clínica.'**
  String get consumptionSyncNote;

  /// No description provided for @consumptionItemsTitle.
  ///
  /// In es, this message translates to:
  /// **'Insumos'**
  String get consumptionItemsTitle;

  /// No description provided for @consumptionItemsRequired.
  ///
  /// In es, this message translates to:
  /// **'Agregue al menos un insumo.'**
  String get consumptionItemsRequired;

  /// No description provided for @consumptionSubmit.
  ///
  /// In es, this message translates to:
  /// **'Registrar consumo'**
  String get consumptionSubmit;

  /// No description provided for @consumptionSaved.
  ///
  /// In es, this message translates to:
  /// **'Consumo registrado.'**
  String get consumptionSaved;

  /// No description provided for @consumptionUnconfirmed.
  ///
  /// In es, this message translates to:
  /// **'No se recibió respuesta del servidor. El consumo pudo haberse registrado: revise la lista de consumos antes de repetirlo.'**
  String get consumptionUnconfirmed;

  /// No description provided for @consumptionNotSaved.
  ///
  /// In es, this message translates to:
  /// **'Ya revisé: no se registró, enviar de nuevo'**
  String get consumptionNotSaved;

  /// No description provided for @projectionDays.
  ///
  /// In es, this message translates to:
  /// **'{days} días'**
  String projectionDays(int days);

  /// No description provided for @projectionEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay citas futuras con consumo previsto.'**
  String get projectionEmpty;

  /// No description provided for @projectionAverage.
  ///
  /// In es, this message translates to:
  /// **'{count} citas · promedio {avg} por cita'**
  String projectionAverage(int count, String avg);

  /// No description provided for @projectionUnits.
  ///
  /// In es, this message translates to:
  /// **'{units} u.'**
  String projectionUnits(int units);

  /// No description provided for @projectionNote.
  ///
  /// In es, this message translates to:
  /// **'Estimado con las citas futuras de MedSys y el promedio de los últimos 90 días.'**
  String get projectionNote;
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
