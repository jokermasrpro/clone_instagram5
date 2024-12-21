import 'package:clone_instagram/screens/auth_page/sign%20up/create_user.dart';
import 'package:clone_instagram/screens/auth_page/sign%20up/phone_and_email.dart';
import 'package:clone_instagram/shard/widgets/button_nav.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  bool isLoading = false;
  bool showPassword = true;
  bool emailChek = false;
  bool passChek = false;
  @override
  Widget build(BuildContext context) {
    Future<void> logIn() async {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);

        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ButtonNav()));
      } on FirebaseAuthException catch (error) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: ${error.message}")));
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An unexpected error occurred: $e")));
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 170,
              ),
              SvgPicture.asset(
                'assets/Svg/Instagram Logo.svg',
                height: 49,
              ),
              const SizedBox(
                height: 49,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: colorBackgroundInput,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      onChanged: (vale) {
                        setState(() {
                          vale.isEmpty ? emailChek = false : emailChek = true;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: colorHintInput),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: colorBorderInput, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(color: colorBorderInput, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colorBackgroundInput),
                    child: TextFormField(
                      focusNode: passFocusNode,
                      obscureText: showPassword,
                      controller: passController,
                      onChanged: (vale) {
                        setState(() {
                          vale.isEmpty ? passChek = false : passChek = true;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword
                                    ? showPassword = false
                                    : showPassword = true;
                              });
                            },
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(154, 255, 255, 255),
                            )),
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: colorHintInput),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: colorBorderInput, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: colorBorderInput, width: 1),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                        padding: null,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: colorBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: WidgetStatePropertyAll(
                            emailChek && passChek
                                ? colorBlue
                                : const Color.fromARGB(125, 55, 150, 239)),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (emailController.text.isEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(emailFocusNode);
                              } else if (passController.text.isEmpty) {
                                FocusScope.of(context)
                                    .requestFocus(passFocusNode);
                              } else {
                                FocusScope.of(context).unfocus();
                                logIn();
                              }
                            },
                      child: isLoading
                          ? Container(
                              padding: EdgeInsets.all(5),
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.black45,
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              "Log in",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: TextButton(
                        onPressed: () {},
                        child:
                            SvgPicture.asset('assets/Svg/Facebook Log in.svg')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      spacing: 10,
                      children: [
                        Container(
                          width: 175,
                          height: 1,
                          color: const Color.fromARGB(37, 255, 255, 255),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: colorBorderInput),
                        ),
                        Container(
                          width: 175,
                          height: 1,
                          color: const Color.fromARGB(37, 255, 255, 255),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(color: colorBorderInput, fontSize: 14),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignUpPage()));
                          },
                          child: Text(
                            'Sign Up.',
                            style: TextStyle(color: colorBlue, fontSize: 14),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
