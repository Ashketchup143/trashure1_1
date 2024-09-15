import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyCEyCfsNSldvuqYszhxIGsVqJvqLfdHD0Y",
    authDomain: "thesis-5212b.firebaseapp.com",
    projectId: "thesis-5212b",
    storageBucket: "thesis-5212b.appspot.com",
    messagingSenderId: "75792807749",
    appId: "1:75792807749:web:6d301a27869d6cdd07f02c",
    measurementId: "G-1F6X7DDHTN");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb ? firebaseConfig : null,
  );
  runApp(MyApp());
}
