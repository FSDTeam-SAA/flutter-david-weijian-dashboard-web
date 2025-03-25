import 'package:david_weijian_dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width:
                  constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Obx(() {
                            return authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 28,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();
                                    if (email.isEmpty || password.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Please fill all fields',
                                      );
                                    } else {
                                      authController.adminLogin(
                                        email,
                                        password,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
