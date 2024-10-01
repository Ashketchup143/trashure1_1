import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:trashure1_1/screens/booking.dart';
import 'package:trashure1_1/screens/dashboard.dart';
import 'package:trashure1_1/screens/employeeprofile.dart';
import 'package:trashure1_1/screens/employees.dart';
import 'package:trashure1_1/screens/finance.dart';
import 'package:trashure1_1/screens/inventory.dart';
import 'package:trashure1_1/screens/login.dart';
import 'package:trashure1_1/screens/map.dart';
import 'package:trashure1_1/screens/settings.dart';
import 'package:trashure1_1/screens/userbusiness.dart';
import 'package:trashure1_1/screens/userhouse.dart';
import 'package:trashure1_1/screens/userinformation.dart';
import 'package:trashure1_1/screens/users.dart';
import 'package:trashure1_1/screens/vehicle.dart';
import 'package:trashure1_1/screens/vehicleinformation.dart';
import 'package:trashure1_1/user_model.dart'; // Import the UserModel
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb ? firebaseConfig : null,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(), // Provide UserModel globally
      child: MaterialApp(
        title: 'TRASHURE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login', // Set initial route to the login screen
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Login(),
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
          '/employeeprofile': (context) => EmployeeProfileScreen(),
          '/vehicleinformation': (context) => VehicleInformation(),
          '/userinformation': (context) => UserInformation(),
          '/map': (context) => Maps(),
        },
      ),
    );
  }
}
