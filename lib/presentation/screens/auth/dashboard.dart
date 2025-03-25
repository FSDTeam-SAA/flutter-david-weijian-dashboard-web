import 'package:david_weijian_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () {
      //         authController.isLoggedIn(false);
      //         authController.logout();
      //         Get.offAll(() => LoginScreen()); // Navigate back to login screen
      //       },
      //     ),
      //   ],
      // ),
      body: const Center(child: Text('Welcome to the Admin Dashboard')),
    );
  }
}
