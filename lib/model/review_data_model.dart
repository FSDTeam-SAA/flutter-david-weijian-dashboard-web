// import 'package:david_weijian_dashboard/model/review_model.dart';

// class ReviewData {
//   final String id;
//   final String routeName;
//   final String testCentreName;
//   final String address;
//   final List<Review> reviews;

//   ReviewData({
//     required this.id,
//     required this.routeName,
//     required this.testCentreName,
//     required this.address,
//     required this.reviews,
//   });

//   factory ReviewData.fromJson(Map<String, dynamic> json) {
//     return ReviewData(
//       id: json['_id'] ?? '',
//       routeName: json['routeName'] ?? '',
//       testCentreName: json['TestCentreName'] ?? '',
//       address: json['address'] ?? '',
//       reviews: (json['reviews'] as List<dynamic>)
//           .map((review) => Review.fromJson(review))
//           .toList(),
//     );
//   }
// }
