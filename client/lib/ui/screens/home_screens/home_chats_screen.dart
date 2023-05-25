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
            homeProviderWatch.isMessages
                ? Expanded(
                    child: onBoardingProviderWatch.allUsersbyIdDataList.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: onBoardingProviderWatch.allUsersbyIdDataList.length,
                            itemBuilder: (context, i) {
                              var data = onBoardingProviderWatch.allUsersbyIdDataList[i];
                              return ChatHomeScreenTile(
                                firstCharAvatar: data.isGroupChat!
                                    ? data.chatName![0]
                                    : data.members?[0].id == ref.watch(onboardingProvider).chatId
                                        ? '${data.members?[1].firstName?[0].toUpperCase()}'
                                        : data.members?[0].firstName?[0].toUpperCase() ?? '',
                                name: data.isGroupChat!
                                    ? data.chatName ?? ""
                                    : data.members?[0].id == ref.watch(onboardingProvider).chatId
                                        ? '${data.members?[1].firstName} ${data.members?[1].lastName}'
                                        : '${data.members?[0].firstName} ${data.members?[0].lastName}',
                                message: data.lastMessage?.message ?? '',
                                date: "",
                                count: "",
                                onTap: () {
                                  ref.read(onboardingProvider).getAllUsersChatsById(data.id ?? '');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                chatid: data.id ?? '',
                                                avatarName: data.isGroupChat!
                                                    ? data.chatName![0]
                                                    : data.members?[0].id == ref.watch(onboardingProvider).chatId
                                                        ? '${data.members?[1].firstName?[0].toUpperCase()}'
                                                        : '${data.members?[0].firstName?[0].toUpperCase()} ',
                                                subTitle: '',
                                                title: data.isGroupChat!
                                                    ? data.chatName ?? ""
                                                    : data.members?[0].id == ref.watch(onboardingProvider).chatId
                                                        ? '${data.members?[1].firstName} ${data.members?[1].lastName}'
                                                        : '${data.members?[0].firstName} ${data.members?[0].lastName}',
                                                members: data.members ?? [],
                                              )));
                                },
                              );
                            },
                          )
                        : const CommonAppText(
                            title: "No Messages Found",
                            fontSize: 22,
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
                                name: '${data?.firstName} ${data?.lastName}',
                                message: data?.email ?? '',
                                date: "",
                                count: "",
                                onTap: () async {
                                  var chatIdd = await ref.read(onboardingProvider).createChat(memberId1: data?.id ?? '');
                                  await ref.read(onboardingProvider).getAllUsersChatsById(data?.id ?? '');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                chatid: chatIdd ?? '',
                                                avatarName: data?.firstName?[0].toUpperCase() ?? '',
                                                subTitle: '',
                                                title: '${data?.firstName} ${data?.lastName}',
                                                members: const [],
                                              )));
                                },
                              );
                            },
                          )
                        : const CommonAppText(
                            title: "No Contacts Found",
                            fontSize: 22,
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
