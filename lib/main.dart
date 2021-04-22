import 'dart:html';

import 'package:check_in_system/AdminPage/dashboard/admin_dashboard.dart';
import 'package:check_in_system/AdminPage/login/admin_login.dart';
import 'package:check_in_system/demo2.dart';
import 'package:check_in_system/userpage/checkdin.dart';
import 'package:check_in_system/userpage/feedback_page.dart';
import 'package:check_in_system/userpage/userpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'AdminPage/dashboard/customer_visits.dart';
import 'AdminPage/login/admin_register.dart';
import 'demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // print(Uri.base);
    // var url = window.location.href;
    // print('url $url');
    // print(url.split('#').last);
    return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Check in System',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
            initialRoute:  'adminLogin',
            routes:  {
              '/' : (context ) => UserPage(),
              'Dropin' : (context ) => UserPage(),
              'Dropin_castle' : (context ) => UserPage(),
              'admin' : (context) => QrGenerator(),
              // '$route' : (context) => QrGenerator(),
              'dashboard' : (context) => AdminDashboard(),
              'demo2' : (context) => SidebarPage(),
              'CustomerVisits' : (context) => CustomerVisits(),
              'fbpage' : (context) => FeedbackPage(),
              'adminRegister' : (context) =>  AdminRegisterPage(),
              'adminLogin' : (context) =>  AdminLoginPage(),


            },
        );
      }
  }

