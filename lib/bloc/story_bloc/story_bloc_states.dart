import '../../models/story_model.dart';

abstract class StoryState {
  const StoryState();
}

class InitialStoryState extends StoryState {
  const InitialStoryState();
}

class LoadingStoryFetchingState extends StoryState {
  const LoadingStoryFetchingState();
}

class SuccessStoryFetchingState extends StoryState {
  final List<StoryModel> storyList;

  const SuccessStoryFetchingState({required this.storyList});
}

class ErrorStoryFetchingState extends StoryState {
  const ErrorStoryFetchingState();
}

class SuccessStoryViewInitialState extends StoryState {
  final List<double> percentValue;

  const SuccessStoryViewInitialState({required this.percentValue});
}