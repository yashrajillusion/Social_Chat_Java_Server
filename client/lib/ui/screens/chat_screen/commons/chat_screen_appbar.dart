import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:chat_app/ui/screens/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreenAppbar extends StatefulWidget {
  final String title;
  final String subTitle;
  final String avatarName;
  const ChatScreenAppbar({super.key, required this.title, required this.subTitle, required this.avatarName});

  @override
  State<ChatScreenAppbar> createState() => _ChatScreenAppbarState();
}

class _ChatScreenAppbarState extends State<ChatScreenAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('assets/images/back_icon.svg'),
            )),
        const SizedBox(width: 10),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF424F63),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: CommonAppText(
              title: widget.avatarName,
              fontSize: 20,
              lineHeight: 0,
              titleColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAppText(
              title: widget.title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset('assets/images/menu_icon.svg'),
          ),
        ),
      ],
    );
  }
}
