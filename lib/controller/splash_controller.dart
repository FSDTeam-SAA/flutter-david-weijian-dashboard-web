import 'package:david_weijian_dashboard/constants/key_constants.dart';
import 'package:david_weijian_dashboard/presentation/screens/auth/login_screen.dart';
import 'package:david_weijian_dashboard/presentation/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashController extends GetxController {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));

    String? token = await _storage.read(key: KeyConstants.accessToken);

    if (token != null && token.isNotEmpty) {
      Get.off(() => MainScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }
}
