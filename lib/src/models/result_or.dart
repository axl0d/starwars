abstract class ResultOr<F> {
  const ResultOr();
  const factory ResultOr.none() = ResultOrNone;
  const factory ResultOr.loading() = ResultOrLoading;
  const factory ResultOr.success() = ResultOrSuccess;
  const factory ResultOr.failure(F failure) = ResultOrFailure;

  bool get isNone => this is ResultOrNone;
  bool get isLoading => this is ResultOrLoading;
  bool get isSuccess => this is ResultOrSuccess;
  bool get isFailure => this is ResultOrFailure;

  void whenIsFailure(void Function(F failure) isFailure) {
    if (this is ResultOrFailure) {
      isFailure.call((this as ResultOrFailure).failure as F);
    }
  }

  void whenIsSuccess(void Function() isSuccess) {
    if (this is ResultOrSuccess) {
      isSuccess.call();
    }
  }

  void when({
    required void Function() isNone,
    required void Function() isLoading,
    required void Function(F) isFailure,
    required void Function() isSuccess,
  }) {
    if (this is ResultOrNone) {
      return isNone.call();
    }

    if (this is ResultOrLoading) {
      return isLoading.call();
    }

    if (this is ResultOrFailure) {
      return isFailure.call((this as ResultOrFailure).failure as F);
    }

    if (this is ResultOrSuccess) {
      return isSuccess.call();
    }

    isNone.call();
  }

  R map<R>({
    required R Function() isNone,
    required R Function() isLoading,
    required R Function(F) isFailure,
    required R Function() isSuccess,
  }) {
    if (this is ResultOrNone) {
      return isNone.call();
    }

    if (this is ResultOrLoading) {
      return isLoading.call();
    }

    if (this is ResultOrFailure) {
      return isFailure.call((this as ResultOrFailure).failure as F);
    }

    if (this is ResultOrSuccess) {
      return isSuccess.call();
    }

    return isNone.call();
  }

  void maybeWhen({
    void Function()? isNone,
    void Function()? isLoading,
    void Function(F)? isFailure,
    void Function()? isSuccess,
    required void Function() orElse,
  }) {
    if (this is ResultOrNone && isNone != null) {
      return isNone.call();
    }

    if (this is ResultOrLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is ResultOrFailure && isFailure != null) {
      return isFailure.call((this as ResultOrFailure).failure as F);
    }

    if (this is ResultOrSuccess && isSuccess != null) {
      return isSuccess.call();
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function()? isNone,
    R Function()? isLoading,
    R Function(F)? isFailure,
    R Function()? isSuccess,
    required R Function() orElse,
  }) {
    if (this is ResultOrNone && isNone != null) {
      return isNone.call();
    }

    if (this is ResultOrLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is ResultOrFailure && isFailure != null) {
      return isFailure.call((this as ResultOrFailure).failure as F);
    }

    if (this is ResultOrSuccess && isSuccess != null) {
      return isSuccess.call();
    }

    return orElse.call();
  }
}

class ResultOrNone<F> extends ResultOr<F> {
  const ResultOrNone();
}

class ResultOrFailure<F> extends ResultOr<F> {
  const ResultOrFailure(this.failure);

  final F failure;
}

class ResultOrSuccess<F> extends ResultOr<F> {
  const ResultOrSuccess();
}

class ResultOrLoading<F> extends ResultOr<F> {
  const ResultOrLoading();
}
