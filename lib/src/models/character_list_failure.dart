abstract class CharacterListFailure {
  const CharacterListFailure();
  factory CharacterListFailure.serverError() = CharacterListFailureServerError;

  factory CharacterListFailure.fromString(String value) {
    if (value == 'serverError') {
      return CharacterListFailure.serverError();
    }

    return CharacterListFailure.serverError();
  }

  void when({
    required void Function(CharacterListFailureServerError) serverError,
  }) {
    if (this is CharacterListFailureServerError) {
      serverError.call(this as CharacterListFailureServerError);
    }

    serverError.call(this as CharacterListFailureServerError);
  }

  R map<R>({
    required R Function(CharacterListFailureServerError) serverError,
  }) {
    if (this is CharacterListFailureServerError) {
      return serverError.call(this as CharacterListFailureServerError);
    }

    return serverError.call(this as CharacterListFailureServerError);
  }

  void maybeWhen({
    void Function(CharacterListFailureServerError)? serverError,
    required void Function() orElse,
  }) {
    if (this is CharacterListFailureServerError && serverError != null) {
      serverError.call(this as CharacterListFailureServerError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(CharacterListFailureServerError)? serverError,
    required R Function() orElse,
  }) {
    if (this is CharacterListFailureServerError && serverError != null) {
      return serverError.call(this as CharacterListFailureServerError);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is CharacterListFailureServerError) {
      return 'serverError';
    }

    return 'serverError';
  }
}

class CharacterListFailureServerError extends CharacterListFailure {}
