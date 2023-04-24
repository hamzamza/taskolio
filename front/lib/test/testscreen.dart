import 'package:flutter/material.dart';
import 'package:front/test/testController.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test Screen"),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                runtest();
              },
              child: const Text("run test "),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("create user "),
            ),
          ],
        )));
  }
}
