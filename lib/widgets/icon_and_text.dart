import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';
import 'package:flutter_perfume_application/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  const IconAndText({
  super.key, 
  required this.icon, 
  required this.text, 
  required this.iconColor
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text),
      ],
    );
  }
}