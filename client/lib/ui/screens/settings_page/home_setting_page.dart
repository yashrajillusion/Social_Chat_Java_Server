import 'package:chat_app/infrastructure/sharedprefs/sharedprefs.dart';
import 'package:chat_app/ui/common/common_app_text/common_app_text.dart';
import 'package:chat_app/ui/screens/settings_page/settings_page.dart';
import 'package:chat_app/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class HomeSettingPage extends StatefulWidget {
  const HomeSettingPage({super.key});

  @override
  State<HomeSettingPage> createState() => _HomeSettingPageState();
}

class _HomeSettingPageState extends State<HomeSettingPage> {
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
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CommonAppText(
                      title: "Aman Singh",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    CommonAppText(
                      title: "Aman Singh",
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
          // SettingsTile(title: "Edit Profile", icon: 'assets/images/edit_icon.svg', onTap: () {}),
          // const SizedBox(height: 26),
          // SettingsTile(title: "Blocked users", icon: 'assets/images/block_user.svg', onTap: () {}),
          // const SizedBox(height: 26),
          // SettingsTile(title: "Delete account", icon: 'assets/images/delete_icon.svg', onTap: () {}),
          // const SizedBox(height: 26),
          // SettingsTile(title: "Privacy policy", icon: 'assets/images/privacy_policy.svg', onTap: () {}),
          // const SizedBox(height: 26),
          SettingsTile(title: "Terms & condition", icon: 'assets/images/terms_condition.svg', onTap: () {}),
          const SizedBox(height: 26),
          SettingsTile(
              title: "Logout",
              icon: 'assets/images/logout_icon.svg',
              onTap: () {
                SharedPrefs.clearAllPref();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
              }),
        ],
      ),
    );
  }
}
