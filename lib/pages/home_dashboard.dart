import 'dart:convert';

import 'package:customapp/model/login_model_data_list.dart';
import 'package:customapp/model/user_model.dart';
import 'package:customapp/model/user_model_list.dart';
import 'package:customapp/utils/webservices.dart';
import 'package:customapp/widget/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({Key? key}) : super(key: key);

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
        ),
        backgroundColor: MyTheme.darkBluishColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (UserModelList.users.length != null &&
                UserModelList.users.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: UserModelList.users.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(UserModelList.users[index].image),
                      title: Text("${UserModelList.users[index].name}"),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
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
