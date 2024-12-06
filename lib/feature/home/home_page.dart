import 'package:classbloom/feature/account/screen/profile.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'course.dart';
import 'home_Screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({this.selectedIndex=0});
  final int selectedIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex=0;
  late int currentIndex;
  List pages=[
    const HomeScreen(),
    const Course(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    currentIndex=widget.selectedIndex;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar:BottomNavigationBar(

          selectedItemColor:Colors.black,
          // backgroundColor: AppColors.lightColor,
          // unselectedItemColor: ,
          showSelectedLabels:true ,
          showUnselectedLabels:true ,
          currentIndex:currentIndex ,
          onTap:(value) {
            currentIndex=value;
            setState(() {

            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon:Icon(Icons.home_filled),
                label: ""
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.library_books_sharp),
                label: ""
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.message,),
                label: ""
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.person),
                label: ""
            ),
          ]
      ) ,
    );
  }
}
