// lib/navbar/bindings/nav_binding.dart
import 'package:david_weijian_dashboard/controller/auth_controller.dart';
import 'package:david_weijian_dashboard/controller/bugreport_controller.dart';
import 'package:david_weijian_dashboard/controller/custom_support_feedback_controller.dart';
import 'package:david_weijian_dashboard/controller/navbar_controller.dart';
import 'package:david_weijian_dashboard/controller/user_controller.dart';
import 'package:get/get.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => NavController());
    Get.lazyPut(() => UserController());

    Get.lazyPut(() => BugReportController());
    // Get.lazyPut(() => ContactController());
    Get.lazyPut(() => CustomerSupportController());
  }
}
