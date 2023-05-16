import 'package:chat_app/infrastructure/providers/provider_registration.dart';
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
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, i) {
                        return ChatHomeScreenTile(
                          name: "Kevin",
                          message: "Typing",
                          date: "yesterday",
                          count: "1",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                          },
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, i) {
                        return ChatHomeScreenTile(
                          name: "ram",
                          message: "Typing",
                          date: "today",
                          count: "9+",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
