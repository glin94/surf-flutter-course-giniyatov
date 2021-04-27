class NetworkException implements Exception {
  NetworkException(
    this.responseName,
    this.codeStatus,
    this.exceptionName,
  );

  final String responseName;
  final int codeStatus;
  final String exceptionName;

  @override
  String toString() =>
      "В запросе $responseName возникла ошибка: $codeStatus $exceptionName";
}
