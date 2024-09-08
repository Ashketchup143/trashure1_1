import 'package:flutter/material.dart';
import 'package:trashure1_1/screens/booking.dart';
import 'package:trashure1_1/screens/dashboard.dart';
import 'package:trashure1_1/screens/employees.dart';
import 'package:trashure1_1/screens/finance.dart';
import 'package:trashure1_1/screens/inventory.dart';
import 'package:trashure1_1/screens/login.dart';
import 'package:trashure1_1/screens/settings.dart';
import 'package:trashure1_1/screens/userbusiness.dart';
import 'package:trashure1_1/screens/userhouse.dart';
import 'package:trashure1_1/screens/users.dart';
import 'package:trashure1_1/screens/vehicle.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: kIsWeb ? firebaseConfig : null,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRASHURE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Users(),
        '/login': (context) => Login(),
        '/dashboard': (context) => Dashboard(),
        '/users': (context) => Users(),
        '/bookings': (context) => Booking(),
        '/vehicle': (context) => Vehicle(),
        '/employee': (context) => Employees(),
        '/inventory': (context) => Inventory(),
        '/finance': (context) => Finance(),
        '/settings': (context) => Settings(),
        '/userhouse': (context) => UserHouse(),
        '/userbusiness': (context) => UserBusiness(),
      },
    );
  }
}
