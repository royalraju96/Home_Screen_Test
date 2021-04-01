import 'package:flutter/material.dart';
import 'package:flutter_test_application/model/LoginModel.dart';
import 'package:flutter_test_application/view/HomeScreen.dart';
import 'package:flutter_test_application/widget/CustomSize.dart';
import 'package:flutter_test_application/widget/CustomTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginRequestModel requestModel;
  bool isPasswordVisible = true;
  bool isLoggedIn = false;
  bool isLoader = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 130,
                  backgroundImage: AssetImage(
                    'asset/logo/game.tcLogo.png',
                  ),
                ),
                CustomSize.mediumHeight,
                Center(
                  child: Text("Welcome",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                CustomSize.mediumHeight,
                /* User Name Text Field */
                CustomTextField(
                  controller: usernameController,
                  obscureText: false,
                  labelText: "User Name",
                  icon: Icons.supervisor_account_outlined,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter user name";
                    } else if (val.length < 3) {
                      return "User name is too short";
                    } else if (val.length > 10) {
                      return "User name can't be greater then 10 digits";
                    } else if (!val.contains('9898989898') ||
                        val.contains('9876543210')) {
                      return "Please enter valid user id";
                    }
                    return null;
                  },
                ),
                CustomSize.smallHeight,
                /* Password TextField */
                CustomTextField(
                    controller: passwordController,
                    obscureText: isPasswordVisible,
                    icon: isPasswordVisible
                        ? Icons.lock_outline
                        : Icons.lock_open_outlined,
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Password can't be empty";
                      } else if (val.length < 3) {
                        return "Password is too small";
                      } else if (val.length > 11) {
                        return "Password can't be greater then 10 digits";
                      } else if (!val.contains("password123")) {
                        return "Invalid password";
                      }
                      return null;
                    }),
                CustomSize.xxlHeight,
                /* Navigation Button */
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  onPressed: () async {
                    if (validateAndSave()) {
                      try {
                        _setUserData(
                            usernameController.text, passwordController.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) => HomeScreen()));
                      } catch (e) {
                        print("$e");
                      }
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: size.height / 15,
                      width: size.width / 2.75,
                      child: Text(
                        "Login",
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Set User Data */
  _setUserData(String userName, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences?.setString('userName', userName);
    preferences?.setString('password', password);
  }

  /* Validate and save */
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
