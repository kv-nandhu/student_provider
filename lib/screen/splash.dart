// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:studnet_provider/screen/home.dart';
import 'package:studnet_provider/widget/color.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotohome(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text.rich(
              TextSpan(
                text: 'FLUTTER',
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 142, 221),
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ₿OX',
                    style: TextStyle(
                    color: CustomColor.getColor(),
                      fontWeight: FontWeight.normal,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'F L U T T E R    D E V E L O P E R',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 233, 227, 227),
              ),
            ),
            // Image.asset(
            //   'images/flutter.png',
            //   width: 300,
            //   height: 300,
            // ),
            SizedBox(height: 20),
            Image.asset(
              'images/loading.gif',
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotohome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}
