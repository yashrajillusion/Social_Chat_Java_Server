import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CommonAppText(
          title: "Chatx",
          fontSize: 20,
          titleColor: Color(0xFF213241),
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        SvgPicture.asset("assets/images/search_icon.svg"),
        const SizedBox(width: 16),
        SvgPicture.asset("assets/images/settings_icon.svg"),
      ],
    );
  }
}
