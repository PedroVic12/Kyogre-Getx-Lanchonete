class DataBaseState {
  final bool isLoading;
  final bool hasError;
  final String? error;

  DataBaseState({
    required this.isLoading,
    required this.hasError,
    this.error,
  });

  factory DataBaseState.initial() => DataBaseState(
        isLoading: false,
        hasError: false,
      );

  factory DataBaseState.loading() => DataBaseState(
        isLoading: true,
        hasError: false,
      );

  factory DataBaseState.error(String error) => DataBaseState(
        isLoading: false,
        hasError: true,
        error: error,
      );

  DataBaseState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
  }) {
    return DataBaseState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataBaseState &&
        other.isLoading == isLoading &&
        other.hasError == hasError &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ hasError.hashCode ^ error.hashCode;
}
