import 'dart:async';

import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/config/navigation.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigation.intentWithClearAllRoutes(context, AppRoutes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorConstants.ceruleanBlue,
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.ceruleanBlue,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _getPokemonAppIcon(),
                    const SizedBox(
                      width: 16,
                    ),
                    _getPokemonAppText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPokemonAppIcon() {
    return SvgPicture.asset(
      ImageConstants.icPokedex,
      width: 75,
      height: 75,
      fit: BoxFit.fill,
    );
  }

  Widget _getPokemonAppText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getPokemonText(),
        const SizedBox(
          height: 4,
        ),
        _getPokeDexText(),
      ],
    );
  }

  Widget _getPokemonText() {
    return Text(
      MyLocalizations.of(context).getString("pokemon").toUpperCase(),
      style: FontConstants.fontRegularStyle(
        fontSize: 16,
        fontColor: ColorConstants.white,
        letterSpacing: 4.3,
      ),
    );
  }

  Widget _getPokeDexText() {
    return Text(
      MyLocalizations.of(context).getString("pokedex"),
      style: FontConstants.fontBoldStyle(
        fontSize: 48,
        fontColor: ColorConstants.white,
        letterSpacing: 0.3,
      ),
    );
  }
}
