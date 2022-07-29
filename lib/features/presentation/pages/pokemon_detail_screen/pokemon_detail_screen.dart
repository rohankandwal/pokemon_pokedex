import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/config/navigation.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/extension_function.dart';
import 'package:byzat_pokemon/core/utils/utility.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/custom_spacer_widget.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/favorite_button/favorite_bloc.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/favorite_button/favorite_button_widget.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/network_image_widget.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/rounded_linear_progress_indicator_widget.dart';
import 'package:byzat_pokemon/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonDetailScreen extends StatefulWidget {
  // final PokemonDetailEntity pokemonDetailEntity;

  const PokemonDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late Color _backgroundColor;
  final double _bottomBarSize = 78, _bottomSpacing = 20, _topSpacing = 8;
  double _averagePower = 0;
  PokemonDetailEntity? _pokemonDetailEntity;

  @override
  void initState() {
    super.initState();
    _backgroundColor =
        widget.getRandomColor(0.2, _pokemonDetailEntity.hashCode);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //get pokemon from route if not provided
      _pokemonDetailEntity =
          ModalRoute.of(context)?.settings.arguments as PokemonDetailEntity;
      setState(() {});
      //check if pokemon is favorite
      // checkFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _pokemonDetailEntity == null
          ? Container()
          : _getFloatingActionButton(),
      body: Container(
        color: ColorConstants.mercury,
        child: CustomScrollView(
          slivers: [
            _getSliverAppBar(),
            _getSliverSpacing(height: _topSpacing),
            _getSliverBody(),
            _getSliverSpacing(height: _bottomSpacing),
          ],
        ),
      ),
    );
  }

  Widget _getFloatingActionButton() {
    return BlocProvider<FavoriteBloc>(
      create: (context) => sl<FavoriteBloc>(),
      child: FavoriteButtonWidget(pokemonDetailEntity: _pokemonDetailEntity!),
    );
  }

  SliverAppBar _getSliverAppBar() {
    return SliverAppBar(
      floating: false,
      pinned: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      bottom: _getPokemonHeightWeightAndBMI(),
      toolbarHeight: kToolbarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: getAppBarBackground(),
      ),
      leading: InkWell(
        onTap: () => Navigation.back(context),
        child: const Icon(
          Icons.arrow_back_ios_sharp,
          color: ColorConstants.black,
        ),
      ),
      //FlexibleSpaceBar
      expandedHeight: 320,
      backgroundColor: Colors.white,
      // backgroundColor: _backgroundColor.withOpacity(0.1),
    );
  }

  Container getAppBarBackground() {
    return Container(
      color: _backgroundColor,
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(1, 0.5),
            child: SvgPicture.asset(ImageConstants.icPokemonOutline),
          ),
          Align(
            alignment: const Alignment(0.9, 0.50),
            child: NetworkImageWidget(
              imageUrl: _pokemonDetailEntity?.imageUrl ?? "",
              width: 136,
              height: 125,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: const Alignment(-1, -0.2),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _pokemonDetailEntity?.name.capitalizeFirstOfEach() ?? "",
                    style: FontConstants.fontBoldStyle(
                      fontColor: ColorConstants.mirage,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    _pokemonDetailEntity?.type ?? "",
                    style: FontConstants.fontRegularStyle(
                      fontColor: ColorConstants.mirage,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1, 0.5),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "#${_pokemonDetailEntity?.id.toString().padLeft(3, '0')}",
                style: FontConstants.fontRegularStyle(
                  fontColor: ColorConstants.mirage,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSize _getPokemonHeightWeightAndBMI() {
    return PreferredSize(
        child: Container(
          color: ColorConstants.white,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _getInformationColumn(
                  label: MyLocalizations.of(context).getString("height"),
                  info: _pokemonDetailEntity?.height.toString() ?? "0"),
              const CustomSpacerWidget(width: 48),
              _getInformationColumn(
                  label: MyLocalizations.of(context).getString("weight"),
                  info: _pokemonDetailEntity?.weight.toString() ?? "0"),
              const CustomSpacerWidget(width: 48),
              _getInformationColumn(
                  label: MyLocalizations.of(context).getString("bmi"),
                  info: Utility()
                      .getBMI((_pokemonDetailEntity?.weight.toDouble() ?? 0.0),
                          (_pokemonDetailEntity?.height.toDouble() ?? 0.0))
                      .toString()),
            ],
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, _bottomBarSize));
  }

  Widget _getInformationColumn(
      {required final String label, required final String info}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getInformationHeading(label: label),
        const CustomSpacerWidget(
          height: 4,
        ),
        _getInformationData(info: info),
      ],
    );
  }

  Widget _getInformationHeading(
      {required final String label, final double fontSize = 12}) {
    return Text(
      label,
      style: FontConstants.fontMediumStyle(
          fontSize: fontSize, fontColor: ColorConstants.doveGray),
    );
  }

  Widget _getInformationData({
    required final String info,
  }) {
    return Text(
      info,
      style: FontConstants.fontRegularStyle(
          fontSize: 14, fontColor: ColorConstants.mirage),
    );
  }

  Widget _getSliverSpacing({required final double height}) {
    return SliverToBoxAdapter(
      child: CustomSpacerWidget(
        height: height,
      ),
    );
  }

  SliverToBoxAdapter _getSliverBody() {
    double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
        color: ColorConstants.white,
        height: MediaQuery.of(context).size.height -
            _topSpacing -
            _bottomBarSize -
            _bottomSpacing -
            kToolbarHeight -
            MediaQuery.of(context).viewPadding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getBaseStatsHeading(),
            _getDivider(),
            ListView(
              padding: const EdgeInsets.only(top: 8),
              children: _getPower(width),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            _getPowerHeading(
              heading: MyLocalizations.of(context).getString("avg_power"),
              data: _averagePower.toInt().toString(),
            ),
            _getProgressIndicator(
              width: width,
              backgroundColor: ColorConstants.mercury,
              radius: 30,
              valueColor: ColorConstants.cerise,
              progress: _averagePower,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPower(double width) {
    final List<Widget> _powers = List.empty(growable: true);
    if (_pokemonDetailEntity == null) {
      return _powers;
    }
    double total = 0;
    for (var element in _pokemonDetailEntity!.stats) {
      _powers.add(_getPowerHeading(
        heading: element.name.optimizeString().capitalizeFirstOfEach(),
        data: element.baseStat.toString(),
      ));
      _powers.add(_getProgressIndicator(
        width: width,
        backgroundColor: ColorConstants.mercury,
        radius: 30,
        valueColor: _getValueColor(
            element.name.optimizeString().capitalizeFirstOfEach()),
        progress: element.baseStat.toDouble(),
      ));
      total += element.baseStat;
    }
    _averagePower = total / _pokemonDetailEntity!.stats.length;
    return _powers;
  }

  Color _getValueColor(final String stat) {
    if (stat.toLowerCase().trim() == "special attack" ||
        stat.toLowerCase().trim() == "special defense") {
      return ColorConstants.goldTips;
    }
    return ColorConstants.cerise;
  }

  Widget _getBaseStatsHeading() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 12,
        bottom: 12,
      ),
      child: Text(
        MyLocalizations.of(context).getString("base_stats"),
        style: FontConstants.fontSemiBoldStyle(
            fontSize: 16, fontColor: ColorConstants.mirage),
      ),
    );
  }

  Widget _getDivider() {
    return Container(
      color: ColorConstants.mercury,
      height: 1,
    );
  }

  Widget _getPowerHeading({
    required final String heading,
    required final String data,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16,
        bottom: 8,
      ),
      child: Row(
        children: [
          _getInformationHeading(label: heading, fontSize: 14),
          const CustomSpacerWidget(
            width: 8,
          ),
          _getInformationData(info: data),
        ],
      ),
    );
  }

  Widget _getProgressIndicator({
    required final double width,
    required final double radius,
    required final Color valueColor,
    required final Color backgroundColor,
    required final double progress,
    final double height = 4,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8, right: 16),
      child: RoundedLinearProgressIndicator(
        key: UniqueKey(),
        width: width,
        height: height,
        backgroundColor: backgroundColor,
        radius: radius,
        valueColor: valueColor,
        progress: progress,
      ),
    );
  }
}
