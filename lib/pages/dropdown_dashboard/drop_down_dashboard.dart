import 'dart:convert';

import 'package:customapp/model/project_head_model.dart';
import 'package:customapp/model/project_head_model_list.dart';
import 'package:customapp/model/projetcs_model.dart';
import 'package:customapp/model/projetcts_model_list.dart';
import 'package:customapp/utils/webservices.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class DropDownDashboard extends StatefulWidget {
  const DropDownDashboard({Key? key}) : super(key: key);

  @override
  State<DropDownDashboard> createState() => _DropDownDashboardState();
}

class _DropDownDashboardState extends State<DropDownDashboard> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  List<DropdownMenuItem<String>> secondDropDownItems = [];
  List projectDataList = [];
  String dropdownValue = "";
  String secondDropdownValue = "";
  bool disableSecondDropdown = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Dropdown Page".text.make(),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (DropdownModelList.projectsName != null &&
                    DropdownModelList.projectsName.isNotEmpty)
                ? DropdownButton(
                    value: dropdownValue,
                    hint: "Please Select Project".text.make(),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: dropDownItems,
                    onChanged: (value) => loadProjectDetails(value),
                    // onChanged: (newValue) {
                    //   setState(() {
                    //     dropdownValue = newValue.toString();
                    //   });
                    // },
                  )
                : CircularProgressIndicator().centered().expand(),
            SizedBox(
              height: 20.0,
            ),
            DropdownButton(
              value: secondDropdownValue,
              hint: "Please selct abobe first".text.make(),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: secondDropDownItems,
              onChanged: disableSecondDropdown
                  ? null
                  : (value) => loadProjectHeadDetails(value),
              // onChanged: (newValue) {
              //   setState(() {
              //     dropdownValue = newValue.toString();
              //   });
              // },
            ),
            Text(
              ("$secondDropdownValue"),
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadProject() async {
    // await Future.delayed(
    //   Duration(seconds: 2),
    // );

    print("Hello from load json");

    var response =
        await http.get(Uri.parse(Webservices.projects_json_file_url));

    var jsonData = jsonDecode(response.body);
    var decodeData = jsonData['projects'];

    DropdownModelList.projectsName = [];
    for (var item in decodeData) {
      ProjectsNameModel proj = ProjectsNameModel(
        id: item['id'],
        name: item['name'],
      );
      DropdownModelList.projectsName.add(proj);
    }
    // dropDownItems = ['One', 'Two', 'Three'].map(
    //   (val) {
    //     return DropdownMenuItem<String>(
    //       value: val,
    //       child: Text(val),
    //     );
    //   },
    // ).toList();

    // List<String> projectNameList = [];
    // for (var i = 0; i < DropdownModelList.projectsName.length; i++) {
    //   projectNameList.add(DropdownModelList.projectsName[i].name);
    // }

    // dropDownItems = projectNameList.map(
    //   (val) {
    //     return DropdownMenuItem<String>(
    //       value: val,
    //       child: Text(val),
    //     );
    //   },
    // ).toList();

    projectDataList = decodeData;

    setState(() {
      dropdownValue = DropdownModelList.projectsName[0].name.toString();
      dropDownItems =
          DropdownModelList.projectsName.map((ProjectsNameModel project) {
        return DropdownMenuItem<String>(
          child: Text(
            project.name,
            style: TextStyle(color: Colors.black),
          ),
          value: project.name,
        );
      }).toList();
      // dropDownItems = projectDataList.map(
      //   (val) {
      //     return DropdownMenuItem<String>(
      //       // value: val['id'].toString(),
      //       value: val['name'].toString(),
      //       child: Text(val['name']),
      //     );
      //   },
      // ).toList();
    });
  }

  Future<void> loadProjectDetails(var _value) async {
    setState(() {
      // selectedValue = _value.toString();
      dropdownValue = _value;
      print("value= ${dropdownValue}");
    });
    // disableSecondDropdown = false;
    // secondDropdownValue = "One";
    // secondDropDownItems = ['One', 'Two', 'Three'].map(
    //   (val) {
    //     return DropdownMenuItem<String>(
    //       value: val,
    //       child: Text(val),
    //     );
    //   },
    // ).toList();

    //calling api using post method

    Map<String, dynamic> bodyData = {"projectName": dropdownValue};
    String bodyJsonData = jsonEncode(bodyData);

    var serverResponse = await http.post(
        Uri.parse(Webservices.project_head_json_file_from_server_url),
        body: bodyJsonData);

    if (serverResponse.statusCode == 200) {
      print(serverResponse.body);

      var jsonData = jsonDecode(serverResponse.body);
      print(jsonData);
      var decodeData = jsonData[dropdownValue];

      // var response =
      //     await http.get(Uri.parse(Webservices.project_head_json_file_url));

      // var jsonData = jsonDecode(response.body);
      // print(jsonData);
      // var decodeData = jsonData['projectheads'];

      ProjectHeadModelList.projectHeadModelsName = List.from(decodeData)
          .map((e) => ProjectHeadModel.fromMap(e))
          .toList();

      // //setting data to Dropdownmenu item list

      setState(() {
        disableSecondDropdown = false;
        print("initial value ${secondDropdownValue}");
        //setting value to dropdown, value should be one of the from json list
        secondDropdownValue =
            ProjectHeadModelList.projectHeadModelsName[0].name.toString();

        print("after set value ${secondDropdownValue}");
        secondDropDownItems = ProjectHeadModelList.projectHeadModelsName
            .map((ProjectHeadModel projectHead) {
          return DropdownMenuItem<String>(
            child: Text(
              projectHead.name,
              style: TextStyle(color: Colors.black),
            ),
            value: projectHead.name,
          );
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Server Issue"),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    }
  }

  void loadProjectHeadDetails(var _value) {
    setState(() {
      // selectedValue = _value.toString();
      secondDropdownValue = _value;
      print("second value= ${secondDropdownValue}");
    });
  }
}
