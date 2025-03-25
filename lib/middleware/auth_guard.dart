import 'package:david_weijian_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  final AuthController authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    return authController.isLoggedIn.value
        ? null
        : const RouteSettings(name: '/login');
  }
}
