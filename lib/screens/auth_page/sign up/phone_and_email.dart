import 'package:clone_instagram/screens/auth_page/login_screen.dart';
import 'package:clone_instagram/screens/auth_page/sign%20up/create_password.dart';
import 'package:clone_instagram/screens/auth_page/sign%20up/create_user.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  // المتغير الخاص بالـ TabController
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // تهيئة TabController
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 7, left: 30),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/Svg/Shape.svg',
              width: 25,
              height: 25,
              // fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: TabBar(
              dividerColor: Color(0xffA8A8A8),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Color(0xffA8A8A8),
              padding: EdgeInsets.symmetric(horizontal: 20),
              // indicatorWeight: 5,
              // dividerHeight: ,
              // indicatorWeight: 50,

              controller: _tabController,
              tabs: [
                Tab(
                  // text: 'Telephone',
                  // height: 100,
                  child: Text(
                    "             PHONE             ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    "             EMAIL             ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // شاشة التسجيل
                SignUpPage(),
                // شاشة تسجيل الدخول
                SignUpForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 30,
                children: [
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
                              icon: SvgPicture.asset(
                                'assets/Svg/iconClose.svg',
                                width: 20,
                              ),
                            ),
                            hintText:
                                signWith != "email" ? "Mobile number" : "Email",
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
    );
  }
}

class LogInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // تنفيذ تسجيل الدخول هنا
            },
            child: Text('Log In'),
          ),
        ],
      ),
    );
  }
}
