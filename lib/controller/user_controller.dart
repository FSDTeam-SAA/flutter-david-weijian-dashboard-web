import 'package:david_weijian_dashboard/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_dashboard/model/user_model.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = false.obs;
  var userData = <User>[].obs;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  // Fetch user data
  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      final users = await _apiService.fetchUsers();
      userData.assignAll(users); // Update the observable list
    } catch (e) {
      Get.snackbar('Error', e.toString()); // Show error message
    } finally {
      isLoading(false);
    }
  }
}
