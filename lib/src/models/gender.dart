abstract class Gender {
  const Gender();
  const factory Gender.male() = GenderMale;
  const factory Gender.female() = GenderFemale;
  const factory Gender.na() = GenderNA;

  factory Gender.fromString(String value) {
    if (value == 'male') {
      return const Gender.male();
    }

    if (value == 'female') {
      return const Gender.female();
    }

    if (value == 'n/a') {
      return const Gender.na();
    }

    return const Gender.male();
  }

  void when({
    required void Function(GenderMale) male,
    required void Function(GenderFemale) female,
    required void Function(GenderNA) na,
  }) {
    if (this is GenderMale) {
      male.call(this as GenderMale);
    }

    if (this is GenderFemale) {
      female.call(this as GenderFemale);
    }

    if (this is GenderNA) {
      na.call(this as GenderNA);
    }

    male.call(this as GenderMale);
  }

  R map<R>({
    required R Function(GenderMale) male,
    required R Function(GenderFemale) female,
    required R Function(GenderNA) na,
  }) {
    if (this is GenderMale) {
      return male.call(this as GenderMale);
    }

    if (this is GenderFemale) {
      return female.call(this as GenderFemale);
    }

    if (this is GenderNA) {
      return na.call(this as GenderNA);
    }

    return male.call(this as GenderMale);
  }

  void maybeWhen({
    void Function(GenderMale)? male,
    void Function(GenderFemale)? female,
    void Function(GenderNA)? na,
    required void Function() orElse,
  }) {
    if (this is GenderMale && male != null) {
      male.call(this as GenderMale);
    }

    if (this is GenderFemale && female != null) {
      female.call(this as GenderFemale);
    }

    if (this is GenderNA && na != null) {
      na.call(this as GenderNA);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(GenderMale)? male,
    R Function(GenderFemale)? female,
    R Function(GenderNA)? na,
    required R Function() orElse,
  }) {
    if (this is GenderMale && male != null) {
      return male.call(this as GenderMale);
    }

    if (this is GenderFemale && female != null) {
      return female.call(this as GenderFemale);
    }

    if (this is GenderNA && na != null) {
      return na.call(this as GenderNA);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is GenderMale) {
      return 'male';
    }

    if (this is GenderFemale) {
      return 'female';
    }

    if (this is GenderNA) {
      return 'n/a';
    }

    return 'male';
  }
}

class GenderMale extends Gender {
  const GenderMale();
}

class GenderFemale extends Gender {
  const GenderFemale();
}

class GenderNA extends Gender {
  const GenderNA();
}
