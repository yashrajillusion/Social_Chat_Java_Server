import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchingCapsule extends ConsumerStatefulWidget {
  const SwitchingCapsule({super.key});

  @override
  ConsumerState<SwitchingCapsule> createState() => _SwitchingCapsuleState();
}

class _SwitchingCapsuleState extends ConsumerState<SwitchingCapsule> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: const Color(0xFFDBE2EC)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                homeProviderRead.setIsMessgaes(true);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: homeProviderWatch.isMessages ? const Color(0xFF213241) : Colors.transparent,
                ),
                child: CommonAppText(
                  title: "Messages",
                  fontSize: 16,
                  titleColor: homeProviderWatch.isMessages ? const Color(0xFFF6FBFF) : const Color(0xFF213241),
                  titleTextAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(onboardingProvider).getAllUsers(context);

                homeProviderRead.setIsMessgaes(false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: !homeProviderWatch.isMessages ? const Color(0xFF213241) : Colors.transparent,
                ),
                child: CommonAppText(
                  title: "Contacts",
                  fontSize: 16,
                  titleColor: !homeProviderWatch.isMessages ? const Color(0xFFF6FBFF) : const Color(0xFF213241),
                  titleTextAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
