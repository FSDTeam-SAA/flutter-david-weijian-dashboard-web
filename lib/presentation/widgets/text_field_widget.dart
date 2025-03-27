import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final bool setInitialValueOnlyOnce;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final InputDecoration? decoration;

  const CustomTextField({
    required this.label,
    required this.onChanged,
    this.initialValue,
    this.setInitialValueOnlyOnce = true,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
    this.decoration,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  bool _initialValueSet = false;
  String? _errorText;

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
    
    // Handle initial value updates
    if (!widget.setInitialValueOnlyOnce && 
        widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
    
    // Validate when validator changes
    if (widget.validator != oldWidget.validator) {
      _validate(_controller.text);
    }
  }

  void _validate(String value) {
    setState(() {
      _errorText = widget.validator?.call(value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _controller,
        decoration: widget.decoration ?? InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          errorText: _errorText,
          suffixIcon: widget.suffixIcon,
        ),
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        onChanged: (value) {
          widget.onChanged(value);
          if (widget.validator != null) {
            _validate(value);
          }
        },
        validator: widget.validator,
      ),
    );
  }
}