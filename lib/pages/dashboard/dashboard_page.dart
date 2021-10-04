import 'package:customapp/utils/myRoutes.dart';
import 'package:customapp/widget/custom_buttons/gradient_button.dart';
import 'package:customapp/widget/custom_buttons/square_button_with_white_fill.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Main Dashboard".text.make(),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     sayHello(context);
              //   },
              //   child: Text("Hello"),
              // ),
              GradientButton(
                  buttonText: "First Button",
                  width: 150,
                  height: 50,
                  buttonclicked: () {
                    sayHello(context);
                  }),
              SizedBox(
                height: 50,
              ),
              // SquareButtonWithColorFill(
              //     buttonText: "First Button",
              //     width: 150,
              //     height: 50,
              //     onpressed: heySecondButton),
            ],
          ),
        ));
  }

  void sayHello(var _ctx) {
    Navigator.pushNamed(_ctx, MyRoutes.userDashboardRoute);
  }

  void heySecondButton() {
    print("Hello Second");
  }
}
