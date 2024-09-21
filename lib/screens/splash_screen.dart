import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc.dart';
import 'package:stage_project/bloc/story_bloc/story_bloc_events.dart';
import 'package:stage_project/screens/home_screen.dart';
import '../bloc/story_bloc/story_bloc_states.dart';
import '../models/story_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StoryBloc storyBloc;
  List<StoryModel> storyList = [];

  @override
  void initState() {
    storyBloc = StoryBloc();
    storyBloc.add(FetchStoriesEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => storyBloc,
        child: BlocListener<StoryBloc, StoryState>(
          listener: (context, state) {
            if (state is SuccessStoryFetchingState) {
              storyList = state.storyList;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(
                    storyList: storyList,
                  ),
                ),
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: Image.asset(
                "assets/instagram_logo_.png",
                width: MediaQuery.sizeOf(context).width / 2.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
