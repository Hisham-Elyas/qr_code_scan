import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  const CustomTextFormFieldWidget({
    super.key,
    this.labelText,
    this.maxLines,
    this.validator,
    this.onSaved,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
