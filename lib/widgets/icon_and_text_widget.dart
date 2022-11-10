import 'package:flutter/cupertino.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  @override
  final IconData icon;
  final String text;
  final Color? iconcolor;

  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,

    this.iconcolor}) : super(key: key);
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconcolor, size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text)
      ],
    );
  }
}
