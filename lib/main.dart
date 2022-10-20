import 'package:flutter/material.dart';
import 'package:child_info/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:child_info/pages/splash_page.dart';

import '../config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Supabaseの初期化
  //config_sample.dartをコピーしてconfig.dartを作成
  await Supabase.initialize(
    url: SB_API_KEY,
    anonKey: SB_ANON_KEY,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHILD_INFO',
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}