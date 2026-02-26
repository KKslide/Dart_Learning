import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final double width;
  final double height;
  final String src;

  const MyImage({
    super.key,
    this.width = double.infinity,
    this.height = 200,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.network(src, fit: BoxFit.cover),
    );
  }
}
