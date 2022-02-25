import 'package:starwars/src/models/gender.dart';

class Character {
  const Character({
    required this.name,
    required this.gender,
    required this.movies,
  });

  final String name;
  final Gender gender;
  final List<String> movies;
}
