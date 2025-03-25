import 'package:david_weijian_dashboard/constants/key_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: KeyConstants.accessToken, value: token);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: KeyConstants.accessToken);
  }

  // Delete access token (for logout)
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: KeyConstants.accessToken);
  }
}