import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BongThornLogo extends StatelessWidget {
  const BongThornLogo({
    Key? key,
    this.asset,
    this.height,
    this.width,
  }) : super(key: key);

  final String? asset;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: width ?? 120,
        height: height ?? 120,
        color: Colors.blue,
        child: Lottie.asset(asset ?? 'assets/lotties/flutter_logo.json'),
      ),
    );
  }
}
