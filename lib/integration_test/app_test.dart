import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stage_project/models/story_model.dart';
import 'package:stage_project/screens/home_screen.dart';


final storiesData = [
  const StoryModel(
    userName: 'User 1',
    userDisplayPicture: 'https://drive.google.com/uc?export=view&id=1VSLQvJ6mL9kQdoK6bh-kt7x1vP1m6ggg',
    stories: [
      Story(
        type: FileType.image,
        url: 'https://images.pexels.com/photos/1154059/pexels-photo-1154059.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      Story(
        type: FileType.video,
        url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    ],
  ),
];

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Testing', () {
    testWidgets('should display user\'s display picture as image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(storyList: storiesData),
        ),
      );

      expect(find.byType(Text), findsOneWidget);

      await tester.tap(find.byType(Text));

    });
  });
}
