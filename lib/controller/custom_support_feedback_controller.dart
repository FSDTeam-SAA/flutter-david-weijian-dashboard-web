import 'package:david_weijian_dashboard/model/contact_model.dart';
import 'package:david_weijian_dashboard/model/review_model.dart';
import 'package:david_weijian_dashboard/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CustomerSupportController extends GetxController {
  var isLoading = true.obs;
  var contacts = <Contact>[].obs;
  var reviews = <ReviewData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactDetails();
    fetchReviews();
  }

  void fetchContactDetails() async {
    try {
      isLoading(true);
      final apiService = ApiService();
      final contactList = await apiService.fetchContactDetails();
      contacts.assignAll(contactList);
    } catch (e) {
      debugPrint("Error fetching contacts: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchReviews() async {
    try {
      isLoading(true);
      final apiService = ApiService();
      final reviewList = await apiService.fetchReviews();
      reviews.assignAll(reviewList);
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
    } finally {
      isLoading(false);
    }
  }
}
