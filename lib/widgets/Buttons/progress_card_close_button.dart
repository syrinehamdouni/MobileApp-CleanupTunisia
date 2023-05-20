import 'package:flutter/material.dart';

class ProgressCardCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ProgressCardCloseButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
              color:  Color(0xFF006064), shape: BoxShape.circle),
          child:
              const Center(child: Icon(Icons.close, size: 20, color: Colors.white))),
    );
  }
}
