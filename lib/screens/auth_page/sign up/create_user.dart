import 'package:clone_instagram/screens/auth_page/login_screen.dart';
import 'package:clone_instagram/screens/auth_page/sign%20up/create_password.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class CreateUser extends StatefulWidget {
  String? messageErorr;
  CreateUser({super.key, this.messageErorr});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final userController = TextEditingController();
  String signWith = 'email';
  final emailOrPhone = FocusNode();
  String? msgErorr;
  // Regular expression to validate email format
  void _validateEmail(String? email) {
    // Regular expression for basic email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email == null || email.isEmpty) {
      setState(() {
        msgErorr = 'Email is required';
      });
    } else if (!emailRegex.hasMatch(email)) {
      setState(() {
        msgErorr = 'Please enter a valid email address';
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreatePassword(email: userController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 30,
                  children: [
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
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff121212)),
                          child: TextFormField(
                            controller: userController,
                            focusNode: emailOrPhone,
                            keyboardType: signWith != "email"
                                ? TextInputType.numberWithOptions()
                                : TextInputType.emailAddress,
                            // ignore: unnecessary_null_comparison
                            style: TextStyle(
                                color: msgErorr == null
                                    ? Colors.white
                                    : const Color.fromARGB(255, 247, 18, 1)),
                            onChanged: (value) {
                              setState(() {
                                msgErorr = null;
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    userController.clear();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Color(0xffA8A8A8),
                                  )),
                              hintText: signWith != "email"
                                  ? "Mobile number"
                                  : "Email",
                              hintStyle: TextStyle(
                                  color: msgErorr == null
                                      ? Color(0xffA8A8A8)
                                      : const Color.fromARGB(255, 249, 18, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: msgErorr == null
                                      ? Color(0xff2F2F2F)
                                      : const Color.fromARGB(255, 254, 17, 0),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: msgErorr == null
                                      ? Color.fromARGB(255, 69, 69, 69)
                                      : const Color.fromARGB(255, 247, 18, 1),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: msgErorr == null ? false : true,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              msgErorr ?? '',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 21, 4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
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
                          _validateEmail(userController.text);
                        },
                        child:
                            //  porgressShow
                            //     ? CircularProgressIndicator(
                            //         color: Colors.white,
                            //         strokeAlign: 0,
                            //         strokeWidth: 3,
                            //       )

                            //     :

                            Text(
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
                            border:
                                Border.all(width: 2, color: Colors.blueGrey)),
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
                SizedBox(
                  height: 200,
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
      ),
    );
  }
}
