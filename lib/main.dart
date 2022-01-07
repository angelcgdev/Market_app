import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:store_app/provider/animate.dart';
import 'package:store_app/provider/category.dart';
import 'package:store_app/style/theme.dart';
import 'package:store_app/ui/home.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // me vi forzado a usar provider por que tenia que comunicar un widget que estaba muy abajo en el arbol y no queria pasar widget por widget
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => AnimateProvider()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
        ),
        child: MaterialApp(
          title: 'StoreApp',
          theme: MyThemes(context).defaultTheme,
          home: const HomePage(),
        ),
      ),
    );
  }
}