import 'package:flutter/material.dart';

class BottomMessage extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final VoidCallback callback;
  const BottomMessage({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
