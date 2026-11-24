import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Firma de release: el keystore y sus claves viven FUERA del repositorio.
// Ruta por defecto: ~/.android-keys/sga-bojanini/key.properties
// Se puede cambiar con la variable de entorno SGA_KEY_PROPERTIES.
val keyPropertiesFile: File = file(
    System.getenv("SGA_KEY_PROPERTIES")
        ?: "${System.getProperty("user.home")}/.android-keys/sga-bojanini/key.properties",
)
val keyProperties = Properties().apply {
    if (keyPropertiesFile.exists()) {
        FileInputStream(keyPropertiesFile).use { load(it) }
    }
}
val hasReleaseKey = keyPropertiesFile.exists()

android {
    namespace = "co.bojanini.sga"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "co.bojanini.sga"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKey) {
            create("release") {
                storeFile = file(keyProperties.getProperty("storeFile"))
                storePassword = keyProperties.getProperty("storePassword")
                keyAlias = keyProperties.getProperty("keyAlias")
                keyPassword = keyProperties.getProperty("keyPassword")
            }
        }
    }

    // Ver docs/plan/02-arquitectura.md §8: dev (pruebas, HTTP permitido) y prod (solo HTTPS).
    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "SGA Bojanini DEV")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "SGA Bojanini")
        }
    }

    buildTypes {
        release {
            if (hasReleaseKey) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                // Sin keystore local solo se permite compilar; NUNCA distribuir un APK así.
                logger.warn("SGA: no se encontró $keyPropertiesFile; el release se firma con la clave de debug.")
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
