import 'package:david_weijian_dashboard/controller/navbar_controller.dart';
import 'package:david_weijian_dashboard/presentation/screens/drawer/drawer.dart';
import 'package:david_weijian_dashboard/presentation/widgets/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final NavController navController = Get.put(NavController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: ProfileIcon()),
          ),
        ],
      ),
      body: Obx(() {
        return navController.currentScreen.value; // Reactive UI update
      }),
      drawer: NavDrawer(),
    );
  }
}
