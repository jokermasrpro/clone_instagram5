import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'create_user.dart';

class CreatePassword extends StatefulWidget {
  String email;
  CreatePassword({super.key, required this.email});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final userController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isChecked = false;
  bool passwordShow = true;
  String? validPassowrd;

  void checkPassword(value) {
    RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*\d).{8,}$');
    if (value == null || value.isEmpty) {
      setState(() {
        validPassowrd = 'Please enter a password !!';
      });
    } else if (value.length < 8) {
      setState(() {
        validPassowrd = 'Password must be at least 8 characters !!';
      });
    } else if (!regex.hasMatch(value)) {
      setState(() {
        validPassowrd = 'Password must contain letters, numbers and symbols !!';
      });
    } else {
      setState(() {
        validPassowrd = null;
      });
      sginUpEmail();
    }
  }

  Future<void> sginUpEmail() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: widget.email, password: userController.text);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            alignment: Alignment.center,
            actions: [
              Column(
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Text(
                      "Your Email: ${widget.email} \n Your Password: ${userController.text}",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Text("${e.code}"),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CreateUser()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Container(
              child: Text("${e.code}"),
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: Text('$e'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            spacing: 30,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 40, left: 10),
                  child: SvgPicture.asset('assets/Svg/Shape.svg')),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Create Password\n",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28)),
                    TextSpan(
                        text:
                            "\n iCloud® so we can remember your password You won't need to log in on your devices.")
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff121212),
                    ),
                    child: TextFormField(
                      controller: userController,
                      obscureText: passwordShow,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: validPassowrd == null
                              ? Color(0xffA8A8A8)
                              : const Color.fromARGB(255, 248, 18, 1),
                        ),
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
                            color: validPassowrd == null
                                ? Color(0xff2F2F2F)
                                : const Color.fromARGB(255, 248, 18, 1),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: validPassowrd == null ? false : true,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$validPassowrd',
                        style: TextStyle(
                            color: Color(0xffff0000),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    // alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        InkWell(
                          // onTap: (){
                          //   setState(() {

                          //   });
                          // },
                          child: Checkbox(
                              activeColor: colorBlue,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  passwordShow = value == true
                                      ? passwordShow = false
                                      : passwordShow = true;
                                  isChecked = value ?? false;
                                });
                              }),
                        ),
                        Text(
                          "Show Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 69, 69),
                          ),
                        )
                      ],
                    ),
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
                        checkPassword(userController.text);
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
