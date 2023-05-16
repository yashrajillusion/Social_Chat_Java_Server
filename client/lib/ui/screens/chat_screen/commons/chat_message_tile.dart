import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatMessageTile extends StatefulWidget {
  final String message;
  final bool isSent;
  final String date;
  const ChatMessageTile({super.key, required this.message, required this.isSent, required this.date});

  @override
  State<ChatMessageTile> createState() => _ChatMessageTileState();
}

class _ChatMessageTileState extends State<ChatMessageTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: widget.isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (widget.isSent)
              Container(
                padding: const EdgeInsets.only(right: 6),
                child: SvgPicture.asset('assets/images/send_tick.svg'),
              ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF424F63),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CommonAppText(
                title: widget.message,
                fontSize: 14,
                titleColor: const Color(0xFFF6FBFF),
              ),
            )
          ],
        ),
        CommonAppText(
          title: widget.date,
          fontSize: 12,
          titleColor: const Color(0xFF8593A8),
        ),
      ],
    );
  }
}
