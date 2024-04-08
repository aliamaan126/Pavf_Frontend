class ApiEndPoints {
  static final String baseUrl = 'http://localhost:3000/api/v1';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = '/auth/register';
  final String login = '/auth/login';
  final String logut = '/auth/logout';
  final String forgotPass = '/auth/forgot-password';
  final String otp = '/auth/confirm-otp';
  final String resetPass = '/auth/reset-password';
  final String refreshToken = '/auth/refresh-token';
}