import 'package:clone_instagram/screens/auth_page/login_screen.dart';
import 'package:clone_instagram/shard/widgets/button_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String goTo;
  SplashScreen({super.key, required this.goTo});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              widget.goTo == 'home' ? ButtonNav() : LoginScreen(),
        ),
      );
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              Image.asset(
                'assets/logo.png',
                width: 107,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/foot.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
