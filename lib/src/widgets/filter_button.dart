import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GenderFilter {
  all,
  male,
  female,
  na,
}

extension on GenderFilter {
  String get name {
    switch (this) {
      case GenderFilter.all:
        return 'All';
      case GenderFilter.male:
        return 'Male';
      case GenderFilter.female:
        return 'Female';
      case GenderFilter.na:
        return 'N/A';
    }
  }
}

final charactersFilter = StateProvider((_) => GenderFilter.all);

class FilterButton extends ConsumerWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<GenderFilter>(
      icon: const Icon(Icons.filter_alt),
      onSelected: (filter) =>
          ref.read(charactersFilter.notifier).state = filter,
      itemBuilder: (_) => [
        for (final gender in GenderFilter.values)
          PopupMenuItem(
            value: gender,
            child: Text(gender.name),
          ),
      ],
    );
  }
}
