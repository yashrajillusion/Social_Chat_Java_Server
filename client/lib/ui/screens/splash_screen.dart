import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/infrastructure/sharedprefs/sharedprefs.dart';
import 'package:chat_app/ui/screens/home_screens/home_chats_screen.dart';
import 'package:chat_app/ui/screens/onboarding_screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getShare();
    });
    super.initState();
  }

  getShare() async {
    var temp = await SharedPrefs.getChatId() ?? '';
    if (temp.isNotEmpty) {
      ref.read(onboardingProvider).setPersonalChatId(temp);
      ref.read(onboardingProvider).setChatId(temp);
      ref.read(onboardingProvider).getAllUsersById(temp);
      ref.read(onboardingProvider).getAllUsers(context);
      setState(() {
        isLogin = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeChatsScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 104, 104, 104),
      child: OverflowBox(
        minHeight: 200,
        maxHeight: 200,
        child: Lottie.asset(
          'assets/animation/bubleChatlotie.json',
          repeat: true,
        ),
      ),
    ));
  }
}
