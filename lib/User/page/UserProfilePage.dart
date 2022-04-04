import 'package:dooromi/User/model/AuthToken.dart';
import 'package:flutter/material.dart';
import '../model/DetailUser.dart';

import '../../HeavyEquipment/page/HeavyEquipmentListPage.dart';
import 'LoginPage.dart';

class UserProfilePage extends StatefulWidget {
  final DetailUser user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => new _UserProfilePageState(user: user);
}

class _UserProfilePageState extends State<UserProfilePage> {
  final DetailUser user;

  _UserProfilePageState({required this.user});

  @override
  Widget build(BuildContext context) {
    print("userprofile : " + AuthToken.token);
    print(user.toString());
    print(user.email);
    print(user.joinedAt);
    print(AuthToken.user.email);
    print(AuthToken.user.joinedAt);

    if (AuthToken.token == null || AuthToken.token.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new LoginPage()),
          (route) => false);
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('프로필'),
        ),
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Padding(
                    child: new Icon(Icons.person,
                        color: const Color(0xFF000000), size: 100.0),
                    padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 0.0),
                  ),
                  new Center(
                    child: new Padding(
                      child: new Text(
                        AuthToken.user.username,
                        style: new TextStyle(
                            fontSize: 38.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 24.0),
                    ),
                  ),
                  new Center(
                    child: new Padding(
                      child: new Text(
                        AuthToken.user.email,
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                    ),
                  ),
                  new Center(
                    child: new Padding(
                      child: new Text(
                        AuthToken.user.joinedAt,
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                    ),
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("회원정보 수정"),
                          onPressed: () {},
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          child: Text("나의 장비"),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    settings: RouteSettings(name: "/HeavyEquipmentListPage"),
                                    builder: (context) => new HeavyEquipmentListPage()
                                ));
                          },
                        ),
                      ])
                ]),
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.center,
          ),
        ));
  }
}
