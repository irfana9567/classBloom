import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/color_const.dart';
import '../../core/constants/image_const.dart';
import '../../core/widgets/custom_layout.dart';
import '../../core/widgets/custom_list_tile.dart';
import '../../main.dart';
import 'video_playerscreen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, this.title});
  final String? title;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final courses1 = [
    {
      'title': 'Introduction to Flutter',
      'description': 'Learn the basics of Flutter development.',
      'detailedDescription':
      'This video introduces Flutter, a popular framework for building cross-platform apps.\n It covers the installation process, understanding widgets, and exploring the basics of the Flutter architecture. By the end of this video, \nyou’ll have a good grasp of what Flutter is and how it works.',
      'videoUrl': '//www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    },
    {
      'title': 'Building Your First Flutter App',
      'description': 'Step-by-step guide to build a Flutter app.',
      'detailedDescription':
      'This lesson walks you through creating your first Flutter app. It covers setting up the development environment, building a simple UI with widgets, adding interactivity, and running the app on an emulator or device. You’ll learn how to handle user inputs and build the foundation of any Flutter application.',
      'videoUrl':
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    },
  ];

  // State variable to track unlocked videos
  List<bool> unlockedVideos = [true, false]; // First video is unlocked by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Text(
          widget.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: w * 0.03,
          right: w * 0.03,
          top: w * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lesson",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: w * 0.03,
              ),
            ),
            SizedBox(height: w * 0.05),
            SizedBox(
              height: h * 1.5,
              child: CustomListLayout(
                itemCount: courses1.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: unlockedVideos[index]
                        ? () async {
                      // Navigate to the video player
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            title: courses1[index]["title"]!,
                            video: courses1[index]["videoUrl"]!,
                            description: courses1[index]
                            ["detailedDescription"]!,
                          ),
                        ),
                      );

                      // Unlock the next video after completion
                      if (index + 1 < courses1.length) {
                        setState(() {
                          unlockedVideos[index + 1] = true;
                        });
                      }
                    }
                        : null, // Disable onTap for locked videos
                    child: CustomListTile(
                      bgColor: Palette.secondaryColor,
                      leading: SvgPicture.asset(
                        iconConst.video,
                        height: h * 0.15,
                      ),
                      title: Text(
                        courses1[index]["title"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(courses1[index]["description"]!),
                      trailing: Icon(
                        unlockedVideos[index]
                            ? Icons.lock_open // Unlocked icon
                            : Icons.lock_outline_sharp, // Locked icon
                      ),
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
