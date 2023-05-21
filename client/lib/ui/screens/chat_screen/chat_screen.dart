import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/infrastructure/sharedprefs/sharedprefs.dart';
import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_message_tile.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatid;
  final String title;
  final String subTitle;
  final String avatarName;
  const ChatScreen({super.key, required this.chatid, required this.title, required this.subTitle, required this.avatarName});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController sendMessageController = TextEditingController();

class _ChatScreenState extends ConsumerState<ChatScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getShare();
    });
    super.initState();
  }

  getShare() async {
    var temp = await SharedPrefs.getChatId() ?? '';
    setState(() {
      userIdd = temp;
    });
  }

  String userIdd = "";
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final onboardingProviderWatch = ref.watch(onboardingProvider);
    final onboardingProviderRead = ref.read(onboardingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE2EDF5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE2EDF5),
        elevation: 0,
        title: ChatScreenAppbar(
          avatarName: widget.avatarName,
          subTitle: widget.subTitle,
          title: widget.title,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: onboardingProviderWatch.allMessagesById?.length,
              itemBuilder: (context, index) {
                var data = onboardingProviderWatch.allMessagesById?[index];
                return Container(
                  margin: onboardingProviderWatch.allMessagesById!.length - 1 == index
                      ? const EdgeInsets.only(bottom: 50)
                      : EdgeInsets.zero,
                  child: ChatMessageTile(
                    message: data?.message ?? '',
                    isSent: data?.sender?.id == userIdd,
                    date: DateFormat('h:mm a').format(DateTime.parse(data?.createdAt ?? '')),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                color: const Color(0xFFE2EDF5),
                child: InputTextField(
                  controller: sendMessageController,
                  hintText: "Type here...",
                  onFieldSubmitted: (newValue) {
                    sendMessageController.clear();
                    onboardingProviderRead.sentMessage(
                      context: context,
                      senderId: userIdd,
                      chatId: widget.chatid,
                      message: newValue,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
