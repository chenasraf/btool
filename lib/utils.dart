class BToolException implements Exception {
  final String message;
  BToolException(this.message);

  @override
  String toString() => message;
}
