import 'package:customapp/widget/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserImage extends StatelessWidget {
  final String imageName;
  const UserImage({Key? key, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageName,
    ).box.p16.rounded.color(MyTheme.creamColor).make().p16().wh40(context);
  }
}
