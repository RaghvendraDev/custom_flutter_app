import 'dart:convert';
import 'dart:ui';

import 'package:customapp/utils/myRoutes.dart';
import 'package:customapp/utils/webservices.dart';
import 'package:customapp/widget/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var emailController = new TextEditingController();
    var passwordController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/hey.png"),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      label: Text('Email'),
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      label: Text('Password'),
                      suffixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        login(emailController.text, passwordController.text);
                      },
                      icon: Icon(
                        Icons.login,
                        size: 18,
                      ),
                      label: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        primary: MyTheme.darkBluishColor,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //CREATE FUNCTION TO CALL LOGIN POST API

  Future<void> login(var _email, var _pass) async {
    final String email = _email, password = _pass;
    if (email.isNotEmpty && password.isNotEmpty) {
      Map<String, dynamic> bodyData = {"userid": email, "userPass": password};
      String bodyJsonData = jsonEncode(bodyData);

      var serverResponse = await http.post(
          Uri.parse(Webservices.loginAuthentication_url),
          body: bodyJsonData);

      Map<String, dynamic> responseData = jsonDecode(serverResponse.body);

      if (serverResponse.statusCode == 200) {
        Navigator.pushNamed(context, MyRoutes.homeDashboardRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Userid/password"),
          backgroundColor: Colors.cyan,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Field cant be blank"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
