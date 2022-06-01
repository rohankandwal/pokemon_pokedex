part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteLoadedState extends FavoriteState {
  final bool isFavoriteAdded;

  FavoriteLoadedState(this.isFavoriteAdded);

  @override
  List<Object?> get props => [isFavoriteAdded];
}
