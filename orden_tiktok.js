// ==========================================
// 📌 ARCHIVO DE ACCIÓN DE STREAMER.BOT (ALERTAS TIKTOK LIVE)
// ==========================================
// Streamer.bot debe ir agregando/acumulando (Append) líneas en este archivo para detonar las alertas en TiktokFuncion.html.
// Cada línea debe tener la siguiente firma:
//
//   lanzarAlertaTikTok("NombreUsuario", cantidadMonedas, "urlAvatar", "timestamp", "mensajeOpcional");
//
// Parámetros:
//   1. NombreUsuario (String) -> El usuario que realiza la donación o follow.
//   2. cantidadMonedas (Number) -> La cantidad de Monedas (1, 5, 30, 50, 100, 500) o 0 para Follow (+1 Follow).
//   3. urlAvatar (String) -> URL del avatar del usuario en TikTok (puedes pasar null o "" si no se dispone de ella).
//   4. timestamp (String) -> Marca de tiempo única del evento (ej: Date.now() o contador incremental) para evitar duplicados.
//   5. mensajeOpcional (String) -> Troleo autorizado ("Troleo_Raton_Borracho", "Troleo_Parpadeo", "Troleo_Invertido", "Troleo_Zoom", "Troleo_Congelado").
//
// ⚠️ IMPORTANTE: Streamer.bot debe configurarse con la opción "APPEND / ACUMULAR" texto en el archivo.
//
// Ejemplos de prueba (Descomenta cualquiera de estas líneas para probar la lectura en tiempo real):
// lanzarAlertaTikTok("Giankasor_Fan", 30, null, "1712789999999", "Troleo_Congelado");
// lanzarAlertaTikTok("Seguidor_Nuevo", 0, null, "1712790000000", "follow");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Parpadeo");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Parpadeo");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Invertido");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Raton_Borracho");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Invertido");
lanzarAlertaTikTok("%user%", "%diamondCount%", "%userAvatar%", Date.now(), "");
lanzarAlertaTikTok("%user%", 30, "%userAvatar%", Date.now(), "Troleo_Invertido");