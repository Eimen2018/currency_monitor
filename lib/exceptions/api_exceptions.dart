class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? detail;

  ApiException(this.message, {this.statusCode, this.detail});

  @override
  String toString() =>
      statusCode == null ? message : 'Status: $statusCode, $message -- $detail';
}
