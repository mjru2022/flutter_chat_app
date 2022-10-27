import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/chat_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "usario": (_) => const UsuariosPage(),
  "chat": (_) => const ChatPage(),
  "login": (_) => const LoginPage(),
  "register": (_) => RegisterPage(),
  "loading": (_) => const LoadingPage(),
};
