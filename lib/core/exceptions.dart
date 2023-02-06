class UnhandledException implements Exception {
  final String? message;
  final String? from;

  UnhandledException([this.message, this.from]);

  @override
  String toString() {
    return '''
Unhandled exception: ${message ?? 'Unkown'}
             from: $from
''';
  }
}

class DataNotFoundException implements Exception {
  final String message;
  final String? from;

  DataNotFoundException(this.message, [this.from]);

  @override
  String toString() {
    return '''
DataNotFound exception: $message not found
               from: $from
''';
  }
}
