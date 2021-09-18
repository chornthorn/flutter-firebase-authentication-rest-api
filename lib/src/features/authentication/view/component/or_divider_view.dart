import 'package:flutter/material.dart';

class ORDivider extends StatelessWidget {
  const ORDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.4,
            width: double.maxFinite,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "or",
            style: TextStyle(color: Colors.black.withOpacity(0.7)),
          ),
        ),
        Expanded(
          child: Container(
            height: 0.4,
            width: double.maxFinite,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}