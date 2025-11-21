class ApiConstants {
  // static const String baseUrl = 'http://192.168.2.114:5001/api';
  static const String baseUrl = 'http://192.168.1.81:5001/api';
  //auth
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String profile = '$baseUrl/auth/profile';

  //customer
  static const String customer = '$baseUrl/customers';

  //products
  static const String products = '$baseUrl/products';

  //purchase
  static const String purchase = '$baseUrl/purchase';
}
