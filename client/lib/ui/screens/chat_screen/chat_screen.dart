import 'package:chat_app/infrastructure/models/response/get_all_users_by_id_response_modal.dart';
import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_message_tile.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends ConsumerStatefulWidget {
  final List<MembersOfChats> members;
  final String chatid;
  final String title;
  final String subTitle;
  final String avatarName;
  const ChatScreen(
      {super.key,
      required this.members,
      required this.chatid,
      required this.title,
      required this.subTitle,
      required this.avatarName});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController sendMessageController = TextEditingController();

class _ChatScreenState extends ConsumerState<ChatScreen> {
  IO.Socket? socket;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      connect();
    });
    scrollDown();
    super.initState();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(onboardingProvider).controller.jumpTo(ref.read(onboardingProvider).controller.position.maxScrollExtent);
    });
  }

  void connect() {
    socket = IO.io('https://live-location-tracking-backend.onrender.com', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.onConnect((data) => {
          socket?.on("RECEIVED_MESSAGE", (data) {
            ref.read(onboardingProvider).addMessagesFromSocket(data);
          }), // event name
        });

    socket?.emit("JOIN_ROOM", ref.watch(onboardingProvider).personalChatId); // 2par id
  }

  void sendMessage(data) {
    socket?.emit("SEND_MESSAGE", data); //event name ,object
  }

  @override
  Widget build(BuildContext context) {
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
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              top: 0,
              child: ListView.builder(
                controller: ref.watch(onboardingProvider).controller,
                itemCount: onboardingProviderWatch.allMessagesById?.length ?? 0,
                itemBuilder: (context, index) {
                  var data = onboardingProviderWatch.allMessagesById?[index];
                  return Container(
                    margin: onboardingProviderWatch.allMessagesById!.length - 1 == index
                        ? const EdgeInsets.only(bottom: 0)
                        : EdgeInsets.zero,
                    child: ChatMessageTile(
                      message: data?.message ?? '',
                      isSent: data?.sender?.id == ref.watch(onboardingProvider).personalChatId,
                      date: DateFormat('h:mm a').format(DateTime.parse(data?.createdAt ?? '')),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                color: const Color(0xFFE2EDF5),
                child: Row(
                  children: [
                    InputTextField(
                      width: MediaQuery.of(context).size.width - 110,
                      controller: sendMessageController,
                      hintText: "Type here...",
                      onFieldSubmitted: (newValue) async {
                        var data = await onboardingProviderRead.sentMessage(
                          context: context,
                          senderId: ref.watch(onboardingProvider).personalChatId,
                          chatId: widget.chatid,
                          message: sendMessageController.text,
                        );
                        data["members"] = widget.members;
                        sendMessage(data);
                        sendMessageController.clear();
                      },
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        var data = await onboardingProviderRead.sentMessage(
                          context: context,
                          senderId: ref.watch(onboardingProvider).personalChatId,
                          chatId: widget.chatid,
                          message: sendMessageController.text,
                        );
                        data["members"] = widget.members;
                        sendMessage(data);
                        sendMessageController.clear();
                      },
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color.fromARGB(0, 6, 6, 255),
                        ),
                        child: SvgPicture.asset('assets/images/send_icon.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
