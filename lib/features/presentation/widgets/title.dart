import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final String text;

  const DetailTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}
