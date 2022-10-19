/// アプリ内でデータを扱う際に型を効かせられるようにモデルを定義しましょう。
/// ここではprofilesとmessagesテーブル用のモデルを作ります。
/// その際にfromMapコンストラクターを作って簡単にSupabaseから帰ってきたデータからインスタンスを作れるようにします。

class Park_detail {

  /// User ID of the Parks
  final String parkId;

  /// 市町村 of the Parks
  final String url;

  /// 部落 of the Parks
  final String image1Url;
  final String image2Url;
  final String image3Url;
  final String image4Url;
  final String image5Url;
  final String image6Url;
  final String image7Url;
  final String image8Url;
  final String image9Url;
  final String image10Url;


  /// Parks image URL of the user if present.
  // ignore: non_constant_identifier_names
  final String biko;

  /// Date and time when the Parks was created
  final DateTime createdAt;

  Park_detail({
    required this.parkId,
    required this.url,
    required this.image1Url,
    required this.image2Url,
    required this.image3Url,
    required this.image4Url,
    required this.image5Url,
    required this.image6Url,
    required this.image7Url,
    required this.image8Url,
    required this.image9Url,
    required this.image10Url,
    required this.biko,
    required this.createdAt,
  });

  Park_detail.fromMap(Map<String, dynamic> map)
    : parkId = map['park_id'],
      url = map['url'],
      image1Url = map['image1_url'],
      image2Url = map['image2_url'],
      image3Url = map['image3_url'],
      image4Url = map['image4_url'],
      image5Url = map['image5_url'],
      image6Url = map['image6_url'],
      image7Url = map['image7_url'],
      image8Url = map['image8_url'],
      image9Url = map['image9_url'],
      image10Url = map['image10_url'],
      biko = map['biko'],
      createdAt = DateTime.parse(map['created_at']);
}