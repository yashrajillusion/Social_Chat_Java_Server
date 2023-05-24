import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class RegisterUserContainer extends ConsumerStatefulWidget {
  const RegisterUserContainer({super.key});

  @override
  ConsumerState<RegisterUserContainer> createState() => _RegisterUserContainerState();
}

final _formKey = GlobalKey<FormState>();
String email = '';
String firstName = '';
String password = '';

class _RegisterUserContainerState extends ConsumerState<RegisterUserContainer> {
  @override
  Widget build(BuildContext context) {
    final onboardingProviderRead = ref.read(onboardingProvider);
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
              hintText: "Enter name",
              onSaved: (value) {
                setState(() {
                  firstName = value!;
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
                  onboardingProviderRead.createAccount(
                    context: context,
                    firstName: firstName,
                    lastName: '',
                    phone: '',
                    email: email,
                    password: password,
                  );
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
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "You have account? ",
                style: const TextStyle(color: Color(0xFF213241)),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ref.read(onboardingProvider).setIsLogin(true);
                      },
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
