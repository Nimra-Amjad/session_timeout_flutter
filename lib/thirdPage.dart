import 'package:flutter/material.dart';
import 'package:session_expire/firstPage.dart';
import 'package:session_expire/session/session.dart';

class ThirdPage extends StatelessWidget {
  Session session = Session();
  ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Third Page"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstPage(
                                session: session,
                              )));
                },
                child: const Text("Open first page"))
          ],
        ),
      ),
    );
  }
}
