import 'package:david_weijian_dashboard/presentation/screens/auth/dashboard.dart';
import 'package:david_weijian_dashboard/presentation/screens/auth/login_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/main_screen.dart';
import 'package:david_weijian_dashboard/services/api_service.dart';
import 'package:david_weijian_dashboard/services/secure_storage_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final SecureStorageService _secureStorage = SecureStorageService();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var accessToken = ''.obs;

  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
  }

  // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    isLoading(true);
    final token = await _secureStorage.getAccessToken();
    if (token != null) {
      isLoggedIn(true);
      accessToken(token);
    }
    isLoading(false);
  }

  // Admin login
  Future<void> adminLogin(String email, String password) async {
    try {
      isLoading(true);
      final response = await _apiService.adminLogin(email, password);
      if (response.status) {
        isLoggedIn(true);
        accessToken(response.accessToken ?? '');
        await _secureStorage.saveAccessToken(
          response.accessToken!,
        ); // Save token
        Get.offAll(() => MainScreen()); // Navigate to admin dashboard
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Logout the admin
  Future<void> logout() async {
    isLoggedIn(false);
    accessToken('');
    await _secureStorage.deleteAccessToken(); // Delete token
    Get.offAll(() => LoginScreen()); // Redirect to login screen
  }
}
