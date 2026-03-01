import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

extension FailureX on Failure {
  String message(BuildContext context) {
    final t = context.l10n;

    return map(
      network: (_) => t.dioNetworkError,
      server: (_) => t.dioServerError,
      unauthorized: (_) => t.dioUnauthorizedError,
      forbidden: (_) => t.dioForbiddenError,
      badRequest: (_) => t.dioBadRequestError,
      serialization: (_) => t.dioSerializationError,
      cancelled: (_) => t.dioCancelledError,
      rateLimited: (_) => t.dioRateLimitedError,
      timeout: (_) => t.dioTimeoutError,
      unexpected: (_) => t.dioUnexpectedError,
    );
  }
}
