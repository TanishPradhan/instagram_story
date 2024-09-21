import 'package:flutter/material.dart';
import 'package:stage_project/models/story_model.dart';

class StoryWidget extends StatelessWidget {
  final StoryModel storyDetail;
  final VoidCallback onTap;

  const StoryWidget({super.key, required this.storyDetail, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 87,
            width: 87,
            margin: const EdgeInsets.only(left: 8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.4, 0.7],
                colors: [
                  Colors.yellow,
                  Colors.red,
                  Colors.pink,
                ],
              ),
            ),
            child: Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
                  border: Border.all(
                      color: Colors.white,
                      width: 2.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      storyDetail
                          .userDisplayPicture,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              storyDetail.userName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
