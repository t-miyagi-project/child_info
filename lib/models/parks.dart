/// アプリ内でデータを扱う際に型を効かせられるようにモデルを定義しましょう。
/// ここではprofilesとmessagesテーブル用のモデルを作ります。
/// その際にfromMapコンストラクターを作って簡単にSupabaseから帰ってきたデータからインスタンスを作れるようにします。

class Parks {

  /// User ID of the Parks
  final String id;

  final String name;

  /// 市町村 of the Parks
  final String zipAddress1;

  /// 部落 of the Parks
  final String zipAddress2;

  /// Parks image URL of the user if present.
  final String mainImageUrl;

  /// Date and time when the Parks was created
  final DateTime createdAt;

  Parks({
    required this.id,
    required this.name,
    required this.zipAddress1,
    required this.zipAddress2,
    required this.mainImageUrl,
    required this.createdAt,
  });

  Parks.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      zipAddress1 = map['zip_address1'],
      zipAddress2 = map['zip_address2'],
      mainImageUrl = map['main_image_url'],
      createdAt = DateTime.parse(map['created_at']);

  ///// Supabase に保存できるように、オブジェクトを Map に変換する。
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'zipAddress1': zipAddress1,
      'zipAddress2': zipAddress2,
      'mainImageUrl': mainImageUrl,
    };
  }

  /// Supabase の生データをリストに変換する。
  static List<Parks> parksFromData({
    required List<dynamic> data,
  }) {
    return data
        .map<Parks>((row) => Parks(
              id: row['id'] as String,
              name: row['name'] as String,
              zipAddress1: row['zipAddress1'] as String,
              zipAddress2: row['zipAddress2'] as String,
              mainImageUrl: row['mainImageUrl'] as String,
              createdAt: DateTime.parse(row['created_at'] as String),
            ))
        .toList();
  }
}