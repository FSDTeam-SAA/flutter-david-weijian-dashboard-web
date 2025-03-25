import 'package:david_weijian_dashboard/model/bugreport_model.dart';
import 'package:david_weijian_dashboard/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BugReportController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = false.obs;
  var bugReports = <BugReport>[].obs;

  @override
  void onInit() {
    fetchBugReports();
    super.onInit();
  }

  // Fetch bug reports
  Future<void> fetchBugReports() async {
    try {
      isLoading(true);
      final reports = await _apiService.fetchBugReports();
      debugPrint("Bug Reposrt Data ->> $reports");
      bugReports.assignAll(reports); // Update the observable list
    } catch (e) {
      Get.snackbar('Error', e.toString()); // Show error message
    } finally {
      isLoading(false);
    }
  }
}
