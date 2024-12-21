import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_picker/country_picker.dart';
import 'phone_screen.dart';




class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phoneController = TextEditingController();
  String phoneNumber = '';
  String countryCode = '+1'; // الكود الافتراضي للدولة (مثلًا الولايات المتحدة)
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // دالة لعرض قائمة الدول لاختيار الكود الدولي
  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
          countryCode = country.phoneCode; // تغيير الكود الدولي بناءً على الدولة المحددة
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(10.0),
        inputDecoration: InputDecoration(
          labelText: 'Search Country',
          hintText: 'Start typing to search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // دالة لتسجيل الرقم
  void _signUp() {
    // من هنا يمكنك إضافة منطق التسجيل باستخدام رقم الهاتف و الكود
    if (_phoneController.text.isNotEmpty) {
      // مثال: تسجيل الرقم الهاتف مع الكود الدولي
      print("Phone Number: $countryCode${_phoneController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up with Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الصفحة
            Text(
              'Create an account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // حقل اختيار الدولة
            Row(
              children: [
                GestureDetector(
                  onTap: _showCountryPicker,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.flag),
                        SizedBox(width: 8),
                        Text(
                          selectedCountry != null
                              ? selectedCountry!.name
                              : 'Select Country',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  countryCode,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            // حقل إدخال رقم الهاتف
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                phoneNumber = number.phoneNumber!;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              initialValue: PhoneNumber(isoCode: 'US'),
              textFieldController: _phoneController,
              formatInput: true,
              inputDecoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),

            // زر التسجيل
            Center(
              child: ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}