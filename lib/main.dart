import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sn/domain/workout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Social network'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
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
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText: 'Enter email'),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextField(
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
                                      onPressed: () {
                                        print('Pressed');
                                      },
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
    ));
  }
}
