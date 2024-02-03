import 'package:flutter/material.dart';
import 'package:session_expire/secondPage.dart';
import 'package:session_expire/session/session.dart';

class FirstPage extends StatelessWidget {
  final Session session;
  const FirstPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("First Page"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  session.enableLoginPage = true;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
                child: const Text("Open second page"))
          ],
        ),
      ),
    );
  }
}
