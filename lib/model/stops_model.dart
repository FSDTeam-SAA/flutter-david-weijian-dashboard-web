class Stop {
  final String id;
  final double lat;
  final double lng;

  Stop({
    required this.id,
    required this.lat,
    required this.lng,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['_id'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }
}