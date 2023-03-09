import 'package:flutter/material.dart';
import 'package:my_chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat_app/helper/shared/provider/home_provider.dart';
import 'package:my_chat_app/helper/shared/provider/register_provider.dart';
import 'package:my_chat_app/helper/shared/theme/my_theme.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:my_chat_app/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'helper/shared/provider/theme-provider.dart';
import 'layout/homeLayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (buildContext) => registerProvider(),
    ),
    ChangeNotifierProvider(
      create: (buildContext) => homeProvider(),
    ),
    ChangeNotifierProvider(create: (buildContext) => themeProvider())
  ], child: const myApp()));
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        homeLayout.routeName: (buildContext) => homeLayout(),
        registerScreen.routeName: (buildContext) => registerScreen(),
        chatScreen.routeName: (buildContext) => chatScreen(),
      },
      initialRoute: homeLayout.routeName,
      theme: myThemeData.themeApp,
    );
  }
}
