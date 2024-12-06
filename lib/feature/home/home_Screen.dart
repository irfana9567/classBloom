import 'package:classbloom/core/constants/image_const.dart';
import 'package:classbloom/feature/home/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/color_const.dart';
import '../../core/widgets/custom_layout.dart';
import '../../core/widgets/custom_list_tile.dart';
import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List assessments=[
    {
      "tool":"Quiz",
      "icon":"assets/icons/exam.svg"
    },
    {
      "tool":"Exam",
      "icon":"assets/icons/quiz.svg"
    },
  ];
  List course=[
    {
      "course":" Flutter Development Basics",
      "description":"Learn the fundamentals of Flutter and Dart, including widgets, state management, and UI design. Perfect for beginners looking to build cross-platform mobile applications."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Palette.whiteColor,
          title: Text("Welcome",style: TextStyle(
            fontSize: w*0.05,
              fontWeight: FontWeight.w700,
          ),),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: w * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h*0.2,
                  child: CustomListLayout(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Center(
                        child: SizedBox(
                          width: w*0.1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:() {},
                                child: CircleAvatar(
                                  radius: w * 0.03,
                                  backgroundColor: Palette.lightGreenColor,
                                  child: SvgPicture.asset(assessments[index]["icon"]),
                                ),
                              ),
                              Text(assessments[index]["tool"],
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                ),
                SizedBox(height: w * 0.08),
                Text(
                  "Courses",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.035,
                  ),
                ),
                SizedBox(height: w * 0.03),
                SizedBox(
                  height: h*0.9,
                  child:CustomListLayout(
                    itemCount: course.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CourseScreen(title: course[index]["course"],),));
                        },
                        child: CustomListTile(
                          bgColor: Palette.secondaryColor,
                          leading: SvgPicture.asset(
                            iconConst.logo,
                            height: h*0.07,
                          ),
                          title:  Text(course[index]["course"],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
            
                          ),
                          subtitle:  Text(course[index]["description"],),
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: h*0.9,
                //   child: GridView.builder(
                //     itemCount:2,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 2,
                //       mainAxisSpacing: 2,
                //       childAspectRatio: 0.8
                //     ),
                //     itemBuilder: (context, index) {
                //       return Container(
                //         width: w*0.07,
                //         height: w*0.05,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(w*0.03),
                //           boxShadow: [
                //             BoxShadow(
                //                 color: Colors.black.withOpacity(0.1),
                //                 blurRadius: 14,
                //                 offset: const Offset(0, 4),
                //                 spreadRadius: 0
                //             )
                //           ]
                //         ),
                //         child: Column(
                //
                //         ),
                //       );
                //     },
                //   ),
                // ),
            
              ],
            ),
          ),
        ),
    );
  }
}
