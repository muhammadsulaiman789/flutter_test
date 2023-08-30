import 'package:flutter/material.dart';

class TextEditField extends StatefulWidget {
  final String hint;
  final TextInputType inputType;
  final String? Function(String?) validator;
  final TextCapitalization capitalization;
  final bool filled;
  final Color fillColor;
  final TextEditingController controller;

  const TextEditField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    this.inputType = TextInputType.text,
    this.capitalization = TextCapitalization.none,
    this.filled = false,
    this.fillColor = Colors.white,
  });

  @override
  State<TextEditField> createState() => _TextEditFieldState();
}

class _TextEditFieldState extends State<TextEditField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint,
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            validator: widget.validator,
            maxLines: 1,
            textCapitalization: widget.capitalization,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              hintText: widget.hint,
              border: _fieldBorder(),
              focusedBorder: _fieldBorder(),
              enabledBorder: _fieldBorder(),
              errorBorder: _fieldBorder(),
              disabledBorder: _fieldBorder(),
              filled: widget.filled,
              fillColor: widget.fillColor,
              hintStyle: const TextStyle(
                color: Color(0xffBDBDBD),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  InputBorder _fieldBorder() {
    return InputBorder.none;
  }
}
