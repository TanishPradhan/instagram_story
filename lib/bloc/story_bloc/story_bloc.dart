import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc_events.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc_states.dart';
import 'package:stage_project/models/story_model.dart';
import 'package:flutter/material.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(const InitialStoryState()) {
    //This Event fetches stories from API and emits Success state with fetched data
    on<FetchStoriesEvent>((event, emit) async {
      emit(const LoadingStoryFetchingState());

      //API Fetching...

      //This is the Dummy Data which is used for testing.
      List<StoryModel> storyList = [
        const StoryModel(
          userName: "tanishpradhan26",
          userDisplayPicture:
              "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
          stories: [
            Story(
                url:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                type: FileType.video),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
                type: FileType.image),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1GDUyiEiyVOdK9iA_nsPV8LB2LYcMtl0M",
                type: FileType.image),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1dMoo5FOMRImpm1y7nLOZAfjgrNBVmmxA",
                type: FileType.image),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1dMoo5FOMRImpm1y7nLOZAfjgrNBVmmxA",
                type: FileType.image),
            Story(
                url:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                type: FileType.video),
          ],
        ),
        const StoryModel(
          userName: "tanishpradhan26",
          userDisplayPicture:
              "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
          stories: [
            Story(
              url:
                  "https://images.pexels.com/photos/1154059/pexels-photo-1154059.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              type: FileType.image,
            ),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
                type: FileType.image),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
                type: FileType.image),
          ],
        ),
        const StoryModel(
          userName: "tanishpradhan26",
          userDisplayPicture:
              "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
          stories: [
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
                type: FileType.image),
            Story(
                url:
                    "https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg",
                type: FileType.image)
          ],
        ),
      ];

      //Pre-Caching Images for better performance of the app
      for (var url in storyList) {
        await precacheImage(
            NetworkImage(url.userDisplayPicture), event.context);
      }

      //Emits Success state with the Dummy Data List
      emit(SuccessStoryFetchingState(storyList: storyList));
    });

    //This event is used to initialize the StoryView initializing the list of stories
    on<StoryViewInitialEvent>((event, emit) {
      List<double> percentValue = [];

      //This for loop is used to initialize the list of stories
      for (int i = 0; i < event.storyLength; i++) {
        percentValue.add(0);
      }

      emit(SuccessStoryViewInitialState(percentValue: percentValue));
    });
  }
}
