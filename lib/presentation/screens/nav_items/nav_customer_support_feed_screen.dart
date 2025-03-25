import 'package:david_weijian_dashboard/controller/custom_support_feedback_controller.dart';
import 'package:david_weijian_dashboard/model/contact_model.dart';
import 'package:david_weijian_dashboard/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavCustomerSupportFeedScreen extends StatelessWidget {
  final CustomerSupportController _controller = Get.put(
    CustomerSupportController(),
  );

  NavCustomerSupportFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Customer Support"),
          bottom: TabBar(
            tabs: [Tab(text: "Contact Details"), Tab(text: "All Reviews")],
          ),
        ),
        body: Obx(() {
          if (_controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [
              _buildContactDetailsList(_controller.contacts),
              _buildReviewsList(_controller.reviews),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContactDetailsList(List<Contact> contacts) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          title: Text(contact.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.email.isNotEmpty ? contact.email : 'No email'),
              // if (contact.user != null)
              //   Text("User: ${contact.user!.name} (${contact.user!.email})"),
            ],
          ),
          trailing: Text(contact.phone.isNotEmpty ? contact.phone : 'No phone'),
        );
      },
    );
  }

  Widget _buildReviewsList(List<ReviewData> reviews) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final reviewData = reviews[index];
        return ExpansionTile(
          title: Text(reviewData.testCentreName),
          subtitle: Text(reviewData.routeName),
          children:
              reviewData.reviews.map((review) {
                return ListTile(
                  title: Text(review.reviewMessage),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rating: ${review.rating}"),
                      Text("User: ${review.user.name}"),
                    ],
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}
