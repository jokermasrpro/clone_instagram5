import 'package:clone_instagram/screens/auth_page/login_screen.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  String? _verificationId;
  final userController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool porgressShow = false;
  String signWith = 'Mobile Number';
  final emailOrPhone = FocusNode();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 30,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 40, left: 10),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'assets/Svg/Shape.svg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.none,
                          ))),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: signWith != "email"
                                ? "What`s your mobile\n number?"
                                : "What`s your email?\n",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28)),
                        TextSpan(
                            text: signWith != "email"
                                ? "\nEnter the mobile number where you can be contacted. No one will see this on your profile."
                                : "Enter the email where you can be contacted\n No one will see this on your profile.",
                            style: TextStyle(fontSize: 16))
                      ])),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff121212)),
                        child: TextFormField(
                          controller: userController,
                          focusNode: emailOrPhone,
                          keyboardType: signWith != "email"
                              ? TextInputType.numberWithOptions()
                              : TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  userController.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Color(0xffA8A8A8),
                                )),
                            hintText:
                                signWith != "email" ? "Mobile number" : "Email",
                            hintStyle: TextStyle(color: Color(0xffA8A8A8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xff2F2F2F),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 69, 69, 69),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: WidgetStatePropertyAll(colorBlue),
                      ),
                      onPressed: () {
                        setState(() {
                          porgressShow = true;
                        });
                       
                      },
                      child: porgressShow
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeAlign: 0,
                              strokeWidth: 3,
                            )
                          : Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        signWith != "email"
                            ? signWith = 'email'
                            : signWith = "mobile";
                      });
                      FocusScope.of(context).unfocus();
                      // FocusScope.of(context).requestFocus(emailOrPhone);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.blueGrey)),
                      child: Text(
                        signWith != "email"
                            ? "Sign up with email"
                            : "Sign Up with mobile number",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "I alrady have an account",
                    style: TextStyle(
                        color: colorBlue, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
