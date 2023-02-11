import 'package:flutter/material.dart';

class StyleFormField extends StatelessWidget {
  final Widget field;

  const StyleFormField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: field,
    );
  }
}
