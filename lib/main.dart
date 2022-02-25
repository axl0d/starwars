import 'package:flutter/material.dart';
import 'package:starwars/src/models/character.dart';
import 'package:starwars/src/models/gender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starwars',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffa44cd3)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starwars Characters'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (_, index) => Card(
          child: ExpansionTile(
            title: Text(
              character.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: GenderChip(gender: character.gender),
            childrenPadding: const EdgeInsets.all(8),
            children: [
              Text(
                'films cast',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              for (final movie in character.movies)
                Chip(
                  label: Text(movie),
                ),
            ],
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}

class GenderChip extends StatelessWidget {
  const GenderChip({
    Key? key,
    required this.gender,
  }) : super(key: key);

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Chip(
        label: Text(
          gender.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: gender.map(
          male: (_) => const Color(0xff0f4d92),
          female: (_) => const Color(0xfff64a8a),
          na: (_) => const Color(0xffff7518),
        ),
      ),
    );
  }
}

const character = Character(
  name: 'Luke Skywalker',
  gender: Gender.male(),
  movies: [
    'https://swapi.dev/api/films/1/',
    'https://swapi.dev/api/films/2/',
    'https://swapi.dev/api/films/3/',
    'https://swapi.dev/api/films/6/'
  ],
);
