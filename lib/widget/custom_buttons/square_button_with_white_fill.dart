import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SquareButtonWithColorFill extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;
  final Function onpressed;

  const SquareButtonWithColorFill({
    Key? key,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: ElevatedButton(
        child: "${buttonText}".text.make(),
        onPressed: () {
          onpressed();
        },
        style: ButtonStyle(
          alignment: Alignment.center,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          //backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
