import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/favorite_button/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final PokemonDetailEntity pokemonDetailEntity;

  const FavoriteButtonWidget({
    Key? key,
    required this.pokemonDetailEntity,
  }) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<FavoriteBloc>()
          .add(CheckFavoriteEvent(widget.pokemonDetailEntity.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getFloatingActionButton();
  }

  Widget _getFloatingActionButton() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoadedState) {
          return InkWell(
            onTap: () => state.isFavoriteAdded
                ? _removeFromFavorites()
                : _addToFavorites(),
            child: Container(
              decoration: BoxDecoration(
                  color: _getBackgroundColor(state.isFavoriteAdded),
                  borderRadius: BorderRadius.circular(40)),
              child: state.isFavoriteAdded
                  ? _remoteFavoriteText()
                  : _getMarkFavoriteText(),
              padding: const EdgeInsets.all(16),
            ),
          );
        }
        return Container();
      },
    );
  }

  _addToFavorites() {
    context
        .read<FavoriteBloc>()
        .add(AddFavoriteEvent(widget.pokemonDetailEntity));
  }

  _removeFromFavorites() {
    context
        .read<FavoriteBloc>()
        .add(RemoveFavoriteEvent(widget.pokemonDetailEntity.id));
  }

  Color _getBackgroundColor(bool isFavorite) {
    return isFavorite ? ColorConstants.periwinkle : ColorConstants.ceruleanBlue;
  }

  Widget _getMarkFavoriteText() {
    return Text(
      MyLocalizations.of(context).getString("mark_as_favorite"),
      style: FontConstants.fontBoldStyle(
          fontSize: 14, fontColor: ColorConstants.white),
    );
  }

  Widget _remoteFavoriteText() {
    return Text(
      MyLocalizations.of(context).getString("remove_from_favorites"),
      style: FontConstants.fontBoldStyle(
          fontSize: 14, fontColor: ColorConstants.ceruleanBlue),
    );
  }
}
