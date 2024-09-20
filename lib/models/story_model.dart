class StoryModel {
  final String userName;
  final String userDisplayPicture;
  final List<Story> stories;

  const StoryModel(
      {required this.userName,
      required this.userDisplayPicture,
      required this.stories,});
}

class Story {
  final String url;
  final FileType type;

  const Story({required this.url, required this.type});
}

enum FileType { image, video }
