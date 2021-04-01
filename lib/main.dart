import 'package:flutter/material.dart';
import 'package:flutter_test_application/view/HomeScreen.dart';
import 'package:flutter_test_application/view/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String userName =  prefs.getString('userName');
  runApp(MyApp(userName: userName,));
}

class MyApp extends StatelessWidget {
  final String userName;

  const MyApp({Key key, this.userName}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: this.userName == null ?  LoginScreen() : HomeScreen(),
      routes: {
        HomeScreen.route : (context) => HomeScreen(),
      },
    );
  }
}
