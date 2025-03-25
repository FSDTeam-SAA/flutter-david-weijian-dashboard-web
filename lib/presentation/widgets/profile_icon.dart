import 'package:david_weijian_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

enum Menu { itemOne, itemTwo, itemThree }

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
  final AuthController authController = Get.find<AuthController>();
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.person), // Profile icon
      offset: const Offset(0, 40), // Position of the dropdown menu
      onSelected: (Menu item) {
        // Handle menu item selection
        switch (item) {
          case Menu.itemOne:
            // Handle Account action
            break;
          case Menu.itemTwo:
            // Handle Settings action
            break;
          case Menu.itemThree:
            // Handle Sign Out action
            authController.logout();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.itemOne,
          child: Text('Account'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemTwo,
          child: Text('Settings'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemThree,
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}