import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/routes.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/home_screen.dart';
import 'package:byzat_pokemon/features/presentation/pages/pokemon_detail_screen/pokemon_detail_screen.dart';
import 'package:byzat_pokemon/features/presentation/pages/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox<FeedModel>(Constants.FEED_DB);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    // this will change the brightness of the icons
    statusBarColor: ColorConstants.white,
    // or any color you want
    systemNavigationBarIconBrightness:
        Brightness.light, //navigation bar icons' color
  ));

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      locale: const Locale('en'),
      localizationsDelegates: const [MyLocalizationsDelegate()],
      supportedLocales: const [Locale('en')],
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: _registerRoutes(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.splashScreen: (context) => const SplashScreen(),
      AppRoutes.homeScreen: (context) => const HomeScreen(),
      AppRoutes.pokemonDetailScreen: (context) => const PokemonDetailScreen(),
    };
  }
}
