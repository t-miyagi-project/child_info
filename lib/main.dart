import 'package:flutter/material.dart';
import 'package:child_info/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:child_info/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mmsvuxccinqbrfobnbls.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1tc3Z1eGNjaW5xYnJmb2JuYmxzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU2Mzc0NTMsImV4cCI6MTk4MTIxMzQ1M30.ExC0asv3Ie5rZ4S5-Y6U-ybohCTpZmh2Rm-c9AydLPM',
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