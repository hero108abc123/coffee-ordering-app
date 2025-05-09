import 'dart:io';

class AppSecrets {
  static final baseUrl = Platform.isWindows
      ? "https://localhost:7165/api"
      : "https://10.0.2.2:7165/api";
}
