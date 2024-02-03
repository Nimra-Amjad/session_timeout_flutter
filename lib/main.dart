import 'dart:async';

import 'package:flutter/material.dart';
import 'package:session_expire/firstPage.dart';
import 'package:session_expire/session/session.dart';
import 'package:session_expire/session/session_manager.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Session session = Session();
  StreamController streamController = StreamController();
  MyApp({super.key});

  void redirectToFirstPage() {
    if (globalNavigatorKey.currentContext != null) {
      Navigator.pop(globalNavigatorKey.currentContext!);
      Navigator.push(
          globalNavigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => FirstPage(
                    session: session,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (globalNavigatorKey.currentContext != null) {
      session.stratListener(
          streamController: streamController,
          context: globalNavigatorKey.currentContext!);
    }
    return SessionManager(
      onSessionExpired: () {
        if (globalNavigatorKey.currentContext != null &&
            session.enableLoginPage == true) {
          print("session expired");
          ScaffoldMessenger.of(globalNavigatorKey.currentContext!)
              .showSnackBar(SnackBar(
                  content: Container(
            color: Colors.black,
            child: Text(
              "Session Expired",
              style: TextStyle(color: Colors.black),
            ),
          )));
          redirectToFirstPage();
        }
      },
      duration: Duration(seconds: 10),
      streamController: streamController,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: globalNavigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirstPage(
          session: session,
        ),
      ),
    );
  }
}
