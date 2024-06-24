import 'package:flutter/material.dart';

import '../../constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,

    required this.text,
    required this.onPressed,
  });


  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white), backgroundColor: WidgetStateProperty.all(primaryColor)),
      onPressed:onPressed,
      child: Text(text),
    );
  }
}