import 'package:flutter/material.dart';
import 'package:pushkin_app/helpers/colors.dart';

class Themes {
  static var _appBarTheme = AppBarTheme().copyWith(
    backgroundColor: ThemeColors.lightBlue,
    titleTextStyle: const TextStyle(
      //headline 6
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 0.15,
    ),
    foregroundColor: Colors.black,
  );

  static const displayLargeTheme = TextStyle(
    //huge main blue letters
    fontSize: 48.0,
    fontWeight: FontWeight.w700,
    color: ThemeColors.darkBlue,
  );

  static const titleLargeTheme = TextStyle(
    //button text
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.5,
  );

  static const bodyMediumTheme = TextStyle(
    //headline 6
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 0.15,
  );

  static const bodySmallTheme = TextStyle(
    //body 2
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    letterSpacing: 0.25,
  );

  var lightTheme = ThemeData(
    primaryColor: ThemeColors.darkBlue,
    colorScheme:
        ThemeData().colorScheme.copyWith(secondary: ThemeColors.lightBlue),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: displayLargeTheme,
      titleLarge: titleLargeTheme,
      headlineSmall: TextStyle(
        //button text
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
      bodyMedium: bodyMediumTheme,
      bodySmall: bodySmallTheme,
    ),
    appBarTheme: _appBarTheme,
  );

  var darkTheme = ThemeData(
    scaffoldBackgroundColor: ThemeColors.dark,
    primaryColor: ThemeColors.darkBlue,
    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: ThemeColors.lightBlue,
        ),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
        displayLarge: displayLargeTheme,
        headlineSmall: TextStyle(
          //button text
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        titleLarge: titleLargeTheme,
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        bodyMedium: bodyMediumTheme,
        bodySmall: bodySmallTheme,
        titleMedium: TextStyle(color: Colors.white)),
    appBarTheme: _appBarTheme,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return ThemeColors
                .lightBlue; // the color when checkbox is selected;
          }
          return Colors.white; //the color when checkbox is unselected;
        },
      ),
      checkColor: MaterialStateColor.resolveWith((states) => Colors.black),
    ),
  );
}
