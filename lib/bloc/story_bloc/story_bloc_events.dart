import 'package:equatable/equatable.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
}

class FetchStoriesEvent extends StoryEvent {
  @override
  List<Object> get props => [];

  const FetchStoriesEvent();
}