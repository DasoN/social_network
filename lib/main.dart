import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn/screens/isProfileLog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sn/services/auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
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
          create: (_) => AuthService(FirebaseAuth.instance),
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
        home: MyHomePage(),
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
  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  Widget build(BuildContext context) {
    final fbUser = context.watch<User>();

    if (fbUser != null) {
      return Text('Siged in');
    } else {
      return Scaffold(
          body: Column(
        children: [
          Text(
            'Social Network',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            controller: _controllerEmail,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Enter email'),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
              controller: _controllerPassword,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: 'Enter password'),
              obscureText: true),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: OutlinedButton(
              child: Text('Login',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo[500],
                shadowColor: Colors.indigo[700],
                elevation: 10,
              ),
              onPressed: () async {
                await context.read<AuthService>().signIn(
                    email: _controllerEmail.text,
                    password: _controllerPassword.text);
              },
            ),
          )
        ],
      ));
    }
  }
}
