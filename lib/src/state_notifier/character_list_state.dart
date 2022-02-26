part of 'character_list_notifier.dart';

class CharacterListState {
  const CharacterListState({
    required this.characters,
    required this.resultOr,
    required this.index,
    required this.hasReachedMax,
  });

  factory CharacterListState.init() => const CharacterListState(
        characters: [],
        resultOr: ResultOrNone(),
        index: 1,
        hasReachedMax: false,
      );

  final List<Character> characters;
  final ResultOr<CharacterListFailure> resultOr;
  final int index;
  final bool hasReachedMax;

  CharacterListState copyWith({
    List<Character>? characters,
    ResultOr<CharacterListFailure>? resultOr,
    int? index,
    bool? hasReachedMax,
  }) =>
      CharacterListState(
        characters: characters ?? this.characters,
        resultOr: resultOr ?? this.resultOr,
        index: index ?? this.index,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );
}
