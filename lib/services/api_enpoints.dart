abstract class Endpoints{
  static const baseUrl = '172.16.1.16:85';

  static const loginUrl = 'api/Usuarios/Login';
  static const activacionCodigoUrl = 'api/Usuarios/ActivacionCodigo';
  static const activacionUrl = 'api/Usuarios/Activacion';
  static const recuperacionCodigoUrl = 'api/Usuarios/RecuperarContrasenaCodigo';
  static const recuperacionUrl = 'api/Usuarios/RecuperarContrasena';

  static const infoUsuarioUrl = 'api/Home/InfoUsuario';
  static const logUsuarioUrl = 'api/Home/LogUsuario';
  static const notificacionesUrl = 'api/Home/Notificaciones';

  static const prospectosObtenerListaUrl = 'api/Prospeccion/ProspectosObtenerLista';
  static const prospectoRegistroUrl = 'api/Prospeccion/ProspectoRegistro';
  static const prospectosObtenerPerfil = 'api/Prospeccion/ProspectosObtenerPerfil';

  static const verificacionObtenerListaUrl = 'api/Verificacion/ProspectosObtenerLista';
}