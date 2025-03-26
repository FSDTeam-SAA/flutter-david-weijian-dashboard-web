import 'package:flutter/material.dart';
import 'package:david_weijian_dashboard/model/stops_model.dart';

class StopCard extends StatelessWidget {
  final Stop stop;
  
  const StopCard({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Stop ID: ${stop.id}'),
        subtitle: Text('Lat: ${stop.lat}, Lng: ${stop.lng}'),
      ),
    );
  }
}