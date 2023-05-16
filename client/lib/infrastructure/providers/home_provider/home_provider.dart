import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<HomeProvider> ref;
  HomeProvider(this.ref);
  bool isMessages = true;

  setIsMessgaes(bool value) {
    isMessages = value;
    notifyListeners();
  }
}
