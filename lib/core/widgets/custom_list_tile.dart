
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';


class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLeadingTap,
    this.onTrailingTap,
    this.width = 0.99,
    this.height = 0.08,
    this.bgColor,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w*1,
      height:  h*0.4,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        // border: Border.all(color: borderColor ?? Colors.grey),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            if (leading != null)
              GestureDetector(
                onTap: onLeadingTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: leading,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: title,
                    ),
                  if (subtitle != null)
                    subtitle!,
                ],
              ),
            ),
            if (trailing != null)
              GestureDetector(
                onTap: onTrailingTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: trailing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
