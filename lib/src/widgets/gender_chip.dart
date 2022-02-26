import 'package:flutter/material.dart';
import 'package:starwars/src/models/models.dart';

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
