import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.grey.withOpacity(0.3),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.blue, width: 1.2),
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
