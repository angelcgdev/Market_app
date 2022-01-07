import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  final BuildContext context;
  MyThemes(this.context);
  
  ThemeData get defaultTheme {
    final theme = Theme.of(context);

    return ThemeData(
      primaryColor: const Color.fromRGBO(49, 70, 189, 1),
      backgroundColor: const Color.fromRGBO(239, 242, 247, 1),
      colorScheme: theme.colorScheme.copyWith(
        onBackground: Colors.black
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.cardo(fontSize: 24),
        headline3: GoogleFonts.cardo(fontSize: 16, fontWeight: FontWeight.bold),
        headline4: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
      )
    );
  }

}
