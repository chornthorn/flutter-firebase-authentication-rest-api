import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, this.controller, this.hint})
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfff0f5fc),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
