import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
}

class FetchStoriesEvent extends StoryEvent {
  final BuildContext context;
  @override
  List<Object> get props => [];

  const FetchStoriesEvent({required this.context});
}

class StoryViewInitialEvent extends StoryEvent {
  final int storyLength;

  @override
  List<Object> get props => [];

  const StoryViewInitialEvent({required this.storyLength});
}