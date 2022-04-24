import 'package:authenticated_app/screens/home_screen.dart';
import 'package:authenticated_app/screens/sms_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

// read kardan data
Future<bool> isActive() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // mani ?? agar varable isActive null bud un ro pishfarz false kon
  return prefs.getBool('isActive') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS App',

      // FutureBuilder be Futurey goosh mide chon Future kari Zamanbar ast
      home: FutureBuilder(
        builder: (context, snapshot) {
          //agar data recive shode budan in kar ro bokon
          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            // ta zamani ke data hanuz amade nist SMS Screen ra barmigardanad
            return const SmsScreen();
          }
        },
      ),
    );
  }
}
