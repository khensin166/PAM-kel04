import 'package:cis_kel04_app/constants/constants.dart';
import 'package:cis_kel04_app/views/baak/pages/login.dart';
import 'package:cis_kel04_app/views/mahasiswa/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Welcome to Cis application',
              style: heading1,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(TextSpan(
                    text: 'admin',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(BaakLogin());
                      })),
                const SizedBox(
                  width: 10,
                ),
                const Text('or'),
                const SizedBox(
                  width: 10,
                ),
                Text.rich(TextSpan(
                    text: 'mahasiswa',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(MhsLogin());
                      })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
