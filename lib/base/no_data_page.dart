import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

class NoData extends StatelessWidget {

  final String text;
  final String imgPath;
  const NoData({Key? key, required this.text, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image(image: AssetImage(imgPath),
        height: MediaQuery.of(context).size.height*0.22,
        width: MediaQuery.of(context).size.height*0.22,),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Text(text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height*0.0175,
          color: Theme.of(context).disabledColor
        ),
        textAlign: TextAlign.center,),
      ],
    );
  }
}
