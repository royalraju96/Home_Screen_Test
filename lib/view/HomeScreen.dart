import 'package:flutter/material.dart';
import 'package:flutter_test_application/view/DetailWidget.dart';
import 'package:flutter_test_application/view/LoginScreen.dart';
import 'package:flutter_test_application/widget/CustomSize.dart';
import 'package:flutter_test_application/widget/HomeCardGridWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.deepOrangeAccent,
              title: Text("Log Out"),
              trailing: IconButton(
                icon: Icon(Icons.power_settings_new_outlined),
                onPressed: () async {
                  /*It will remove the user credentials from the tree*/
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('userName');
                  prefs.remove('password');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
              ),
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.segment),
                    onPressed: () {
                      _key.currentState.openDrawer();
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 280,
                  ),
                  Center(
                      child: Text("FlyingWolf",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ],
              ),
              CustomSize.mediumHeight,
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          AssetImage('asset/logo/RajuProfilePic.jpeg'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 320,
                  ),
                  Column(
                    children: [
                      Text(
                        "Raju",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      CustomSize.smallHeight,
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "2250",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            CustomSize.smallWidth,
                            Text("Elo Rating"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomSize.smallHeight,
              SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: [
                    GridWidget(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      gradientColor: [
                        Colors.orange,
                        Colors.orange[200],
                      ],
                      text: "34 Tournaments played",
                    ),
                    GridWidget(
                      gradientColor: [
                        Colors.purple,
                        Colors.purple[200],
                      ],
                      text: "09 Tournaments won",
                    ),
                    GridWidget(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradientColor: [
                        Colors.redAccent,
                        Colors.redAccent[200],
                      ],
                      text: "26%       Winning Percentage",
                    ),
                  ],
                ),
              ),
              CustomSize.smallHeight,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommended For You",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              CustomSize.smallHeight,
              DetailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
