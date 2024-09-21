import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc_events.dart';
import 'package:stage_project/models/story_model.dart';
import 'package:stage_project/widgets/story_loader.dart';
import 'package:stage_project/widgets/story_top_bar.dart';
import 'package:video_player/video_player.dart';
import '../bloc/story_bloc/story_bloc_states.dart';
import '../widgets/progress_bar.dart';

class StoryView extends StatefulWidget {
  final List<StoryModel> stories;
  final int currentIndex;

  const StoryView({
    super.key,
    required this.stories,
    required this.currentIndex,
  });

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  int currentStoryIndex = 0;
  List<double> percentValue = [];
  AnimationController? _controller;
  VideoPlayerController? _videoPlayerController;
  late StoryBloc storyBloc;

  @override
  void initState() {
    storyBloc = StoryBloc();
    //This event is used to get the initial state of the story and the length of the story.
    storyBloc.add(StoryViewInitialEvent(
      storyLength: widget.stories[widget.currentIndex].stories.length,
    ));
    super.initState();
  }

  //Disposal of the controllers
  @override
  void dispose() {
    _controller?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => storyBloc,
        child: BlocConsumer<StoryBloc, StoryState>(listener: (context, state) {
          if (state is SuccessStoryViewInitialState) {
            percentValue = state.percentValue;
            _watchStories();
          }
        }, builder: (context, state) {
          return GestureDetector(
            onTapDown: (details) => _onTapDown(details),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: widget.stories[widget.currentIndex]
                              .stories[currentStoryIndex].type ==
                          FileType.image
                      ? CachedNetworkImage(
                          imageUrl: widget.stories[widget.currentIndex]
                              .stories[currentStoryIndex].url,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return const StoryLoader();
                          },
                          imageBuilder: (context, imageProvider) {
                            _controller?.forward();
                            return Container(
                              height: MediaQuery.sizeOf(context).height,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        )
                      : _videoPlayerController != null &&
                              _videoPlayerController!.value.isPlaying
                          ? VideoPlayer(_videoPlayerController!)
                          : const StoryLoader(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StoryProgressBar(
                      percentValue: percentValue,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    StoryTopBar(
                        userDetails: widget.stories[widget.currentIndex]),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  //This function enables timer for the Story View.
  //It checks if the current story is an image or video and then starts the timer accordingly.
  void _watchStories() {
    switch (
        widget.stories[widget.currentIndex].stories[currentStoryIndex].type) {
      //If the Story type is Image, it sets a default timer of 5 seconds.
      case FileType.image:
        {
          _controller = AnimationController(
            duration: const Duration(seconds: 5),
            vsync: this,
          )..addListener(() {
              if (mounted) {
                setState(() {
                  percentValue[currentStoryIndex] = _controller!.value;
                });
              }

              if (percentValue[currentStoryIndex] == 1) {
                if (currentStoryIndex <
                    widget.stories[widget.currentIndex].stories.length - 1) {
                  currentStoryIndex++;

                  _watchStories();
                } else {
                  Navigator.pop(context);
                }
              }
            });
        }
        break;

      //If the story type is Video, the story durations will be set to the duration of the video.
      case FileType.video:
        {
          _videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(
              widget
                  .stories[widget.currentIndex].stories[currentStoryIndex].url,
            ),
          )..initialize().then((_) {
              _controller = AnimationController(
                duration: Duration(
                    seconds: _videoPlayerController!.value.duration.inSeconds),
                vsync: this,
              )..addListener(() {
                  if (percentValue[currentStoryIndex] == 1) {
                    _videoPlayerController?.pause();
                  }
                  if (mounted) {
                    setState(() {
                      percentValue[currentStoryIndex] = _controller!.value;
                    });
                  }

                  if (percentValue[currentStoryIndex] == 1) {
                    if (currentStoryIndex <
                        widget.stories[widget.currentIndex].stories.length -
                            1) {
                      currentStoryIndex++;

                      _watchStories();
                    } else {
                      Navigator.pop(context);
                    }
                  }
                });
              _controller?.forward();

              _videoPlayerController?.play();
            });
        }
        break;

      default:
        {}
        break;
    }
  }

  //This function increments or decrements the story index based on the tap position.
  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double dx = details.globalPosition.dx;

    //If the tap position is less than half of the screen width, it decrements the story index.
    if (dx < screenWidth / 2) {
      if (mounted) {
        setState(() {
          if (currentStoryIndex > 0) {
            percentValue[currentStoryIndex - 1] = 0;
            percentValue[currentStoryIndex] = 0;

            currentStoryIndex--;
            _controller?.reset();

            if (widget.stories[widget.currentIndex].stories[currentStoryIndex]
                        .type ==
                    FileType.video &&
                _videoPlayerController!.value.isPlaying) {
              _videoPlayerController?.pause();
            }

            _watchStories();
          }
        });
      }
    } else {
      //If the tap position is greater than half of the screen width, it increments the story index.

      if (mounted) {
        setState(() {
          if (currentStoryIndex <
              widget.stories[widget.currentIndex].stories.length - 1) {
            percentValue[currentStoryIndex] = 1;
            currentStoryIndex++;
            _controller?.reset();
            if (widget.stories[widget.currentIndex].stories[currentStoryIndex]
                        .type ==
                    FileType.video &&
                _videoPlayerController!.value.isPlaying) {
              _videoPlayerController?.pause();
            }

            _watchStories();
          } else {
            percentValue[currentStoryIndex] = 1;
            Navigator.pop(context);
          }
        });
      }
    }
  }
}
