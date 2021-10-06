import 'dart:convert';
import 'dart:ui';

import 'package:customapp/model/login_model.dart';
import 'package:customapp/model/login_model_data_list.dart';
import 'package:customapp/pages/dashboard/dashboard_page.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    //variable to store username and password
    var emailController = new TextEditingController();
    var passwordController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/hey.png"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        label: Text('Email'),
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username can not be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can not be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? ElevatedButton.icon(
                            onPressed: () {
                              login(emailController.text,
                                  passwordController.text);
                            },
                            icon: const Icon(
                              Icons.login,
                              size: 18,
                            ),
                            label: const Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: MyTheme.darkBluishColor,
                            ))
                        : const CircularProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
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

    if (_formKey.currentState!.validate()) {
      print("Hello");
      setState(() {
        isLoading = false;
      });
    } else {
      print("not");
      setState(() {
        isLoading = true;
      });
    }
    if (email.isNotEmpty && password.isNotEmpty) {
      Map<String, dynamic> bodyData = {"userId": email, "userPass": password};
      String bodyJsonData = jsonEncode(bodyData);

      var serverResponse = await http.post(
          Uri.parse(Webservices.loginAuthentication_url),
          body: bodyJsonData);

      if (serverResponse.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(serverResponse.body);
        // print(responseData);
        // print(responseData.length);

        LoginModelDataList.uName = LoginModel.fromMap(responseData).r_userId;
        LoginModelDataList.uPass = LoginModel.fromMap(responseData).r_userPass;

        setState(() {
          isLoading = true;
        });

        Navigator.pushNamed(context, MyRoutes.mainDashboardRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Userid/password"),
          backgroundColor: Colors.cyan,
        ));

        setState(() {
          isLoading = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Field cant be blank"),
        backgroundColor: Colors.red,
      ));

      setState(() {
        isLoading = true;
      });
    }
  }
}
