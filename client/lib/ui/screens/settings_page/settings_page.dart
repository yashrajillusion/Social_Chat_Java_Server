import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2EDF5),
      // appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 80, bottom: 25, right: 22, left: 22),
            decoration: const BoxDecoration(
                color: Color(0xFF424F63),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: const CommonAppText(
              title: "Settings",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              titleColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 197, 220, 239),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(0, 88, 88, 195),
                  width: 2,
                  style: BorderStyle.solid,
                )),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF424F63),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: CommonAppText(
                      title: "P",
                      fontSize: 28,
                      lineHeight: 0,
                      titleColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CommonAppText(
                      title: "Pranav Dalvi",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    CommonAppText(
                      title: "pranavalvi9@gmail.com",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      titleColor: Color(0xFF191919),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          SettingsTile(title: "Edit Profile", icon: 'assets/images/edit_icon.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(title: "Blocked users", icon: 'assets/images/block_user.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(title: "Delete account", icon: 'assets/images/delete_icon.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(title: "Privacy policy", icon: 'assets/images/privacy_policy.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(title: "Terms & condition", icon: 'assets/images/terms_condition.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(title: "Logout", icon: 'assets/images/logout_icon.svg', onTap: () {}),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const SettingsTile({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 8),
            CommonAppText(
              title: title,
              fontSize: 16,
            ),
            const Spacer(),
            SvgPicture.asset('assets/images/setting__next_icon.svg'),
          ],
        ),
      ),
    );
  }
}
