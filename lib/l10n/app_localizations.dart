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
