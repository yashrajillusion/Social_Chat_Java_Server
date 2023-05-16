import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/screens/onboarding_screens/common/login_user_container.dart';
import 'package:chat_app/ui/screens/onboarding_screens/common/register_user_container.dart';
import 'package:chat_app/ui/screens/onboarding_screens/common/onboarding_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final onboardingProviderWatch = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE2EDF5),
      // appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            const OnboardingTabbar(),
            onboardingProviderWatch.isLogin ? const LoginUserContainer() : const RegisterUserContainer(),
          ],
        ),
      ),
    );
  }
}
