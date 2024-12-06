import 'package:flutter/material.dart';
import '../constants/color_const.dart';
import '../global_variable/global_variable.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fountSize;
  final Color color;
  final FontWeight weight;
  final TextOverflow? overflow;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fountSize = 0.035,
    this.color = Palette.blackColor,
    this.weight = FontWeight.normal,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Text(
      text,
      // textAlign: TextAlign.justify,
      overflow: overflow,
      style: TextStyle(
          fontFamily: fount,
          // decoration: TextDecoration.combine()
          color: color,
          fontSize: w * fountSize,
          fontWeight: weight),
    );
  }
}
class AppsHelper{
  static void showSnackBar(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  static void showAlert(String message,BuildContext context,bool isConformation,VoidCallback? onPressed,){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: Text(title),
          content: Text(message),
          actions: isConformation == true
              ? [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("No")),
            TextButton(onPressed: () {onPressed?.call();}, child: const Text("Yes")),
          ]
              :[TextButton(onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"))],
        );
      },);
  }
  static bool isDarkMood(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<String> setSearch(String caseUser) {
    List<String> caseSearchList = [];
    String temp = "";

    // Split the user's name into individual words
    List<String> nameSplits = caseUser.split(" ");

    // Generate keywords for each part of the name
    for (String name in nameSplits) {
      temp = "";
      for (int i = 0; i < name.length; i++) {
        temp += name[i];
        caseSearchList.add(temp.toUpperCase()); // Add uppercase substring
      }
    }

    return caseSearchList;
  }

}
