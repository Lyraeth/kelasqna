import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

extension FailureX on Failure {
  String message(BuildContext context) {
    final t = context.l10n;

    return map(
      network: (f) => f.errorMessage ?? t.dioNetworkError,
      server: (f) => f.errorMessage ?? t.dioServerError,
      unauthorized: (f) => f.errorMessage ?? t.dioUnauthorizedError,
      forbidden: (f) => f.errorMessage ?? t.dioForbiddenError,
      badRequest: (f) => f.errorMessage ?? t.dioBadRequestError,
      serialization: (f) => f.errorMessage ?? t.dioSerializationError,
      cancelled: (f) => f.errorMessage ?? t.dioCancelledError,
      rateLimited: (f) => f.errorMessage ?? t.dioRateLimitedError,
      timeout: (f) => f.errorMessage ?? t.dioTimeoutError,
      unexpected: (f) => f.errorMessage ?? t.dioUnexpectedError,
    );
  }
}
