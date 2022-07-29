import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/config/navigation.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/routes.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/item_pokemon_tile_widget.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/favorite_pokemons/favorite_pokemons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePokemonsWidget extends StatefulWidget {
  final Function(int count) favoriteCount;

  const FavoritePokemonsWidget({
    Key? key,
    required this.favoriteCount,
  }) : super(key: key);

  @override
  State<FavoritePokemonsWidget> createState() => _FavoritePokemonsWidgetState();
}

class _FavoritePokemonsWidgetState extends State<FavoritePokemonsWidget>
    with AutomaticKeepAliveClientMixin {
  late PokemonDetailEntity pokemonDetailEntity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavoritePokemonsBloc>().add(GetAllFavoritePokemonsEvent());
      // context
      //     .read<FavoritePokemonsBloc>()
      //     .add(GetAllFavoritePokemonStreamEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritePokemonsBloc, FavoritePokemonsState>(
      builder: (context, state) {
        if (state is NoFavoritePokemonsState) {
          widget.favoriteCount(0);
          return Center(
            child: Text(
              MyLocalizations.of(context).getString("no_favorites"),
              style: FontConstants.fontSemiBoldStyle(
                fontSize: 16,
                fontColor: ColorConstants.black,
              ),
            ),
          );
        } else if (state is AllFavoritePokemonsFoundState) {
          widget.favoriteCount(state.pokemons.length);
          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            itemBuilder: (BuildContext context, int index) {
              double screenWidth = MediaQuery.of(context).size.width;
              return ItemPokemonTileWidget(
                key: ObjectKey(state.pokemons[index]),
                pokemonDetailEntity: state.pokemons[index],
                screenWidth: screenWidth,
                onTileClicked: () {
                  Navigation.intentWithData(
                    context,
                    AppRoutes.pokemonDetailScreen,
                    state.pokemons[index],
                  );
                },
              );
            },
            itemCount: state.pokemons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 186,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
          );
        } else {
          return Center(
            child: Text(
              MyLocalizations.of(context).getString("loading"),
              style: FontConstants.fontSemiBoldStyle(
                fontSize: 14,
                fontColor: ColorConstants.ceruleanBlue,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
