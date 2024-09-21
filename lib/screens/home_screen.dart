import 'package:flutter/material.dart';
import 'package:stage_project/screens/story_view.dart';
import 'package:stage_project/widgets/reusable_widgets/story_widget.dart';
import '../models/story_model.dart';

class HomeScreen extends StatefulWidget {
  final List<StoryModel> storyList;

  const HomeScreen({super.key, required this.storyList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    //Pre-Caching Images for better performance of the app
    for (var url in widget.storyList) {
      for (var image in url.stories) {
        if (image.type == FileType.image) {
          precacheImage(NetworkImage(image.url), context);
        }
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Image.asset(
                "assets/instagram_logo_.png",
                width: MediaQuery.sizeOf(context).width / 2.2,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.storyList.length,
                itemBuilder: (context, index) {
                  return StoryWidget(
                    storyDetail: widget.storyList[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StoryView(
                            stories: widget.storyList,
                            currentIndex: index,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
