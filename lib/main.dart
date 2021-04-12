import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sn/services/auth.dart';
import 'package:sn/services/database.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(auth),
        ),
        Provider<DataBase>(
          create: (_) => DataBase(),
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges)
      ],
      child: MaterialApp(
        title: 'Social Network',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MyHomePage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => ProfileUser(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  TextEditingController _controllerName;
  TextEditingController _controllerSearcher;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String name = '';
  List allUsers = ['jhkj'];
  Map<String, dynamic> user = {'name': 'kalk;', 'id': 'ajkl'};

  setData(fbUser) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.snapshots().listen((snapshot) {
      snapshot.docs.forEach((element) {
        if (element.data()['id'].toString() == fbUser.uid.toString()) {
          this.setState(() {
            name = element.data()['username'].toString();
          });
        }
      });
    });
  }

  getAllUsers() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.snapshots().listen((snapshot) {
      this.setState(() {
        allUsers = snapshot.docs;
      });
    });
  }

  getFriend(outPutId) {
    print('1');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.snapshots().listen((snapshot) {
      snapshot.docs.forEach((element) {
        String el = element.data()['friends'].toString();
        print(el);
        // element.data()['friends'].map((id) {
        //   print('friend id: ' + id);
        //   if (outPutId != id) {
        //     //TODO: add update array friends
        //   }
        // });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerSearcher = TextEditingController();
  }

  Widget build(BuildContext context) {
    final fbUser = context.watch<User>();
    if (fbUser != null) {
      setData(fbUser);
      getAllUsers();
      return Scaffold(
        body: Container(
            child: _selectedIndex == 2
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Profile', style: TextStyle(fontSize: 30.0)),
                              SizedBox(
                                width: 80.0,
                                height: 40.0,
                                child: OutlinedButton(
                                    child: Text('Sign Out',
                                        style: TextStyle(fontSize: 12.0)),
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.indigo[500],
                                      shadowColor: Colors.indigo[700],
                                      elevation: 10,
                                    ),
                                    onPressed: () async {
                                      await context
                                          .read<AuthService>()
                                          .signOut();
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(name,
                                      style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('friends: 0',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text('followers: 0',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text('description',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _selectedIndex == 1
                    ? Column(
                        children: [
                          Center(
                            child: Text('messaging'),
                          )
                        ],
                      )
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              width: 300.0,
                              child: TextField(
                                controller: _controllerSearcher,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueGrey,
                                    border: UnderlineInputBorder(),
                                    hintText: 'Search friend'),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 1.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                height: 200.0,
                                child: new ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: allUsers.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return new OutlineButton(
                                        borderSide: BorderSide(
                                            width: 0.0, color: Colors.white),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/second',
                                              arguments: {
                                                'username': allUsers[index]
                                                        ['username']
                                                    .toString(),
                                                'id': allUsers[index]['id']
                                                    .toString(),
                                                'getFriend': getFriend
                                              });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.0, left: 10.0),
                                            height: 70,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 50.0,
                                                      width: 50.0,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      60.0),
                                                          color: Colors.purple),
                                                    ),
                                                    Text(allUsers[index]
                                                        ['username'])
                                                  ],
                                                ),
                                                SizedBox()
                                              ],
                                            )));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      );
    } else {
      return Scaffold(
          body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              height: 580.0,
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
                                    Column(
                                        children: (i == 2)
                                            ? [
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                TextField(
                                                  controller: _controllerName,
                                                  decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      hintText:
                                                          'Enter username'),
                                                )
                                              ]
                                            : []),
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
                                      height: 45.0,
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      height: 50.0,
                                      child: OutlinedButton(
                                          child: (i == 1)
                                              ? Text('Login',
                                                  style:
                                                      TextStyle(fontSize: 25.0))
                                              : Text('Register',
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                          style: OutlinedButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.indigo[500],
                                            shadowColor: Colors.indigo[700],
                                            elevation: 10,
                                          ),
                                          onPressed: i == 1
                                              ? () async {
                                                  await context
                                                      .read<AuthService>()
                                                      .signIn(
                                                          email:
                                                              _controllerEmail
                                                                  .text,
                                                          password:
                                                              _controllerPassword
                                                                  .text);
                                                }
                                              : () async {
                                                  await context
                                                      .read<AuthService>()
                                                      .signUp(
                                                          name: _controllerName
                                                              .text,
                                                          email:
                                                              _controllerEmail
                                                                  .text,
                                                          password:
                                                              _controllerPassword
                                                                  .text);
                                                }),
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
}

class ProfileUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null)
      return Scaffold(
          body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profile', style: TextStyle(fontSize: 30.0)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 1.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Column(
                    children: [
                      Text(arguments['username'],
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold)),
                      Text('friends: 0',
                          style: TextStyle(
                            fontSize: 20.0,
                          )),
                      Text('followers: 0',
                          style: TextStyle(
                            fontSize: 20.0,
                          )),
                      Text('description',
                          style: TextStyle(
                            fontSize: 20.0,
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 1.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 180.0,
                height: 60.0,
                child: OutlinedButton(
                    child: Text('Add friend', style: TextStyle(fontSize: 20.0)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.indigo[500],
                      shadowColor: Colors.indigo[700],
                      elevation: 5,
                    ),
                    onPressed: () {
                      arguments['getFriend'](arguments['id']);
                    }),
              ),
            ],
          ),
        ),
      ));
  }
}
