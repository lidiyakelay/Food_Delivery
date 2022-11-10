import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  @override
  Color? color;
  final String text;
  double Size ;
  TextOverflow overflow;
  BigText({Key? key, this.color= const  Color(0XFF332d2b),
    required this.text,
    this.Size= 0,
    this.overflow= TextOverflow.ellipsis
  }) : super(key: key);
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color:color,
        fontSize: Size==0? Dimensions.font20 : Size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
