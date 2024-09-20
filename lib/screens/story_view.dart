import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stage_project/models/story_model.dart';
import 'package:stage_project/widgets/reusable_widgets/display_picture_widget.dart';
import 'package:video_player/video_player.dart';
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
  late AnimationController _controller;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    for (int i = 0;
        i < widget.stories[widget.currentIndex].stories.length;
        i++) {
      percentValue.add(0);
    }
    _watchStories();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _watchStories() {
    switch (
        widget.stories[widget.currentIndex].stories[currentStoryIndex].type) {
      case FileType.image:
        {
          _controller = AnimationController(
            duration: const Duration(seconds: 5),
            vsync: this,
          )..addListener(() {
              if (mounted) {
                setState(() {
                  percentValue[currentStoryIndex] = _controller.value;
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
                      percentValue[currentStoryIndex] = _controller.value;
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
              _controller.forward();

              _videoPlayerController?.play();
            });
        }
        break;

      default:
        {}
        break;
    }
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 2) {
      if (mounted) {
        setState(() {
          if (currentStoryIndex > 0) {
            percentValue[currentStoryIndex - 1] = 0;
            percentValue[currentStoryIndex] = 0;

            currentStoryIndex--;
            _controller.reset();

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
      if (mounted) {
        setState(() {
          if (currentStoryIndex <
              widget.stories[widget.currentIndex].stories.length - 1) {
            percentValue[currentStoryIndex] = 1;
            currentStoryIndex++;
            _controller.reset();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                        if (downloadProgress.progress == 1.0) {
                          _controller.forward();
                        }
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
                      },
                      imageBuilder: (context, imageProvider) {
                        _controller.forward();
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
                  : _videoPlayerController!.value.isPlaying
                      ? VideoPlayer(_videoPlayerController!)
                      : Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white60,
                            ),
                          ),
                        ),
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
                Padding(
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
                            displayPictureURL: widget
                                .stories[widget.currentIndex]
                                .userDisplayPicture,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.stories[widget.currentIndex].userName,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
