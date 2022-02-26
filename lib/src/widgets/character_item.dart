import 'package:flutter/material.dart';
import 'package:starwars/src/models/models.dart';
import 'package:starwars/src/widgets/widgets.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ExpansionTile(
        title: Text(
          character.name,
          style: textTheme.headline6,
        ),
        subtitle: GenderChip(gender: character.gender),
        childrenPadding: const EdgeInsets.all(8),
        children: [
          Text(
            'films cast',
            style: textTheme.subtitle1,
          ),
          FilmList(films: character.movies),
        ],
      ),
    );
  }
}
