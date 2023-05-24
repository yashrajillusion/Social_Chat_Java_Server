import 'dart:convert';
import 'package:chat_app/infrastructure/models/response/get_all_users_by_id_response_modal.dart';
import 'package:chat_app/infrastructure/providers/provider_registration.dart';
import 'package:chat_app/infrastructure/sharedprefs/sharedprefs.dart';
import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_message_tile.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:web_socket_channel/io.dart';

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
// IOWebSocketChannel channel = IOWebSocketChannel.connect("wss://live-location-tracking-backend.onrender.com/");

class _ChatScreenState extends ConsumerState<ChatScreen> {
  IO.Socket? socket;
  @override
  // void dispose() {
  //   channel.sink.close();
  //   super.dispose();
  // }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      connect();
      getShare();
    });
    super.initState();
  }

  void connect() {
    socket = IO.io('https://live-location-tracking-backend.onrender.com', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.onConnect((data) => {
          socket?.on("RECEIVED_MESSAGE", (data) {
            print("onconnect");
            print(data);
          }), // event name
        });
    print(socket?.connected);
    socket?.emit("JOIN_ROOM", widget.chatid); // 2par id
  }

  void sendMessage(data) {
    socket?.emit("SEND_MESSAGE", data); //event name ,object
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
                child: Row(
                  children: [
                    InputTextField(
                      width: MediaQuery.of(context).size.width - 110,
                      controller: sendMessageController,
                      hintText: "Type here...",
                      onFieldSubmitted: (newValue) async {
                        var data = await onboardingProviderRead.sentMessage(
                          context: context,
                          senderId: userIdd,
                          chatId: widget.chatid,
                          message: sendMessageController.text,
                        );
                        data["members"] = jsonEncode(widget.members);
                        sendMessage(data);
                        sendMessageController.clear();
                      },
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        var data = await onboardingProviderRead.sentMessage(
                          context: context,
                          senderId: userIdd,
                          chatId: widget.chatid,
                          message: sendMessageController.text,
                        );
                        data["members"] = jsonEncode(widget.members);
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
