import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<OnboardingProvider> ref;
  OnboardingProvider(this.ref);

  bool isLogin = true;

  setIsLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }
}
