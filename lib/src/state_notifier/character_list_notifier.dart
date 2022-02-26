import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars/src/models/models.dart';
import 'package:swapi_repository/swapi_repository.dart';

part 'character_list_state.dart';

final swapiRepository = Provider((_) => SwapiRepository());

class CharacterListNotifier extends StateNotifier<CharacterListState> {
  CharacterListNotifier(this._repository) : super(CharacterListState.init());

  final SwapiRepository _repository;

  Future<void> onCharactersFetched() async {
    if (state.hasReachedMax || state.resultOr.isLoading) return;
    state = state.copyWith(resultOr: const ResultOr.loading());
    try {
      final result = await _repository.fetchPeople(state.index);
      state = state.copyWith(
        index: state.index + 1,
        hasReachedMax: result.next == null,
        characters: List.of(state.characters)..addAll(result.people.toModel),
        resultOr: const ResultOr.success(),
      );
    } catch (_) {
      state = state.copyWith(
        resultOr: ResultOr.failure(CharacterListFailure.serverError()),
      );
    }
  }
}

extension on List<People> {
  List<Character> get toModel => map(
        (p) => Character(
          name: p.name!,
          gender: Gender.fromString(p.gender!),
          movies: p.films,
        ),
      ).toList();
}
