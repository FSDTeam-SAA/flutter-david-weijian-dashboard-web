import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final bool setInitialValueOnlyOnce;

  const CustomTextField({
    required this.label,
    required this.onChanged,
    this.initialValue,
    this.setInitialValueOnlyOnce = true,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  bool _initialValueSet = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue != null && !_initialValueSet) {
      _controller.text = widget.initialValue!;
      _initialValueSet = true;
    }
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.setInitialValueOnlyOnce && 
        widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}