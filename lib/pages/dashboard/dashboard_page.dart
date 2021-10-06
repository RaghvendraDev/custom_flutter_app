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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     sayHello(context);
              //   },
              //   child: Text("Hello"),
              // ),
              Row(
                children: [
                  GradientButton(
                      buttonText: "Load User Dashboard",
                      width: 150,
                      height: 50,
                      buttonclicked: () {
                        loadUserDashboard(context);
                      }).expand(),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GradientButton(
                      buttonText: "Load Dropdown Dashboard",
                      width: 150,
                      height: 50,
                      buttonclicked: () {
                        loadDropdownPage(context);
                      }).expand(),
                ],
              ),
            ],
          ),
        ));
  }

  void loadUserDashboard(var _ctx) {
    Navigator.pushNamed(_ctx, MyRoutes.userDashboardRoute);
  }

  void loadDropdownPage(var _ctx) {
    Navigator.pushNamed(_ctx, MyRoutes.dropdownDashboardRoute);
  }
}
