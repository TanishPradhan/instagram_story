import 'package:flutter/material.dart';

class DisplayPictureWidget extends StatelessWidget {
  final double size;
  final String displayPictureURL;
  final Border? border;

  const DisplayPictureWidget({super.key, required this.size, required this.displayPictureURL, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: border,
        image: DecorationImage(
          image: NetworkImage(
            displayPictureURL,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
