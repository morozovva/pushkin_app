import 'package:flutter/material.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pop(context),
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}
