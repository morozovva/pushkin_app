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
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
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
                ? TabsScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, res) => AuthScreen(),
                  ),
            routes: {
              MuseumScreen.routeName: (context) => MuseumScreen(),
              ExhibitionListScreen.routeName: (context) =>
                  ExhibitionListScreen(),
              ExhibitionScreen.routeName: (context) => ExhibitionScreen(),
              ItemListScreen.routeName: (context) => ItemListScreen(),
              ItemScreen.routeName: (context) => ItemScreen(),
              QRScreen.routeName: (context) => QRScreen(),
            },
          ),
        ));
  }
}
