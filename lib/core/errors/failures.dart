abstract class Failure {
  /// The “raw” message from the exception or API
  final String? rawMessage;

  /// A generic code you can switch on (e.g. HTTP status, DioErrorType index)
  final int? code;

  Failure({this.rawMessage, this.code});

  /// The message you actually show to users.
  /// Subclasses can override to provide custom text.
  String get displayMessage => rawMessage ?? 'Something went wrong.';

  @override
  String toString() => displayMessage;
}

class NetworkFailure extends Failure {
  NetworkFailure({super.rawMessage, super.code});

  @override
  String get displayMessage {
    // You can still log rawMessage for diagnostics,
    // but show a simpler message to the user:
    return 'Unable to connect. Please check your internet and try again.';
  }
}

class ServerFailure extends Failure {
  ServerFailure({required int statusCode, String? rawMessage})
    : super(rawMessage: rawMessage, code: statusCode);

  @override
  String get displayMessage {
    switch (code) {
      case 400:
        return 'Bad request. Please retry.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try later.';
      default:
        return rawMessage ?? 'Server error ($code).';
    }
  }
}

class ParsingFailure extends Failure {
  ParsingFailure({String? rawMessage})
    : super(rawMessage: rawMessage, code: null);

  @override
  String get displayMessage => 'Data error. Please contact support.';
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({String? rawMessage})
    : super(rawMessage: rawMessage, code: null);

  @override
  String get displayMessage =>
      rawMessage ?? 'Something went wrong. Please try again.';
}
