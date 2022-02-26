import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars/src/state_notifier/character_list_notifier.dart';

final filmsProvider = FutureProvider.family<List<String>, List<String>>(
  (ref, urls) async {
    final repository = ref.watch(swapiRepository);
    final films = await repository.fetchFilms(urls);
    return films.map((f) => f.title).toList();
  },
);

class FilmList extends ConsumerWidget {
  const FilmList({
    Key? key,
    required this.films,
  }) : super(key: key);

  final List<String> films;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFilms = ref.watch(filmsProvider(films));
    return asyncFilms.when(
      data: (films) => Wrap(
        children: [
          for (final film in films)
            Chip(
              label: Text(film),
            ),
        ],
      ),
      error: (_, __) => const Center(child: Text('error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
