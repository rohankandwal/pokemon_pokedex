import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/custom_rounded_tab_indicator.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/custom_spacer_widget.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/all_pokemons/all_pokemons_bloc.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/all_pokemons/all_pokemons_widget.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/favorite_pokemons/favorite_pokemons_bloc.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/favorite_pokemons/favorite_pokemons_widget.dart';
import 'package:byzat_pokemon/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// Used to determine which tab is currently active,
  /// used to change the text color of tab text
  final ValueNotifier<int> _tabChangeNotifier = ValueNotifier(1);
  final ValueNotifier<int> _favoriteListCountNotifier = ValueNotifier(0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tabController.animateTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: _getAppBar(),
      body: SafeArea(
        child: _getBody(),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 2,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: ColorConstants.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getPokemonAppIcon(),
          _getSpacing(8),
          _getPokeDexText(),
        ],
      ),
      bottom: TabBar(
        controller: _tabController,
        onTap: (int index) => _tabChangeNotifier.value = (index),
        tabs: _getTabs(),
        indicator: const CustomRoundedTabIndicator(
          indicatorHeight: 4,
          color: ColorConstants.ceruleanBlue,
        ),
      ),
    );
  }

  List<Widget> _getTabs() {
    return [
      Tab(
        child: _getTabText(key: "all_pokemons", index: 0),
      ),
      Tab(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getTabText(key: "favorites", index: 1),
            _getSpacing(4),
            ValueListenableBuilder(
              valueListenable: _favoriteListCountNotifier,
              builder: (context, int value, child) {
                return Visibility(
                  visible: value != 0,
                  child: CircleAvatar(
                    backgroundColor: ColorConstants.ceruleanBlue,
                    radius: 16,
                    child: Text(
                      value.toString(),
                      style: FontConstants.fontRegularStyle(
                        fontSize: 16,
                        fontColor: ColorConstants.white,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    ];
  }

  Widget _getTabText({required final String key, required final int index}) {
    return ValueListenableBuilder(
      valueListenable: _tabChangeNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          MyLocalizations.of(context).getString(key),
          style: FontConstants.fontMediumStyle(
            fontColor: index == value
                ? ColorConstants.mirage
                : ColorConstants.doveGray,
            fontSize: 16,
          ),
        );
      },
    );
  }

  Widget _getPokemonAppIcon() {
    return SvgPicture.asset(
      ImageConstants.icPokedex,
      width: 24,
      height: 24,
      fit: BoxFit.fill,
    );
  }

  Widget _getPokeDexText() {
    return Text(
      MyLocalizations.of(context).getString("pokedex"),
      style: FontConstants.fontBoldStyle(
        fontSize: 24,
        fontColor: ColorConstants.mirage,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _getBody() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        BlocProvider<AllPokemonsBloc>(
          create: (context) => sl<AllPokemonsBloc>(),
          child: AllPokemonsWidget(
            key: UniqueKey(),
          ),
        ),
        BlocProvider<FavoritePokemonsBloc>(
          create: (context) => sl<FavoritePokemonsBloc>(),
          child: FavoritePokemonsWidget(
            key: UniqueKey(),
            favoriteCount: (final int length) {
              Future.delayed(const Duration(milliseconds: 1000), () {
                _favoriteListCountNotifier.value = length;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getSpacing(double spacing) {
    return CustomSpacerWidget(
      width: spacing,
    );
  }
}
