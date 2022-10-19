/// アプリ内でデータを扱う際に型を効かせられるようにモデルを定義しましょう。
/// ここではprofilesとmessagesテーブル用のモデルを作ります。
/// その際にfromMapコンストラクターを作って簡単にSupabaseから帰ってきたデータからインスタンスを作れるようにします。

class Users {

  /// User ID of the profile
  final String id;

  /// Username of the profile
  final String username;

  /// Date and time when the profile was created
  final DateTime createdAt;

  Users({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  Users.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      username = map['username'],
      createdAt = DateTime.parse(map['created_at']);
}