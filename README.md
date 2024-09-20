# Instagram Story

This project is a Single Page Application that displays stories (images and videos) similar to popular social media platforms. The app is built using BLoC for state management, ensuring a clear separation of business logic and UI, while maintaining high scalability and maintainability.


# How to use

1. Start the app on your preferred device or emulator.
2. The splash screen will load automatically when the app is launched. Wait for it to complete.
3. On the home screen, you will see a row of story thumbnails with user names. Click on any image or name in the story row to view the corresponding story.
4. While viewing a story, click on the right side of the screen to move to the next story in the sequence.
5. To go back to the previous story, simply click on the left side of the screen.
6. If you wish to exit the story view, click on the Close (X) button located in the top-right corner of the screen.


# Key Features

- 'Story View with Images and Videos': The app utilizes the CachedNetworkImage and VideoPlayer packages to load and display images or videos in the story format.
- 'Image Duration': Each image is displayed for a fixed duration of 5 seconds before automatically transitioning to the next story.
- 'Video Playback': Videos are played for their full length without any fixed time limit. However, a video duration limit can easily be added if needed.
- 'Smooth Transitions': Users can navigate between stories by tapping on the left or right sides of the screen, with seamless transitions between images and videos.


# Dependencies

- 'BLoC': For state management and handling story progression.
- 'CachedNetworkImage': To load and display network images efficiently.
- 'VideoPlayer': For video playback functionality within stories.
