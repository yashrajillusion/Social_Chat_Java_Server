import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:chat_app/ui/common/custom_loading/custom_loading.dart';
import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:chat_app/ui/screens/home_screens/home_chats_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginUserContainer extends StatefulWidget {
  const LoginUserContainer({super.key});

  @override
  State<LoginUserContainer> createState() => _LoginUserContainerState();
}

final _formKey = GlobalKey<FormState>();
String email = '';
String password = '';

class _LoginUserContainerState extends State<LoginUserContainer> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 36),
            InputTextField(
              textFormFieldKey: const ValueKey('email'),
              hintText: "Enter email",
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please Enter valid Email';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  email = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            InputTextField(
              textFormFieldKey: const ValueKey('password'),
              hintText: "Enter password",
              validator: (value) {
                if (value!.length < 6) {
                  return 'Please Enter Password of min length 6';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  password = value!;
                });
              },
            ),
            const SizedBox(height: 36),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  CustomLoading.progressDialog(isLoading: true, context: context);

                  // Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  Future.delayed(Duration(seconds: 2), () {
                    // Perform your task here after the delay
                    CustomLoading.progressDialog(isLoading: false, context: context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeChatsScreen()));
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF213241),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/images/next_icon.svg"),
                    const SizedBox(width: 8),
                    const CommonAppText(
                      title: "Register",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      titleColor: Color(0xFFFFFFFF),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 78),
            RichText(
              text: TextSpan(
                text: "You have  account? ",
                style: const TextStyle(color: Color(0xFF213241)),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: "LogIn",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 62),
          ],
        ));
  }
}
