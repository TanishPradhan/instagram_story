import 'package:flutter/material.dart';
import 'package:stage_project/screens/story_view.dart';
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
                        return GestureDetector(
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
                                          widget.storyList[index]
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
                                  widget.storyList[index].userName,
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
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
