import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon icon;
  final BigText bigText;
  const AccountWidget({Key? key, required this.icon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(

      padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20),
      child: Row(
        children: [
          icon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
