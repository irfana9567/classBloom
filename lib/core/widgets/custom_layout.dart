import 'package:flutter/cupertino.dart';

import '../../main.dart';

class CustomListLayout extends StatelessWidget {
  const CustomListLayout({super.key,
    required this.itemCount,
    required this.itemBuilder, this.scrollDirection});

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection:scrollDirection ?? Axis.vertical ,
        itemBuilder: itemBuilder,
        separatorBuilder: (context, index) => SizedBox(height:h*0.015,),
        itemCount: itemCount
    );
  }
}