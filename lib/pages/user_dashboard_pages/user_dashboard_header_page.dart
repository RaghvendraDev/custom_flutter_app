import 'package:customapp/widget/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserDashboardHeader extends StatelessWidget {
  const UserDashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   "User List",
        //   style: TextStyle(
        //       fontSize: 15,
        //       color: MyTheme.darkBluishColor,
        //       fontWeight: FontWeight.bold),
        // )

        "User Dashboard".text.xl5.bold.color(MyTheme.darkBluishColor).make(),
      ],
    );
  }
}
