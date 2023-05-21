import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'helpers/filter_helper.dart';
import 'provider/exhibition_provider.dart';
import 'provider/item_provider.dart';
import 'provider/museum_provider.dart';
import 'screen/auth_screen.dart';
import 'screen/exhibition_list_screen.dart';
import 'screen/exhibition_screen.dart';
import 'screen/item_list_screen.dart';
import 'screen/item_screen.dart';
import 'screen/museum_screen.dart';
import 'screen/qr_screen.dart';
import 'helpers/themes.dart';
import 'provider/auth_provider.dart';
import 'screen/tabs_screen.dart';

Future<void> main() async {
  // Show splash screen for 1 second
  runApp(
    SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Image.asset(
          'assets/SplashScreen.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: 1));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => MuseumProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ExhibitionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ItemProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterHelper(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            title: 'PushkinApp',
            themeMode: ThemeMode.system,
            darkTheme: Themes().darkTheme,
            theme: Themes().lightTheme,
            home: auth.isAuth
                ? const TabsScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, res) => const AuthScreen(),
                  ),
            routes: {
              MuseumScreen.routeName: (context) => const MuseumScreen(),
              ExhibitionListScreen.routeName: (context) =>
                  const ExhibitionListScreen(),
              ExhibitionScreen.routeName: (context) => const ExhibitionScreen(),
              ItemListScreen.routeName: (context) => const ItemListScreen(),
              ItemScreen.routeName: (context) => const ItemScreen(),
              QRScreen.routeName: (context) => const QRScreen(),
            },
          ),
        ));
  }
}
