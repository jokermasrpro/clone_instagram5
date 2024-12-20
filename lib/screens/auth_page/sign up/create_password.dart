import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final userController = TextEditingController();
  bool isChecked = false;
  bool passwordShow = true;

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
                            color: Color(0xff2F2F2F),
                            width: 1,
                          ),
                        ),
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
                        Text("Show Password?")
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
