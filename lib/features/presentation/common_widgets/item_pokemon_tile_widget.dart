import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/extension_function.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class ItemPokemonTileWidget extends StatefulWidget {
  final double screenWidth;
  final Function onTileClicked;
  final PokemonDetailEntity pokemonDetailEntity;

  const ItemPokemonTileWidget({
    Key? key,
    required this.screenWidth,
    required this.onTileClicked,
    required this.pokemonDetailEntity,
  }) : super(key: key);

  @override
  State<ItemPokemonTileWidget> createState() => _ItemPokemonTileWidgetState();
}

class _ItemPokemonTileWidgetState extends State<ItemPokemonTileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTileClicked(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: _getPokemonImage(),
          subtitle: Padding(
            padding:
                const EdgeInsets.only(left: 9, top: 10, right: 9, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getPokemonId(),
                _getSpacing(2),
                _getPokemonName(),
                _getSpacing(12),
                _getPokemonStrength(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSpacing(double spacing) {
    return SizedBox(
      height: spacing,
    );
  }

  Widget _getPokemonImage() {
    return Container(
      color: widget.getRandomColor(0.2, widget.pokemonDetailEntity.hashCode),
      child: NetworkImageWidget(
          width: widget.screenWidth,
          height: 104,
          imageUrl: widget.pokemonDetailEntity.imageUrl ?? ""),
    );
  }

  Widget _getPokemonId() {
    return Text(
      "#${widget.pokemonDetailEntity.id.toString().padLeft(3, '0')}",
      maxLines: 1,
      style: FontConstants.fontRegularStyle(
        fontSize: 12,
        fontColor: ColorConstants.doveGray,
      ),
    );
  }

  Widget _getPokemonName() {
    return Text(
      widget.pokemonDetailEntity.name,
      maxLines: 1,
      style: FontConstants.fontSemiBoldStyle(
          fontSize: 14, fontColor: ColorConstants.black),
    );
  }

  Widget _getPokemonStrength() {
    return Text(
      widget.pokemonDetailEntity.type,
      maxLines: 1,
      style: FontConstants.fontRegularStyle(
          fontSize: 12, fontColor: ColorConstants.doveGray),
    );
  }
}
