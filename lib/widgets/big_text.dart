import 'package:flutter/material.dart';
import 'package:flutter_perfume_application/utils/dimension.dart';

class BigText extends StatelessWidget {
  Color? color;
  //Dấu chấm hỏi được sử dụng để đánh dấu một biến hoặc một giá trị có thể là null.
  final String text;
  double size;
  TextOverflow overflow;

  BigText({super.key, this.color = const Color(0xff332d2b), this.size = 0, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        maxLines: 1,
        //Xác định số lượng dòng tối đa mà nội dung có thể hiển thị, khi vượt quá số dòng sẽ thay thế bằng dấu ba chấm.
        overflow: overflow,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size == 0 ? Dimensions.fonts20 : size,
          fontWeight: FontWeight.w400
        ),

    );
  }
}


