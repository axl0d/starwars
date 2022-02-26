import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars/src/widgets/widgets.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Starwars Characters'),
          centerTitle: true,
          actions: const [FilterButton()],
        ),
        body: const CharacterList(),
      ),
    );
  }
}
