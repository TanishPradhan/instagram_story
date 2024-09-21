import 'package:flutter/material.dart';

// A widget that displays a full-screen loader while content is loading.
class StoryLoader extends StatelessWidget {
  const StoryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white60,
        ),
      ),
    );
  }
}
