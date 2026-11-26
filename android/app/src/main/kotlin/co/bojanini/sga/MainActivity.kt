package co.bojanini.sga

import android.content.pm.ApplicationInfo
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

/**
 * Oculta el contenido de la app en la vista de aplicaciones recientes y evita
 * capturas y grabaciones de pantalla: los datos de pacientes no deben quedar
 * visibles en un teléfono compartido (Ley 1581). Las compilaciones de
 * depuración (`flutter run`) las permiten para poder desarrollar y probar.
 */
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val isDebuggable = applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0
        if (!isDebuggable) {
            window.setFlags(
                WindowManager.LayoutParams.FLAG_SECURE,
                WindowManager.LayoutParams.FLAG_SECURE,
            )
        }
    }
}
