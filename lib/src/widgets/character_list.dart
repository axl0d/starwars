import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars/src/models/models.dart';
import 'package:starwars/src/state_notifier/character_list_notifier.dart';
import 'package:starwars/src/widgets/widgets.dart';

final filteredCharacters = Provider(
  (ref) {
    final gender = ref.watch(charactersFilter);
    final characters = ref.watch(
      charactersProvider.select((value) => value.characters),
    );
    switch (gender) {
      case GenderFilter.male:
        return characters
            .where((character) => character.gender is GenderMale)
            .toList();
      case GenderFilter.female:
        return characters
            .where((character) => character.gender is GenderFemale)
            .toList();
      case GenderFilter.na:
        return characters
            .where((character) => character.gender is GenderNA)
            .toList();
      case GenderFilter.all:
        return characters;
    }
  },
);

final charactersProvider =
    StateNotifierProvider<CharacterListNotifier, CharacterListState>(
  (ref) {
    final repository = ref.watch(swapiRepository);
    return CharacterListNotifier(repository)..onCharactersFetched();
  },
);

class CharacterList extends ConsumerStatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterListState();
}

class _CharacterListState extends ConsumerState<CharacterList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(charactersProvider.notifier).onCharactersFetched();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final characterListState = ref.watch(charactersProvider);
        final characters = ref.watch(filteredCharacters);
        if (characters.isEmpty && characterListState.resultOr.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (characterListState.resultOr.isFailure) {
          return const Center(child: Text('Error'));
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          itemBuilder: (_, index) => index >= characters.length &&
                  characterListState.resultOr.isLoading
              ? const Center(child: CircularProgressIndicator())
              : CharacterItem(character: characters[index]),
          itemCount: characterListState.resultOr.isLoading
              ? characters.length + 1
              : characters.length,
        );
      },
    );
  }
}
