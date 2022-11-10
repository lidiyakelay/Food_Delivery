import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  final Color iconcolor;
  bool isObsecure;
  AppTextField({Key? key, required this.textEditingController, required this.hintText, required this.iconData, this.iconcolor=Colors.grey, this.isObsecure=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius:7,
                offset: Offset(1,10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObsecure,
        controller: textEditingController,
        decoration:InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(iconData, color: iconcolor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.white
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.white
              )
          ),
          border:
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),

          ),
        ) ,
      ),
    );
  }
}
