import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.transparent,
      // valueColor: AlwaysStoppedAnimation<Color>(),
      minHeight: 2,
    );
  }
}
