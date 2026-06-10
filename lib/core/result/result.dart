abstract class Result<S, F> {
  const Result();

  bool get isSuccess;
  bool get isFailure;

  S? get successValue => null;
  F? get failureValue => null;

  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure);
}

class Success<S, F> extends Result<S, F> {
  final S value;

  const Success(this.value);

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;

  @override
  S get successValue => value;

  @override
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    return onSuccess(value);
  }
}

class FailureValue<S, F> extends Result<S, F> {
  final F value;

  const FailureValue(this.value);

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;

  @override
  F get failureValue => value;

  @override
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    return onFailure(value);
  }
}
