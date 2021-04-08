import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn/domain/user.dart';
import 'package:sn/services/auth.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;

  // AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: true,
            height: 550.0,
          ),
          items: [1, 2].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Opacity(
                    opacity: 0.95,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: (i == 1)
                                ? Colors.indigo[200]
                                : Colors.indigo[400],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40.0))),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 120.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Text(
                                    'Social Network',
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                    controller: _controllerEmail,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: 'Enter email'),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextField(
                                      controller: _controllerPassword,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          hintText: 'Enter password'),
                                      obscureText: true),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  SizedBox(
                                    width: 100.0,
                                    height: 50.0,
                                    child: OutlinedButton(
                                      child: (i == 1)
                                          ? Text('Login',
                                              style: TextStyle(fontSize: 25.0))
                                          : Text('Register',
                                              style: TextStyle(fontSize: 18.0)),
                                      style: OutlinedButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.indigo[500],
                                        shadowColor: Colors.indigo[700],
                                        elevation: 10,
                                      ),
                                      // onPressed: i == 1
                                      //     ? () async {
                                      //         print('Login');

                                      //         if (_controllerEmail
                                      //                 .text.isEmpty ||
                                      //             _controllerPassword
                                      //                 .text.isEmpty) return;
                                      //         InitialUser user =
                                      //             await _authService
                                      //                 .signInWithEmailAndPassword(
                                      //                     _controllerEmail.text
                                      //                         .trim(),
                                      //                     _controllerPassword
                                      //                         .text
                                      //                         .trim());
                                      //         if (user == null) {
                                      //           Fluttertoast.showToast(
                                      //               msg: "Can`t SignIn",
                                      //               toastLength:
                                      //                   Toast.LENGTH_SHORT,
                                      //               gravity:
                                      //                   ToastGravity.CENTER,
                                      //               timeInSecForIosWeb: 1,
                                      //               backgroundColor: Colors.red,
                                      //               textColor: Colors.white,
                                      //               fontSize: 16.0);
                                      //         } else {
                                      //           _controllerEmail.clear();
                                      //           _controllerPassword.clear();
                                      //         }
                                      //       }
                                      //     : () async {
                                      //         if (_controllerEmail
                                      //                 .text.isEmpty ||
                                      //             _controllerPassword
                                      //                 .text.isEmpty) return;
                                      //         InitialUser user = await _authService
                                      //             .registerWithEmailAndPassword(
                                      //                 _controllerEmail.text
                                      //                     .trim(),
                                      //                 _controllerPassword.text
                                      //                     .trim());

                                      //         print('Register');

                                      //         if (user == null) {
                                      //           Fluttertoast.showToast(
                                      //               msg: "Can`t Register",
                                      //               toastLength:
                                      //                   Toast.LENGTH_SHORT,
                                      //               gravity:
                                      //                   ToastGravity.CENTER,
                                      //               timeInSecForIosWeb: 1,
                                      //               backgroundColor: Colors.red,
                                      //               textColor: Colors.white,
                                      //               fontSize: 16.0);
                                      //         } else {
                                      //           _controllerEmail.clear();
                                      //           _controllerPassword.clear();
                                      //         }
                                      //       },
                                    ),
                                  )
                                ],
                              ),
                            ))));
              },
            );
          }).toList(),
        ),
        Container(
          decoration: BoxDecoration(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('asset/pre_1.png'),
          ),
        ),
      ],
    );
  }
}
