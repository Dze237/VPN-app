import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';


class CustomWidget extends StatelessWidget
{

  final String titleText;
  final String subTitleText;
  final Widget roundWidgetWithIcon;

   CustomWidget({
     super.key,
     required this.titleText,
     required this.subTitleText,
     required this.roundWidgetWithIcon,
   });

  @override
  Widget build(BuildContext context)
  {
    sizeScreen = MediaQuery.of(context).size;

    return SizedBox(
      width: sizeScreen.width * .46,
      child: Column(
        children: [

          roundWidgetWithIcon,

          const SizedBox(
            height: 7,
          ),

            Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(
            height: 7,
          ),
          Text(
            subTitleText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),


        ],
      )
    );
  }
}