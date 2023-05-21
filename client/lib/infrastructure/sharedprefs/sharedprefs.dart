import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // keys
  static String uuidUser = 'UUID';
  static String chatId = '';

  static Future<bool> saveUuidUser(String uuidd) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(uuidUser, uuidd);
  }

  static Future<bool> saveChatId(String chatIdd) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(chatId, chatIdd);
  }

  static Future<String?> getUuidOfUser() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(uuidUser);
  }

  static Future<String?> getChatId() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(chatId);
  }

  static Future<String?> clearAllPref() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.clear();
    return null;
  }
}
