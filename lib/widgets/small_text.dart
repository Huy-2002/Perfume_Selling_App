import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  //Dấu chấm hỏi được sử dụng để đánh dấu một biến hoặc một giá trị có thể là null.
  final String text;
  double size;
  double height;

  SmallText({super.key, this.color = const Color(0xFF8f837f), this.size = 12, this.height = 1.2, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        height: height

      ),
    );
  }
}