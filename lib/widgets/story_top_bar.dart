import 'package:flutter/material.dart';
import 'package:stage_project/widgets/reusable_widgets/display_picture_widget.dart';

import '../models/story_model.dart';


// A custom widget that displays a top bar for a story view, including a user's information and a close button.
class StoryTopBar extends StatelessWidget {
  final StoryModel userDetails;

  const StoryTopBar({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 14.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DisplayPictureWidget(
                size: 40.0,
                displayPictureURL: userDetails
                    .userDisplayPicture,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                userDetails.userName,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      ),
    )
    ;
  }
}
