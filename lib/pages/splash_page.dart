import 'package:flutter/material.dart';
import 'package:child_info/pages/index_page.dart';
import 'package:child_info/pages/register.dart';
import 'package:child_info/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


/// ユーザーがアプリを立ち上げたときにそのユーザーがログインしているかどうかに応じて適切なページにリダイレクトしてあげましょう。
/// これをするにはSplashPageというページを作り、その中でログイン状態を判別し適切なページにリダイレクトしてあげます。
/// UIはただ単に真ん中でローダーがくるくる回っているだけのものになります。
/// ここではsupabase_flutterの中にあるonAuthenticatedとonUnauthenticatedメソッドを使います。
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends SupabaseAuthState<SplashPage> {
  @override
  void initState() {
    super.initState();
    recoverSupabaseSession();
  }

@override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }

  @override
  void onAuthenticated(Session session) {
    Navigator.of(context).pushAndRemoveUntil(HomePageALTWidget.route(), (_) => false);
  }

  @override
  void onUnauthenticated() {
    Navigator.of(context)
        .pushAndRemoveUntil(RegisterPage.route(), (_) => false);
  }

  @override
  void onErrorAuthenticating(String message) {}

  @override
  void onPasswordRecovery(Session session) {}
}