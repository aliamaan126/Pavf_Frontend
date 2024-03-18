class ApiEndPoints {
  static final String baseUrl = 'http://localhost:3000/api/v1';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = '/auth/register';
  final String login = '/auth/login';
}