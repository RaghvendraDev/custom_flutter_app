import 'dart:convert';

import 'package:customapp/model/user_model.dart';
import 'package:customapp/model/user_model_list.dart';
import 'package:customapp/pages/user_dashboard_pages/user_dashboard_header_page.dart';
import 'package:customapp/pages/user_dashboard_pages/user_list.dart';
import 'package:customapp/utils/webservices.dart';
import 'package:customapp/widget/theme_data.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Dashboard",
      //   ),
      //   backgroundColor: MyTheme.darkBluishColor,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Colors.black),
      // ),
      body: SafeArea(
          child: Container(
        padding: Vx.m32,
        child: Column(
          children: [
            UserDashboardHeader(),
            (UserModelList.users.length != null &&
                    UserModelList.users.isNotEmpty)
                ? UserList().expand()
                : CircularProgressIndicator().centered().expand(),
          ],
        ),
      )

          // child: (UserModelList.users.length != null &&
          //         UserModelList.users.isNotEmpty)
          //     ? ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: UserModelList.users.length,
          //         itemBuilder: (context, index) {
          //           return Card(
          //             child: ListTile(
          //               leading:
          //                   Image.network(UserModelList.users[index].image),
          //               title: Text("${UserModelList.users[index].name}"),
          //             ),
          //           );
          //         },
          //       )
          //     : Center(child: CircularProgressIndicator()),
          ),
    );
  }

  Future loadJson() async {
    await Future.delayed(
      Duration(seconds: 2),
    );

    var response = await http.get(Uri.parse(Webservices.json_file_url));

    var jsonData = jsonDecode(response.body);
    var decodeData = jsonData['products'];

    UserModelList.users = [];

    for (var item in decodeData) {
      User user = User(
          id: item['id'],
          name: item['name'],
          desc: item['desc'],
          price: item['price'],
          color: item['desc'],
          image: item['image']);
      UserModelList.users.add(user);
    }

    print(UserModelList.users.length);

    //alternate way

    // UserModelList.users =
    //     List.from(decodeData).map((e) => User.fromMap(e)).toList();

    setState(() {});
  }
}
