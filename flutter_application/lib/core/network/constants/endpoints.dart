import 'package:flutter_application/core/common/secrets/app_secret.dart';

class Endpoints {
  Endpoints._();
  static String baseUrl = AppSecrets.baseUrl;
  static String auth = "$baseUrl/Auth";
  static String user = "$baseUrl/User";
}
