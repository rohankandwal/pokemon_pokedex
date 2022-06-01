import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Class containing constants used throughout the app
class Constants {
  static const double FEED_SEARCH_BAR_HEIGHT = 120;
  static const String pokemonBox = "pokemon_box";
  static const String NO_DATA = "no_data";
  static const String APP_NAME = "Pokedex";
  static const String unknownErrorOccurred =
      "Error occurred, please try again later";
  static const String internetErrorOccurred =
      "Please check your internet connection and try again";

  static const String baseUrl = "https://pokeapi.co/api/v2/";
}

class ColorConstants {
  ColorConstants._();

  static const Color ceruleanBlue = Color(0xff3558CD);
  static const Color periwinkle = Color(0xffD5DEFF);
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color mirage = Color(0xff161A33);
  static const Color doveGray = Color(0xff6B6B6B);
  static const Color pepperMint = Color(0xffF3F9EF);
  static const Color wispPink = Color(0xffFDF1F1);
  static const Color foam = Color(0xffF3F9FE);
  static const Color cerise = Color(0xffCD2873);
  static const Color goldTips = Color(0xffEEC218);
  static const Color mercury = Color(0xffE8E8E8);
  static const Color black = Colors.black;
}

class DBConstants {
  DBConstants._();
}

class ImageConstants {
  ImageConstants._();

  static const String icPokedex = "assets/images/ic_pokedex.svg";
  static const String icPokemonOutline = "assets/images/ic_pokemon_outline.svg";
}

class FontConstants {
  FontConstants._();

  static TextStyle fontBoldStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      double height = 1,
      double letterSpacing = 0,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w700,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      height: height,
      letterSpacing: letterSpacing,
      //letterSpacing: -0.10
    );
  }

  static TextStyle fontSemiBoldStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      double height = 1,
      double letterSpacing = 0,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w600,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      height: height,
      letterSpacing: letterSpacing,
      //letterSpacing: -0.10
    );
  }

  static TextStyle fontRegularStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      double height = 1,
      double letterSpacing = 0,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w400,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle fontMediumStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      double height = 1,
      double letterSpacing = 0,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w500,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      //letterSpacing: -0.10
    );
  }

  static TextStyle fontItalicStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      //letterSpacing: -0.10
    );
  }

  static TextStyle _headlineFontStyle({
    double fontSize = 12.0,
    Color fontColor = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 0,
    FontStyle fontStyle = FontStyle.normal,
    double wordSpacing = 0,
    Color backgroundColor = Colors.transparent,
    double height = 1,
  }) {
    final Paint paint = Paint();
    paint.color = backgroundColor;
    return GoogleFonts.notoSans(
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      wordSpacing: wordSpacing,
      decorationThickness: .8,
      decorationStyle: TextDecorationStyle.solid,
      height: height,
      background: paint,
    );
  }
}
