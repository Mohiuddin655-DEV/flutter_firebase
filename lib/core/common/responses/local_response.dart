class LocalResponse<T> {
  final bool isCancel;
  final bool isSuccessful;
  final bool isFailed;
  final T? result;
  final String error;

  const LocalResponse({
    this.result,
    this.error = '',
    this.isCancel = false,
    this.isSuccessful = false,
    this.isFailed = false,
  });

  LocalResponse<T> copyWith({
    bool? isCancel,
    bool? isSuccessful,
    bool? isFailed,
    T? result,
    String? error,
  }) {
    return LocalResponse(
      isCancel: isCancel ?? this.isCancel,
      isSuccessful: isSuccessful ?? result != null ? true : this.isSuccessful,
      isFailed: isFailed ?? error != null ? true : this.isFailed,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
