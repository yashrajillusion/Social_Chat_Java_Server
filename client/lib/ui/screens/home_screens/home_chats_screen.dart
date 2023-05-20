import 'dart:developer';
import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:chat_app/ui/screens/chat_screen/chat_screen.dart';
import 'package:chat_app/ui/screens/home_screens/common/chat_homescreen_tile.dart';
import 'package:chat_app/ui/screens/home_screens/common/home_appbar.dart';
import 'package:chat_app/ui/screens/home_screens/common/switching_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeChatsScreen extends ConsumerStatefulWidget {
  const HomeChatsScreen({super.key});

  @override
  ConsumerState<HomeChatsScreen> createState() => _HomeChatsScreenState();
}

class _HomeChatsScreenState extends ConsumerState<HomeChatsScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final onBoardingProviderWatch = ref.watch(onboardingProvider);
    inspect(onBoardingProviderWatch.allUsersbyIdDataList);
    return Scaffold(
      backgroundColor: const Color(0xFFE2EDF5),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 64),
            const HomeAppbar(),
            const SizedBox(height: 30),
            const SwitchingCapsule(),
            const SizedBox(height: 28),
            if (onBoardingProviderWatch.allUsersbyIdDataList.isNotEmpty)
              homeProviderWatch.isMessages
                  ? Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: onBoardingProviderWatch.allUsersbyIdDataList?.length,
                        itemBuilder: (context, i) {
                          var data = onBoardingProviderWatch.allUsersbyIdDataList?[i];
                          return ChatHomeScreenTile(
                            firstCharAvatar: data?.chatName?[0].toUpperCase() ?? '',
                            name: data?.chatName ?? '',
                            message: data?.lastMessage?.message ?? '',
                            date: "",
                            count: "",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                            },
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: onBoardingProviderWatch.allUsersDataList!.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: onBoardingProviderWatch.allUsersDataList?.length,
                              itemBuilder: (context, i) {
                                var data = onBoardingProviderWatch.allUsersDataList?[i];
                                return ChatHomeScreenTile(
                                  firstCharAvatar: data?.firstName?[0].toUpperCase() ?? '',
                                  name: '${data?.firstName} ${data?.firstName}',
                                  message: data?.email ?? '',
                                  date: "",
                                  count: "",
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                                  },
                                );
                              },
                            )
                          : Container(
                              child: CommonAppText(
                                title: "No Contacts Found",
                                fontSize: 22,
                              ),
                            ),
                    )
            // : Container(
            //     child: CommonAppText(
            //       title: "No Users Found",
            //       fontSize: 22,
            //       titleColor: Colors.black,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
