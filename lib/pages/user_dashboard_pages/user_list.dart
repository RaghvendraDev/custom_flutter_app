import 'package:customapp/model/user_model.dart';
import 'package:customapp/model/user_model_list.dart';
import 'package:customapp/pages/user_dashboard_pages/user_image.dart';
import 'package:customapp/widget/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: UserModelList.users.length,
      itemBuilder: (context, index) {
        var userdetailIndex = UserModelList.users[index];
        return UserListDetail(
          userdetail: userdetailIndex,
        );
      },
    );
  }
}

class UserListDetail extends StatelessWidget {
  final User userdetail;
  const UserListDetail({Key? key, required this.userdetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Card(
    //       child: ListTile(
    //         leading: Image.network(userdetail.image),
    //         title: Text("${userdetail.name}"),
    //         trailing: Text("\$${userdetail.price}"),
    //         onTap: () {
    //           print("${userdetail.name}");
    //         },
    //       ),
    //     ),
    //     // ElevatedButton(
    //     //   onPressed: () {},
    //     //   child: Text("hello"),
    //     // )
    //   ],
    // );

    return VxBox(
      child: Row(
        children: [
          Hero(
              //this tag will connect from home detail page's hero tag
              tag: Key(userdetail.id.toString()),
              // tag: 'animateIt',
              child: UserImage(imageName: userdetail.image)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userdetail.name.text.lg
                    .color(MyTheme.darkBluishColor)
                    .bold
                    .make(),
                userdetail.desc.text.make(),
                10.heightBox,
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  // buttonPadding: Vx.mH16,
                  children: [
                    "\$${userdetail.price}".text.make(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            MyTheme.darkBluishColor,
                          ),
                          shape: MaterialStateProperty.all(
                            StadiumBorder(),
                          )),
                      child: "Buy".text.make(),
                    ),
                  ],
                ).pOnly(right: 8.0),
              ],
            ),
          ),
        ],
      ),
    ).white.rounded.square(150).make().py16();
  }
}
