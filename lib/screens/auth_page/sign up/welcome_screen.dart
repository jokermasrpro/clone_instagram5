import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 40, left: 10),
                child: SvgPicture.asset('assets/Svg/Shape.svg'),
              ),
              Column(
                spacing: 30,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "welcome to Instagram\n You're welcome, newuser\n",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28)),
                        TextSpan(
                            text:
                                "\n email address and phone number on mainuser We will add it to newuser. Contact information andYou can change your username whenever you want.")
                      ])),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            backgroundColor: WidgetStatePropertyAll(colorBlue),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add New Phone or Email",
                            style: TextStyle(
                                color: Color(0xff0098FE),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
              Text(
                textAlign: TextAlign.center,
                "We will add the private information from the mainuser account to the newuser. See Terms and Privacy Policy.",
                style: TextStyle(color: Color(0xff8E8E8E)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
