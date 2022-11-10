import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final Color iconcolor;
  final double size;
  final double iconSize;
  AppIcon ({Key? key,
    required this.icon,
    this.backgroundcolor= const Color(0xFFfcf4e4),
    this.iconcolor= const Color(0xFF756d54),
    this.size=40,
    this.iconSize=0}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(size/2),
      ),
      child: Icon(
        icon,
        color: iconcolor,
        size: iconSize==0? Dimensions.iconSize16: iconSize,
      ),
    );
  }
}
