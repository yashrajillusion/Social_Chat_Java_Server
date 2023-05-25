import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';

class ChatHomeScreenTile extends StatefulWidget {
  final String name;
  final String message;
  final String date;
  final String count;
  final String firstCharAvatar;
  final VoidCallback onTap;
  const ChatHomeScreenTile(
      {super.key,
      required this.name,
      required this.message,
      required this.date,
      required this.count,
      required this.onTap,
      required this.firstCharAvatar});

  @override
  State<ChatHomeScreenTile> createState() => _ChatHomeScreenTileState();
}

class _ChatHomeScreenTileState extends State<ChatHomeScreenTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF213241),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: CommonAppText(
                  title: widget.firstCharAvatar,
                  fontSize: 20,
                  lineHeight: 0,
                  titleColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppText(
                  title: widget.name.toUpperCase(),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  titleColor: const Color(0xFF213241),
                ),
                CommonAppText(
                  title: widget.message,
                  fontSize: 16,
                  titleColor: const Color(0xFF8593A8),
                  titleTextAlign: TextAlign.start,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonAppText(
                  title: widget.date,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  titleColor: const Color(0xFF8593A8),
                ),
                const SizedBox(height: 4),
                if (widget.count.isNotEmpty)
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0573F3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CommonAppText(
                      titleTextAlign: TextAlign.center,
                      title: widget.count,
                      fontSize: 12,
                      titleColor: const Color(0xFFF6FBFF),
                    ),
                  ),
              ],
            )
            // Column(
            //   children: [
            //     Row(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         CommonAppText(
            //           title: "kevin.thg",
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //           titleColor: Color(0xFF213241),
            //         ),
            //         CommonAppText(
            //           title: "kevin.thg",
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           titleColor: Color(0xFF8593A8),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         CommonAppText(
            //           title: "kevin.thg",
            //           fontSize: 16,
            //           titleColor: Color(0xFF8593A8),
            //           titleTextAlign: TextAlign.start,
            //         ),
            //         Container(
            //           height: 20,
            //           width: 20,
            //           decoration: BoxDecoration(
            //             color: Color(0xFF0573F3),
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: CommonAppText(
            //             titleTextAlign: TextAlign.center,
            //             title: "3",
            //             fontSize: 12,
            //             titleColor: Color(0xFFF6FBFF),
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
