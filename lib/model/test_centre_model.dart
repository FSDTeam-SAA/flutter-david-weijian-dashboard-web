class TestCentre {
  final String id;
  final String name;
  final String passRate;
  final int routes;
  final String address;
  final String postCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestCentre({
    required this.id,
    required this.name,
    required this.passRate,
    required this.routes,
    required this.address,
    required this.postCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestCentre.fromJson(Map<String, dynamic> json) {
    return TestCentre(
      id: json['_id'] ?? '', // Handle null
      name: json['name'] ?? '', // Handle null
      passRate: json['passRate'] ?? '0', // Handle null
      routes: json['routes'] ?? 0, // Handle null
      address: json['address'] ?? '', // Handle null
      postCode: json['postCode'] ?? '', // Handle null
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()), // Handle null
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()), // Handle null
    );
  }
}