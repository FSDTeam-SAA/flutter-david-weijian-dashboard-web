// lib/navbar/widgets/nav_drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/controller/navbar_controller.dart';

class NavDrawer extends StatelessWidget {
  final NavController navController = Get.find();

  NavDrawer({super.key}); // Get the NavController instance

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Remove default padding
        children: [
          // Drawer Header (Optional)
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Customize header color
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Navigation Items
          ListTile(
            leading: const Icon(Icons.person), // Add an icon
            title: const Text('User'),
            onTap: () {
              navController.changeScreen('User'); // Change screen to User
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions), // Add an icon
            title: const Text('Subscription'),
            onTap: () {
              navController.changeScreen(
                'Subscription',
              ); // Change screen to Subscription
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory), // Add an icon
            title: const Text('Package'),
            onTap: () {
              navController.changeScreen('Package'); // Change screen to Package
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.article), // Add an icon
            title: const Text('Content'),
            onTap: () {
              navController.changeScreen('Content'); // Change screen to Contact
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock), // Add an icon
            title: const Text('Feature Access Limitation'),
            onTap: () {
              navController.changeScreen(
                'Feature Access Limitation',
              ); // Change screen to Feature Access Limitation
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics), // Add an icon
            title: const Text('Report & Analytics'),
            onTap: () {
              navController.changeScreen(
                'Report & Analytics',
              ); // Change screen to Report & Analytics
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign), // Add an icon
            title: const Text('Marketing & Promotions'),
            onTap: () {
              navController.changeScreen(
                'Marketing & Promotions',
              ); // Change screen to Marketing & Promotions
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent), // Add an icon
            title: const Text('Customer Support Feedback'),
            onTap: () {
              navController.changeScreen(
                'Customer Support Feedback',
              ); // Change screen to Customer Support Feedback
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.security), // Add an icon
            title: const Text('Securities Compliance'),
            onTap: () {
              navController.changeScreen(
                'Securities Compliance',
              ); // Change screen to Securities Compliance
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
