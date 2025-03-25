import 'package:david_weijian_dashboard/model/stops_model.dart';

class RouteResponse {
  final bool status;
  final String message;
  final List<RouteModel> data;

  RouteResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      status: json['status'],
      message: json['message'],
      data: List<RouteModel>.from(
        json['data'].map((route) => RouteModel.fromJson(route)),
      ),
    );
  }
}

class RouteModel {
  final String id;
  final String testCentreId;
  final String routeName;
  final String testCentreName;
  final int expectedTime;
  final String shareUrl;
  final List<Stop> listOfStops;
  final Map<String, double> startCoordinator;
  final Map<String, double> endCoordinator;
  final String isUser;
  final String from;
  final String to;
  final double passRate;
  final String address;
  final int view;
  final List<dynamic> favorite;
  final DateTime createdAt;
  final DateTime updatedAt;

  RouteModel({
    required this.id,
    required this.testCentreId,
    required this.routeName,
    required this.testCentreName,
    required this.expectedTime,
    required this.shareUrl,
    required this.listOfStops,
    required this.startCoordinator,
    required this.endCoordinator,
    required this.isUser,
    required this.from,
    required this.to,
    required this.passRate,
    required this.address,
    required this.view,
    required this.favorite,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['_id'] ?? '', // Handle null
      testCentreId: json['testCentreId'] ?? '', // Handle null
      routeName: json['routeName'] ?? '', // Handle null
      testCentreName: json['TestCentreName'] ?? '', // Handle null
      expectedTime: json['expectedTime'] ?? 0, // Handle null
      shareUrl: json['shareUrl'] ?? '', // Handle null
      listOfStops: List<Stop>.from(
        (json['listOfStops'] ?? []).map((stop) => Stop.fromJson(stop)),
      ), // Handle null
      startCoordinator: {
        'lat': json['startCoordinator']['lat'] ?? 0.0, // Handle null
        'lng': json['startCoordinator']['lng'] ?? 0.0, // Handle null
      },
      endCoordinator: {
        'lat': json['endCoordinator']['lat'] ?? 0.0, // Handle null
        'lng': json['endCoordinator']['lng'] ?? 0.0, // Handle null
      },
      isUser: json['isUser'] ?? '', // Handle null
      from: json['from'] ?? '', // Handle null
      to: json['to'] ?? '', // Handle null
      passRate: (json['passRate'] ?? 0.0).toDouble(), // Handle null
      address: json['address'] ?? '', // Handle null
      view: json['view'] ?? 0, // Handle null
      favorite: json['favorite'] ?? [], // Handle null
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ), // Handle null
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ), // Handle null
    );
  }
}
