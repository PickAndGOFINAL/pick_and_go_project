import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pick_and_go_project/Admin/Navigationbar.dart';
import 'package:pick_and_go_project/Project_Provider/Progress_hud.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Screens/signup_screen.dart';
import 'package:pick_and_go_project/Project_Services/Auth.dart';
import 'package:pick_and_go_project/Project_Provider/AdminState.dart';
import 'package:provider/provider.dart';
import 'package:pick_and_go_project/Project_Screens/Kiosk_Screen.dart';
import 'package:pick_and_go_project/Admin/Admin.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String accessT = 'Pick & GO Users Login';

  final GlobalKey<FormState> Myglobalkey = GlobalKey<FormState>();
  String UserEmail;
  String UserPassword;
  final _auth = Auth();
  bool isAdmin = false;
  final AdminPassword = 'admin1234';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: Myglobalkey,
        child: ListView(
          children: <Widget>[
            Flexible(
              child: Hero(
                //hero widget to get the logo from thew previous page

                tag: 'logo',
                child: Container(
                  height: 120.0,
                  /*
                  child:
                  Image.asset('images/logo.png'),
                  
                   */
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * .08,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      child: Text(
                        accessT,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextFiled(
              Click: (value) {
                UserEmail = value;
              },
              Myhint: 'Please Enter Your Email',
              Myicon: Icons.email,
            ),
            SizedBox(
              height: 30,
            ),
            MyTextFiled(
              Click: (value) {
                UserPassword = value;
              },
              Myhint: 'Please Enter Your Password',
              Myicon: Icons.lock,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: Builder(
                builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.brown,
                    onPressed: () async {
                      CheckUser(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dont have an account?',
                  style: TextStyle(fontSize: 20, color: Colors.brown),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.brown),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        accessT = 'Pick & GO Admin Login';
                        Provider.of<AdminState>(context, listen: false)
                            .ChangeAdmin(true);
                      },
                      child: Text(
                        'Are you Cafe Owner?',
                        style: TextStyle(
                            color: Provider.of<AdminState>(context).Admin
                                ? Colors.white
                                : Colors.brown),
                      )),
                  GestureDetector(
                      onTap: () {
                        accessT = 'Pick & GO Users Login';

                        Provider.of<AdminState>(context, listen: false)
                            .ChangeAdmin(false);
                      },
                      child: Text(
                        'Are you a User?',
                        style: TextStyle(
                            color: Provider.of<AdminState>(context).Admin
                                ? Colors.brown
                                : Colors.white),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void CheckUser(BuildContext context) async {
    final progressHud = Provider.of<ProgressHud>(context, listen: false);
    progressHud.changeLoading(true);

    if (Myglobalkey.currentState.validate()) {
      Myglobalkey.currentState.save();

      if (Provider.of<AdminState>(context, listen: false).Admin) {
        if (UserPassword == AdminPassword) {
          try {
            await _auth.SignIn(UserEmail, UserPassword);
            Navigator.pushNamed(context, Admin.id);
          } on PlatformException catch (e) {
            progressHud.changeLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          progressHud.changeLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error!!')));
        }
      } else {
        try {
          await _auth.SignIn(UserEmail, UserPassword);
          Navigator.pushNamed(context, Navigationbar.id);
        } on PlatformException catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    progressHud.changeLoading(false);
  }
}