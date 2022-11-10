import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  AppColumn({Key? key, required this.text}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text:text, Size: Dimensions.font26,),
        SizedBox(height:Dimensions.height10),
        Row(
          children: [
            Wrap(
                children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor,
                  size: Dimensions.iconSize15,) )
            ),
            SizedBox(width:10),
            SmallText(text:'4.5'),
            SizedBox(width:10),
            SmallText(text:'1287'),
            SizedBox(width:5),
            SmallText(text:'Comments'),


          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            IconAndTextWidget(
              icon: Icons.circle,
              text:'Normal',
              iconcolor: AppColors.iconColor1,),

            IconAndTextWidget(
              icon: Icons.location_on,
              text:'1.7km',
              iconcolor: AppColors.mainColor,
            ),

            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text:'32min',
              iconcolor: AppColors.iconColor2,),
            SizedBox(width:5),
          ],
        )
      ],
    );
  }
}
