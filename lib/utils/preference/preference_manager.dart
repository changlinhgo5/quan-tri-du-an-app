abstract class PreferenceManager {
  static const keyToken = "token";
  static const keyTheme = "theme";
  // static const accessToken = "accessToken";

  static const user = "user";

  static const guildPratice = "guild_practice";
  static const showIntro = 'show_intro';

  Future<dynamic> readStore({required String key});
  Future<void> writeStore({required String key, required dynamic value});

  Future<void> remove(String key);
  Future<bool> clear();
}
