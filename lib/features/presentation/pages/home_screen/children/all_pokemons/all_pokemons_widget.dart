import 'package:byzat_pokemon/core/config/localization.dart';
import 'package:byzat_pokemon/core/config/navigation.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/extension_function.dart';
import 'package:byzat_pokemon/core/utils/routes.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/item_pokemon_tile_widget.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/all_pokemons/all_pokemons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllPokemonsWidget extends StatefulWidget {
  const AllPokemonsWidget({Key? key}) : super(key: key);

  @override
  State<AllPokemonsWidget> createState() => _AllPokemonsWidgetState();
}

class _AllPokemonsWidgetState extends State<AllPokemonsWidget>
    with AutomaticKeepAliveClientMixin {
  final List<PokemonDetailEntity> pokemons = List.empty(growable: true);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllPokemonsBloc, AllPokemonsState>(
      builder: (context, state) {
        if (state is AllPokemonsErrorState) {
          _refreshController.loadFailed();
          _refreshController.refreshFailed();
        }
        if (pokemons.isEmpty && state is AllPokemonsErrorState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: FontConstants.fontSemiBoldStyle(
                      fontSize: 14, fontColor: ColorConstants.mirage),
                ),
                ElevatedButton(
                  onPressed: () => _onRefresh(),
                  child: Text(
                    MyLocalizations.of(context).getString("retry"),
                    style: FontConstants.fontSemiBoldStyle(
                        fontSize: 12, fontColor: ColorConstants.white),
                  ),
                ),
              ],
            ),
          );
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            _offset = 0;
            _onRefresh();
          },
          onLoading: () {
            _offset += 10;
            _onRefresh();
          },
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (pokemons.isEmpty) {
                body = Container();
              } else if (mode == LoadStatus.idle) {
                body = Text(
                  MyLocalizations.of(context).getString("pull_up_to_load_more"),
                  style: FontConstants.fontSemiBoldStyle(
                      fontSize: 12, fontColor: ColorConstants.mirage),
                );
              } else if (mode == LoadStatus.loading) {
                body = const CircularProgressIndicator(
                  color: ColorConstants.mirage,
                );
              } else if (mode == LoadStatus.failed) {
                body = Text(
                  MyLocalizations.of(context).getString("loading_failed"),
                  style: FontConstants.fontSemiBoldStyle(
                      fontSize: 12, fontColor: ColorConstants.mirage),
                );
              } else if (mode == LoadStatus.canLoading) {
                body = Text(
                  MyLocalizations.of(context).getString("release_to_load_more"),
                  style: FontConstants.fontSemiBoldStyle(
                      fontSize: 12, fontColor: ColorConstants.mirage),
                );
              } else {
                body = Text(
                  MyLocalizations.of(context).getString("no_more_data"),
                  style: FontConstants.fontSemiBoldStyle(
                      fontSize: 12, fontColor: ColorConstants.mirage),
                );
              }
              return SizedBox(
                height: 55.0,
                child: Align(alignment: Alignment.bottomCenter, child: body),
              );
            },
          ),
          controller: _refreshController,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            itemBuilder: (BuildContext context, int index) {
              double screenWidth = MediaQuery.of(context).size.width;
              return ItemPokemonTileWidget(
                key: UniqueKey(),
                pokemonDetailEntity: pokemons[index],
                screenWidth: screenWidth,
                onTileClicked: () {
                  Navigation.intentWithData(
                      context, AppRoutes.pokemonDetailScreen, pokemons[index]);
                },
              );
            },
            itemCount: pokemons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 186,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AllPokemonsLoadedState) {
          if (_offset == 0) {
            pokemons.clear();
          }
          pokemons.addAll(state.pokemons);
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        } else if (state is AllPokemonsErrorState) {
          widget.showErrorToast(message: state.message);
          _refreshController.loadFailed();
        }
      },
    );
  }

  _onRefresh() {
    context
        .read<AllPokemonsBloc>()
        .add(GetAllPokemonListEvent(offset: _offset));
  }

  @override
  bool get wantKeepAlive => true;
}
