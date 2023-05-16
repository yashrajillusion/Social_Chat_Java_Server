import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingTabbar extends ConsumerStatefulWidget {
  const OnboardingTabbar({super.key});

  @override
  ConsumerState<OnboardingTabbar> createState() => _OnboardingTabbarState();
}

class _OnboardingTabbarState extends ConsumerState<OnboardingTabbar> {
  @override
  Widget build(BuildContext context) {
    final onboardingProviderWatch = ref.watch(onboardingProvider);
    final onboardingProviderRead = ref.read(onboardingProvider);

    return Row(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              onboardingProviderRead.setIsLogin(true);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: onboardingProviderWatch.isLogin ? Colors.black : Colors.transparent,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/login_icon.svg'),
                  // Image.asset(
                  //   'assets/images/register_icon.png',
                  //   width: 22,
                  //   height: 22,
                  // ),
                  const SizedBox(width: 8),

                  const CommonAppText(
                    title: "Login",
                    fontSize: 16,
                    titleTextAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onboardingProviderRead.setIsLogin(false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: !onboardingProviderWatch.isLogin ? Colors.black : Colors.transparent,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/register_icon.png',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 8),
                  // SvgPicture.asset('assets/images/register_icon.svg'),
                  const CommonAppText(
                    title: "Register",
                    fontSize: 16,
                    titleTextAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
